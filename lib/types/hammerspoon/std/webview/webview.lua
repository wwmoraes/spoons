-- // TODO hs.webview

---@class WebView
---@field toolbar WebViewToolbar
---@field certificateOIDs table<string,string>
---@field windowMasks table<string,number>
local WebView

---@class WebViewInstance
local WebViewInstance

---@deprecated
---@return DrawingInstance
function WebViewInstance:asHSDrawing() end

---@deprecated
---@return WindowInstance
function WebViewInstance:asHSWindow() end

---@param theLevel integer
---@return DrawingInstance
function WebViewInstance:setLevel(theLevel) end

---@param state "visible"|"hidden"
---@return WebViewInstance
---@overload fun(): string
function WebViewInstance:titleVisibility(state) end
