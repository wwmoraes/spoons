-- // TODO hs.webview

---@class HSWebView
---@field toolbar HSWebViewToolbar
---@field datastore WebViewDatastore
---@field usercontent HSWebViewUserContent
---@field certificateOIDs table<string,string>
---@field windowMasks WindowMasks
local HSWebView

---@class WindowMasks
---@field [string] number
---@field borderless 0
---@field titled 1
---@field closable 2
---@field miniaturizable 4
---@field resizable 8
---@field utility 16
---@field nonactivating 128
---@field texturedBackground 256
---@field HUD 8192
---@field fullSizeContentView 32768

---@param rect Rectangle
---@param preferencesTable? WebViewPreferences
---@param userContentController? WebViewUserContent
---@return WebView
function HSWebView.new(rect, preferencesTable, userContentController) end

---@param rect Rectangle
---@param preferencesTable? WebViewPreferences
---@param userContentController? WebViewUserContent
---@return WebView
function HSWebView.newBrowser(rect, preferencesTable, userContentController) end
