-- === Finicky ===
--
-- Acts as a default browser to handle HTTP(S) URLs, transforming and routing
-- them to specific browsers. Inspired and loosely based on
-- https://github.com/johnste/finicky.
--
-- all URLs received are un-shortened, rewritten and handled, in this specific
-- order.
--
-- Un-shorting is recursive, so even if a URL is shortened multiple times, it'll
-- resolve to a final URL before proceeding.
--
-- Rewrites are executed in the order they are provided. That means if you want
-- to fully transform a URL somehow (e.g. remove a tracking prefix + unescape)
-- you must order the `rewrites` table properly.
--
-- Finally, the resulting URL will be handled by one of the `handlers`, also in
-- order. It'll ultimately fall back to the `defaultBrowser`.
--

---@alias RewriteMatchFn fun(url:URLInstance): boolean
---@alias RewriteTransformFn fun(url:URLInstance): string|URLInstance

---@class Rewrite
-- regexp to match the URL
---@field match string|string[]|RewriteMatchFn
-- transformer to alter the URL
---@field url string|RewriteTransformFn

---@alias BrowserCallback fun(fullURL:string): boolean

---@class Handler
-- absolute host of the URL
---@field host string|string[]
-- regexp host expression
---@field match string|string[]
-- source application where the URL was activated at
---@field sender string|string[]
-- target browser to open the URL
---@field browser string|BrowserCallback

---@class FinickyConfig
-- fallback browser when no handler matches
---@field public defaultBrowser string|BrowserCallback
-- handling rules
---@field public handlers Handler[]
-- transformation rules
---@field public rewrites Rewrite[]

-- Finicky Spoon object
---@class Finicky : Spoon, FinickyConfig
-- domains of URL shortener services to resolve
---@field public urlShorteners string[]
-- domains of URL shortener services to resolve
---@field protected urlShortenersMap table<string,boolean>
local obj = {
  defaultBrowser = nil,
  handlers = {},
  rewrites = {},
  urlShorteners = {
    "adf.ly",
    "bit.do",
    "bit.ly",
    "buff.ly",
    "deck.ly",
    "fur.ly",
    "goo.gl",
    "is.gd",
    "mcaf.ee",
    "ow.ly",
    "spoti.fi",
    "su.pr",
    "t.co",
    "tiny.cc",
    "tinyurl.com",
    "urlshortener.teams.microsoft.com",
  },
  urlShortenersMap = {},
}
obj.__index = obj

obj.name = "Finicky"
obj.version = "1.0"
obj.author = "William Artero"
obj.license = "MIT - https://opensource.org/licenses/MIT"

---@class URLInstance
---@field protocol string
---@field username string
---@field password string
---@field host string
---@field port string
---@field path string
---@field query string
---@field fragment string
---@field toString fun(self:URLInstance): string
---@field invalidate fun(self:URLInstance)

-- provides methods for URL parsing from and to string. It also caches generated
-- strings to reduce processing overhead or the need for extra variables when
-- the final URL string form is needed.
local URL = {}
setmetatable(URL, { __mode = "k" })

---@param url URLInstance
function URL.invalidate(url)
  URL[url] = nil
end

---@param url URLInstance
---@return string
function URL.toString(url)
  if URL[url] == nil then
    local parts = { url.protocol, "://" }

    local auth = false
    if url.username then
      table.insert(parts, url.username)
      auth = true
    end
    if url.password then
      table.insert(parts, ":" .. url.password)
      auth = true
    end
    if auth then table.insert(parts, "@") end

    table.insert(parts, url.host)
    if url.port then
      table.insert(parts, ":" .. url.port)
    end
    table.insert(parts, url.path)

    if url.query then
      table.insert(parts, "?" .. url.query)
    end

    if url.fragment then
      table.insert(parts, "#" .. url.fragment)
    end

    URL[url] = table.concat(parts, "")
  end
  return URL[url]
end

---@param url string
---@return URLInstance
function URL.fromString(url)
  ---@type URLInstance
  local result = {
    protocol = nil,
    username = nil,
    password = nil,
    host = nil,
    port = nil,
    path = nil,
    query = nil,
    fragment = nil,
  }

  local meta = {
    toString = URL.toString,
    invalidate = URL.invalidate,
  }
  meta.__index = meta
  setmetatable(result, meta)

  ---@type string
  local remainder = nil

  result.protocol, remainder = url:match("^([^:]+)://(.*)$")
  if remainder == nil then return result end

  ---@type string
  local maybeRemainder = nil

  ---@type string
  local auth = nil

  auth, maybeRemainder = remainder:match("^([^@]+)@(.*)$")
  if maybeRemainder ~= nil then
    remainder = maybeRemainder
    result.username, result.password = auth:match("^([^:]*):?(.*)$")
    if result.username == "" then result.username = nil end
    if result.password == "" then result.password = nil end
  end
  if remainder == nil then return result end

  result.host, remainder = remainder:match("^([^/:]*)(.*)$")
  if remainder == nil then return result end

  result.port, maybeRemainder = remainder:match("^:([0-9]*)(.*)$")
  if maybeRemainder ~= nil then
    remainder = maybeRemainder
  end
  if remainder == nil then return result end

  result.path, remainder = remainder:match("^([^%?#]*)(.*)$")
  if result.path == "" then result.path = nil end
  if remainder == nil then return result end

  result.query, maybeRemainder = remainder:match("^%?([^#]*)(.*)$")
  if result.query == "" then result.query = nil end
  if maybeRemainder ~= nil then
    remainder = maybeRemainder
  end
  if remainder == nil then return result end

  result.fragment, remainder = remainder:match("^#(.*)$")
  if result.fragment == "" then result.fragment = nil end
  if remainder == nil then return result end

  return result
end

---@param x string @hexadecimal number of a character
---@return string
local hex_to_char = function(x)
  return string.char(tonumber(x, 16))
end

---@param url string
---@return string
function obj:decodeURIComponent(url)
  return url:gsub("%%(%x%x)", hex_to_char)
end

--- opens the URL with the provided browser. Falls back to the default browser.
---
--- If browser/defaultBrowser is a function, no opening is done; instead it is
--- called with the URL.
---@param fullURL string
---@param browser string|BrowserCallback
---@return boolean
function obj:openURLWith(fullURL, browser)
  self.logger.v("openURLWith", fullURL, browser)
  local browser = browser or self.defaultBrowser

  if type(browser) == "string" then
    return hs.urlevent.openURLWithBundle(fullURL, browser)
  elseif type(browser) == "function" then
    return browser(fullURL)
  else
    self.logger.ef("failed to handle %s: unsupported browser type (%s)", fullURL, type(browser))
    return false
  end
end

local redirects = {
  [301] = true,
  [302] = true,
  [309] = true,
}

--- resolves shortened URLs recursively
---@param url URLInstance
---@return URLInstance
function obj:unShorten(url)
  if not self.urlShortenersMap[url.host] then
    return url
  end

  local fullURL = url:toString()
  local status, _, headers = hs.http.doRequest(fullURL, "HEAD")
  assert(redirects[status], string.format("unable to un-shorten URL (HTTP status %d)", status))

  fullURL = headers["Location"]
  url = URL.fromString(fullURL)

  return self:unShorten(url)
end

---@param rule Rewrite
---@param url URLInstance
---@return boolean
function obj:shouldRewrite(rule, url)
  local matchType = type(rule.match)
  local fullURL = url:toString()

  if matchType == "string" then
    return fullURL:match(rule.match) ~= nil
  end

  if matchType == "table" then
    for _, match in ipairs(rule.match) do
      if fullURL:match(match) ~= nil then
        return true
      end
    end

    return false
  end

  if matchType == "function" then
    return rule.match(url)
  end

  error(string.format("unsupported rule match type (%s)", matchType))
end

---@param rule Rewrite
---@param url URLInstance
---@return URLInstance
function obj:rewrite(rule, url)
  if not self:shouldRewrite(rule, url) then
    return url
  end

  local urlType = type(rule.url)
  if urlType == "string" then
    return URL.fromString(rule.url)
  end

  if urlType == "function" then
    local result = rule.url(url)
    if type(result) == "string" then
      return URL.fromString(result)
    else
      return result
    end
  end

  error(string.format("unsupported rule url type (%s)", urlType))
end

---@param handler Handler
---@param url URLInstance
---@return boolean
function obj:tryHandle(handler, url)
  if handler.host ~= nil then
    local hostType = type(handler.host)
    if hostType == "string" and handler.host == url.host then
      return self:openURLWith(url:toString(), handler.browser)
    elseif hostType == "table" then
      for _, host in ipairs(handler.host) do
        if url.host == host then
          return self:openURLWith(url:toString(), handler.browser)
        end
      end
      return false
    end
  end

  if handler.match ~= nil then
    local matchType = type(handler.match)
    if matchType == "string" and url:toString():match(handler.match) then
      return self:openURLWith(url:toString(), handler.browser)
    elseif type(handler.match) == "table" then
      for _, match in ipairs(handler.match) do
        if url:toString():match(match) then
          return self:openURLWith(url:toString(), handler.browser)
        end
      end
    end
  end

  return false
end

--- handles a HTTP(S) callback action
---@param scheme string
---@param host string
---@param params table<string,string>
---@param fullURL string
---@param senderPID number
function obj:open(scheme, host, params, fullURL, senderPID)
  self.logger.v("open", scheme, host, params, fullURL, senderPID)

  local url = URL.fromString(fullURL)

  url = self:unShorten(url)
  fullURL = url:toString()

  for _, rewriter in ipairs(self.rewrites) do
    url = self:rewrite(rewriter, url)
  end
  fullURL = url:toString()

  for _, handler in ipairs(self.handlers) do
    if self:tryHandle(handler, url) then
      return
    end
  end

  self:openURLWith(fullURL, self.defaultBrowser)
end

---@return Finicky @the Finicky object
function obj:init()
  self.logger = hs.logger.new(string.lower(self.name))
  return self
end

---@return Finicky @the Finicky object
function obj:start()
  for _, host in ipairs(self.urlShorteners) do
    self.urlShortenersMap[host] = true
  end

  return self
end

---@return Finicky @the Finicky object
function obj:stop()
  self.urlShortenersMap = {}

  return self
end

return obj
