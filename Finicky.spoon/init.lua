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
-- domains of URL shortener services to resolve
---@field public urlShorteners string[]

-- collection of methods to parse URLs from and to string. It also caches
-- generated strings to reduce processing overhead or the need for extra
-- variables when the final URL string form is needed.
---@class URLUtils
local URLUtils = {}
setmetatable(URLUtils, { __mode = "k" })

-- Finicky Spoon object
---@class Finicky : FinickyConfig, URLUtils, Spoon
-- domains of URL shortener services to resolve
---@field protected urlShortenersMap table<string,boolean>
local obj = {
  defaultBrowser = nil,
  handlers = {},
  rewrites = {},
  urlShorteners = {
    -- spell-checker: disable
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
    -- spell-checker: enable
  },
  urlShortenersMap = {},
}
obj.__index = obj
setmetatable(obj, { __index = URLUtils })

obj.name = "Finicky"
obj.version = "1.0"
obj.author = "William Artero"
obj.license = "MIT - https://opensource.org/licenses/MIT"

---@param url URLInstance
function URLUtils:invalidate(url)
  self[url] = nil
end

---@param url URLInstance
---@return string
function URLUtils:toString(url)
  if self[url] == nil then
    local parts = {}

    if type(url.protocol) == "string" and url.protocol:len() > 0 then
      table.insert(parts, url.protocol .. "://")
    end

    local auth = false
    if type(url.username) == "string" and url.username:len() > 0 then
      table.insert(parts, url.username)
      auth = true
    end
    if type(url.password) == "string" and url.password:len() > 0 then
      table.insert(parts, ":" .. url.password)
      auth = true
    end
    if auth then table.insert(parts, "@") end

    table.insert(parts, url.host)

    if type(url.port) == "string" and url.port:len() > 0 then
      table.insert(parts, ":" .. url.port)
    end

    if type(url.path) == "string" and url.path:len() > 0 then
      table.insert(parts, url.path)
    end

    if type(url.query) == "string" and url.query:len() > 0 then
      table.insert(parts, "?" .. url.query)
    end

    if type(url.fragment) == "string" and url.fragment:len() > 0 then
      table.insert(parts, "#" .. url.fragment)
    end

    self[url] = table.concat(parts, "")
  end
  return self[url]
end

---@param url string
---@return URLInstance
function URLUtils:fromString(url)
  ---@type URLInstance
  local result = {
    protocol = "",
    username = "",
    password = "",
    host = "",
    port = "",
    path = "",
    query = "",
    fragment = "",
  }

  local meta = {
    toString = hs.fnutils.partial(self.toString, self),
    invalidate = hs.fnutils.partial(self.invalidate, self),
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
  if remainder == nil then return result end

  result.query, maybeRemainder = remainder:match("^%?([^#]*)(.*)$")
  if maybeRemainder ~= nil then
    remainder = maybeRemainder
  end
  if remainder == nil then return result end

  result.fragment, remainder = remainder:match("^#(.*)$")

  if remainder ~= nil then
    obj.logger.w("unexpected remainder on URL fromString: %s => %s", url, remainder)
  end

  return result
end

---@param query string
---@return table<string,string>
function URLUtils.parseQuery(query)
  -- convert query string to map
  ---@type table<string,string>
  local params = {}
  for param in query:gmatch("([^&]+)") do
    local name, value = param:match("([^=&]+)=([^&]*)")
    params[name] = value
  end

  return params
end

---@param x string @hexadecimal number of a character
---@return string
local hex_to_char = function(x)
  return string.char(tonumber(x, 16))
end

---@param url string
---@return string
function URLUtils.decodeURIComponent(url)
  local result = url:gsub("%%(%x%x)", hex_to_char)
  return result
end

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
  url = self:fromString(fullURL)

  return self:unShorten(url)
end

---@param rule Rewrite
---@param url URLInstance
---@return boolean
function obj:shouldRewrite(rule, url)
  local matchType = type(rule.match)
  local fullURL = url:toString()

  self.logger.v("shouldRewrite", hs.inspect(rule), hs.inspect(url), fullURL)

  if matchType == "string" then
    -- disable lint here as it doesn't detect the check through a variable
    ---@diagnostic disable-next-line: param-type-mismatch
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
    -- disable lint here as it doesn't detect the check through a variable
    ---@diagnostic disable-next-line: param-type-mismatch
    return self:fromString(rule.url)
  end

  if urlType == "function" then
    local result = rule.url(url)
    if type(result) == "string" then
      return self:fromString(result)
    elseif type(result) == "table" then
      return result
    else
      error("rewrite url should return either a string or a URL instance table")
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
    -- language server isn't smart enough to detect our type check
    ---@diagnostic disable-next-line: param-type-mismatch
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
  if fullURL == nil then
    self.logger.e("full URL is nil, cannot infer target")
    return
  end
  self.logger.v("open", scheme, host, params, fullURL, senderPID)

  local url = self:fromString(fullURL)

  self.logger.v("parsed URL", hs.inspect(url))

  url = self:unShorten(url)

  self.logger.v("un-shortened URL", hs.inspect(url))

  for _, rewriter in ipairs(self.rewrites) do
    url = self:rewrite(rewriter, url)
  end

  self.logger.v("rewritten URL", hs.inspect(url))

  for _, handler in ipairs(self.handlers) do
    if self:tryHandle(handler, url) then
      return
    end
  end

  self:openURLWith(url:toString(), self.defaultBrowser)
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
