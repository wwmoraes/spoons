---@class WebWidget
---@field private webView WebView
---@field private watcher? CaffeinateWatcher
---@field private timers Timer[]
---@field private logger Logger
---@field private url string
---@field private events table<number, boolean>
---@field private style? string
---@field private exactURL? boolean
local WebWidget = {}
WebWidget.__index = WebWidget

---@class RefreshOptions
---@field events table<number,boolean>
---@field times TimerOptions[]

---@class TimerOptions
---@field time number|string
---@field repeatInterval? number|string

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

---@class WebWidgetOptions
---@field logger Logger
---@field rectangle Rectangle
---@field baseURL string
---@field endpoint string
---@field params table<string,string>
---@field style? string
---@field refreshOn? RefreshOptions
---@field exactURL? boolean

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

  ---@type WebWidget
  local webWidget = {
    webView = webView,
    logger = options.logger,
    timers = {},
    watcher = nil,
    url = url,
    style = options.style,
    events = options.refreshOn.events or {},
    exactURL = options.exactURL,
  }
  setmetatable(webWidget, WebWidget)

  options.logger.i("configuring navigation callback...")
  webView:navigationCallback(hs.fnutils.partial(WebWidget.navigationCallback, webWidget))

  if options.refreshOn ~= nil then
    if options.refreshOn.times ~= nil then
      options.logger.i("configuring timers...")
      local reloadFn = hs.fnutils.partial(webView.reload, webView)
      for _, timerOptions in ipairs(options.refreshOn.times) do
        table.insert(webWidget.timers, hs.timer.doAt(timerOptions.time, timerOptions.repeatInterval, reloadFn, true))
      end
    end
    if options.refreshOn.events ~= nil then
      options.logger.i("configuring event watcher...")
      webWidget.watcher = hs.caffeinate.watcher.new(hs.fnutils.partial(webWidget.watcherCallback, webWidget))
    end
  end

  return webWidget
end

---@param eventType number
function WebWidget:watcherCallback(eventType)
  if self.events[eventType] ~= true then
    return
  end

  if self.webView == nil then
    return
  end

  self.webView:reload()
end

---@param action string
---@param view WebView
function WebWidget:navigationCallback(action, view)
  if action ~= "didFinishNavigation" then return end

  if self.style ~= nil then
    view:evaluateJavaScript(string.format([[
        const stylesElem = document.createElement("style");
        stylesElem.type = "text/css";
        stylesElem.innerText = `%s`.trim();
        document.head.appendChild(stylesElem);
        true;
      ]], self.style), function(result, error)
      if result ~= nil then self.logger.i("JS result:", result) end
      if error ~= nil and error.code ~= 0 then
        self.logger.e("JS error:", hs.inspect(error))
      end
    end)
  end

  self.logger.i(string.format("loaded URL: %s", view:url()))
  if self.exactURL == true and view:url() ~= self.url then
    self.logger.i("URL of widget is not the expected one, reloading...")
    hs.timer.delayed.new(1, function()
      view:url(self.url)
    end):start()
    return
  end

  view:show(1)
end

---@return WebWidget
function WebWidget:reload()
  self.webView:reload()
  return self
end

---@return WebWidget
function WebWidget:start()
  if self.watcher then
    self.watcher:start()
  end
  for _, timer in ipairs(self.timers) do
    timer:start()
  end

  self.logger.i("loading URL...")
  self.webView:url(self.url)

  return self
end

---@return WebWidget
function WebWidget:stop()
  if self.watcher then
    self.watcher:stop()
  end
  for _, timer in ipairs(self.timers) do
    timer:stop()
  end

  self.webView:delete(true, 1)

  return self
end

return WebWidget
