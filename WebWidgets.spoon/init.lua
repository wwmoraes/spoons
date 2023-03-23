-- === WebWidgets ===
--
-- Generates web widgets to monitor specific web pages. They can be customized
-- with custom CSS rules, and automatically reload on system events (such as
-- when coming back from sleep). They float on the desktop and appear on all
-- spaces as if part of the background.
--

---@class WebWidgetsConfig
-- Service Now instance URL
---@field public baseURL string
-- Service Now endpoint path
---@field public endpoint string
-- URL query parameters used on the request
---@field public params table<string,string>
-- Area where the widget will be displayed
---@field public rectangle Geometry
-- Custom CSS rules to be injected on load
---@field public style string

-- WebWidget Spoon object
---@class WebWidgets : WebWidgetsConfig, Spoon
local obj = {}
obj.__index = obj

-- Metadata
obj.name = "WebWidgets"
obj.version = "1.0"
obj.author = "William Artero"
obj.license = "MIT - https://opensource.org/licenses/MIT"

---@type WebWidget
local webWidget = dofile(hs.spoons.resourcePath("webwidget.lua"))

---@param options WebWidgetOptions
---@return WebWidget
function obj:new(options)
  options.logger = options.logger or self.logger
  local success, result = pcall(webWidget.new, options)
  if not success then
    self.logger.e(result)
    return {}
  end
  return result
end

---@return WebWidgets
function obj:init()
  self.logger = hs.logger.new(string.lower(self.name))
  return self
end

---@return WebWidgets
function obj:start()
  return self
end

---@return WebWidgets
function obj:stop()
  return self
end

return obj
