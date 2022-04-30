-- === CleanURLs ===
--
-- removes prefixes and query parameters from URLs to increase privacy
--
-- You can use this spoon in two forms:
--
-- ## Browser handler
--
-- CleanURLs will self-register as the HTTP(S) callback processor and set the OS
-- default HTTP(S) browser to Hammerspoon. This can be done by configuring a
-- valid browser bundle ID and starting this spoon.
--
-- ## callback chain
--
-- This is an advanced form useful if you have another solution handling URLs on
-- Hammerspoon, and don't want CleanURLs to change any settings. To use this
-- way, do not start the spoon to prevent it from registering as the callback.
-- You can then call `CleanURLs:handle()` to handle an HTTP callback request
-- just like `hs.urlevent.httpCallback`. The output result will then either be
-- sent to a browser application or another callback.
--

---@class CleanURLsConfig
--- plain prefixes to remove (wildcards not supported)
---@field public prefixes string[]
--- URL query parameters, either plain or with wildcards
---@field public params string[]
--- either a browser bundle ID or a URL callback to handle the cleaned result
---@field public browser string|URLCallback

--- CleanURLs Spoon object
---@class CleanURLs : Spoon, CleanURLsConfig
--- stores the previous HTTP(S) handler to be restored when the spoon stops
---@field private originalBundleID string
local obj = {
  prefixes = {},
  params = {},
  originalBundleID = nil,
}
obj.__index = obj

-- Metadata
obj.name = "CleanURLs"
obj.version = "1.0"
obj.author = "William Artero"
obj.license = "MIT - https://opensource.org/licenses/MIT"

local hsBundleID = "org.hammerspoon.Hammerspoon"

---@param x string @hexadecimal number of a character
---@return string
local hex_to_char = function(x)
  return string.char(tonumber(x, 16))
end

---@param url string
---@return string
local function unescape(url)
  return url:gsub("%%(%x%x)", hex_to_char)
end

---@param prefix string
---@param fullURL string
---@return boolean
---@return string|nil
local function removePrefix(prefix, fullURL)
  if fullURL:find(prefix) == 1 then
    return true, unescape(fullURL:sub(string.len(prefix) + 1))
  end

  return false, nil
end

---Handle HTTP(S) events, cleaning the URL based on the set prefixes and params.
---
---The result is then sent to:
--- - a browser application to open it, if `CleanURLs.browser` is a string
--- -  another callback, if `CleanURLs.browser` is a function
---@param scheme string
---@param host string
---@param params table<string,string>
---@param fullURL string
---@param senderPID number
function obj:handle(scheme, host, params, fullURL, senderPID)
  self.logger.i("callback URL:", fullURL)

  if scheme ~= "http" and scheme ~= "https" then
    self.logger.e("unknown scheme", scheme)
    return
  end

  -- re-entrant rewrites to remove prefixes and decode URLs
  for _, prefix in ipairs(self.prefixes) do
    local done, newUrl = removePrefix(prefix, fullURL)
    if done then
      return hs.urlevent.openURLWithBundle(newUrl, hsBundleID)
    end
  end

  -- check if we need to parse params
  if #params == 0 then
    local paramsStr = fullURL:match(".*%?(.*)")
    -- generate params from matched string
    if paramsStr ~= nil then
      for param in paramsStr:gmatch("([^&]+)") do
        local key, value = param:match("([^=&]+)=([^=&]+)")
        params[key] = value
      end
    end
  end

  for name, _ in pairs(params) do
    for _, unwanted in ipairs(self.params) do
      if name:match(unwanted) == name then
        params[name] = nil
        goto next_param
      end
    end
    ::next_param::
  end

  -- rebuild URL
  local newParamsStr = {}
  for name, value in pairs(params) do
    table.insert(newParamsStr, string.format("%s=%s", name, value))
  end

  local newFullURL = fullURL:match("([^?]+)")
  if #newParamsStr > 0 then
    newFullURL = string.format("%s?%s", newFullURL, table.concat(newParamsStr, "&"))
  end

  local browserType = type(self.browser)
  if browserType == "string" then
    -- better explode an error than to infinite loop and beachball HS...
    if self.browser == hsBundleID then
      error("loop detected: CleanURLs browser is set to Hammerspoon")
    end

    return hs.urlevent.openURLWithBundle(newFullURL, self.browser)
  elseif browserType == "function" then
    return self.browser(scheme, host, params, newFullURL, senderPID)
  else
    self.logger.e("unsupported browser type", browserType)
  end
end

---@return CleanURLs @the CleanURLs object
function obj:init()
  self.logger = hs.logger.new(string.lower(self.name))
  return self
end

---@return CleanURLs @the CleanURLs object
function obj:start()
  assert(hs.urlevent.httpCallback == nil, "the HTTP callback is already set")

  if self.browser == nil or self.browser == hsBundleID then
    self.logger.i("no external browser set, falling back to Safari")
    self.browser = "com.apple.Safari"
  end

  hs.urlevent.httpCallback = hs.fnutils.partial(self.handle, self)

  -- save the existing handler bundle ID
  self.originalBundleID = hs.urlevent.getDefaultHandler("http")

  -- set Hammerspoon as the handler if needed
  if self.originalBundleID ~= hsBundleID then
    hs.urlevent.setDefaultHandler("http")
  end

  return self
end

---@return CleanURLs @the CleanURLs object
function obj:stop()
  assert(hs.urlevent.httpCallback ~= nil, "the HTTP callback was unset externally")

  hs.urlevent.httpCallback = nil

  -- skip changing the handler if Hammerspoon was the original as well
  if self.originalBundleID == hsBundleID then
    return self
  end

  -- skip changing the handler if it was changed while running
  if hs.urlevent.getDefaultHandler("http") ~= hsBundleID then
    return self
  end

  hs.urlevent.setRestoreHandler("http", self.originalBundleID)
  return self
end

return obj
