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
---@class WebWidgets : Spoon, WebWidgetsConfig
local obj = {
  webView = nil,
  watcher = nil,
  timer = nil,
}
obj.__index = obj

-- Metadata
obj.name = "WebWidgets"
obj.version = "1.0"
obj.author = "William Artero"
obj.license = "MIT - https://opensource.org/licenses/MIT"

---@param part string
---@return string
local function encodeURIComponent(part)
  local result, _ = part:
      gsub("/", "%%2F"):
      gsub("=", "%%3D"):
      gsub("&", "%%26"):
      gsub("?", "%%3F"):
      gsub("#", "%%23"):
      gsub('"', "%%22"):
      gsub("'", "%%27"):
      gsub(":", "%%3A"):
      gsub("@", "%%40")
  return result
end

---@param params table<string,string>
---@return string
local function paramsToString(params)
  local elements = {}
  for k, v in pairs(params) do
    table.insert(elements, k .. "=" .. encodeURIComponent(v))
  end
  return table.concat(elements, "&")
end

---@class WebWidget
---@field private webView WebView
---@field private watcher CaffeinateWatcher
---@field private timer Timer
---@field private logger Logger
---@field private url string
local WebWidget = {}
WebWidget.__index = WebWidget

---@class WebWidgetOptions
---@field logger Logger
---@field rectangle Rectangle
---@field baseURL string
---@field endpoint string
---@field params table<string,string>
---@field style? string

---@param options WebWidgetOptions
---@return WebWidget
function WebWidget.new(options)
  local url = options.baseURL
  if type(options.endpoint) == "string" and options.endpoint:len() > 0 then
    url = url .. "/" .. options.endpoint
  end
  if type(options.params) == "table" then
    url = url .. "?" .. paramsToString(options.params)
  end

  options.logger.i("creating WebView instance...")
  local webView = hs.webview.new(options.rectangle):sendToBack()
  webView:behavior(hs.drawing.windowBehaviors.canJoinAllSpaces)

  options.logger.i("configuring navigation callback...")
  webView:navigationCallback(WebWidget.navigationCallback(options.logger, url, options.style))

  local timer = hs.timer.new(3600, hs.fnutils.partial(webView.reload, webView), true)
  local watcher = hs.caffeinate.watcher.new(WebWidget.watcherCallback(webView))

  ---@type WebWidget
  local webWidget = {
    webView = webView,
    logger = options.logger,
    timer = timer,
    watcher = watcher,
    url = url,
  }
  setmetatable(webWidget, WebWidget)

  return webWidget
end

---@param webView WebView
function WebWidget.watcherCallback(webView)
  ---@param eventType number
  return function(eventType)
    if eventType ~= hs.caffeinate.watcher.systemDidWake and
        eventType ~= hs.caffeinate.watcher.screensDidUnlock then
      return
    end

    if webView == nil then
      return
    end

    webView:reload()
  end
end

---@param logger Logger
---@param url string
---@param style? string
---@return NavigationCallback
function WebWidget.navigationCallback(logger, url, style)
  ---@param action string
  ---@param view WebView
  return function(action, view)
    if action ~= "didFinishNavigation" then return end

    if style ~= nil then
      view:evaluateJavaScript(string.format([[
        const stylesElem = document.createElement("style");
        stylesElem.type = "text/css";
        stylesElem.innerText = `%s`.trim();
        document.head.appendChild(stylesElem);
        true;
      ]], style), function(result, error)
        if result ~= nil then obj.logger.i("JS result:", result) end
        if error ~= nil and error.code ~= 0 then
          obj.logger.e("JS error:", hs.inspect(error))
        end
      end)
    end

    logger.i(string.format("loaded URL: %s", view:url()))
    if view:url() ~= url then
      logger.i("URL of widget is not the expected one, reloading...")
      hs.timer.delayed.new(1, function()
        view:url(url)
      end):start()
      return
    end

    view:show()
  end
end

---@return WebWidget
function WebWidget:reload()
  self.webView:reload()
  return self
end

---@return WebWidget
function WebWidget:start()
  self.watcher:start()
  self.timer:start()

  self.logger.i("loading URL...")
  self.webView:url(self.url)

  return self
end

---@return WebWidget
function WebWidget:stop()
  self.timer:stop()
  self.watcher:stop()
  self.webView:delete(true, 1)

  return self
end

---@param rect Rectangle
---@param baseURL string
---@param endpoint string
---@param params table<string,string>
---@param style string
---@return WebWidget
function obj:new(rect, baseURL, endpoint, params, style)
  return WebWidget.new({
    rectangle = rect,
    baseURL = baseURL,
    endpoint = endpoint,
    params = params,
    style = style,
    logger = self.logger,
  })
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
