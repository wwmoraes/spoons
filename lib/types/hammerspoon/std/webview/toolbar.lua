---@class HSWebViewToolbar
---@field itemPriorities ToolbarPriorities
---@field systemToolbarItems string[]
local HSWebViewToolbar

---@class ToolbarPriorities
---@field high number
---@field low number
---@field standard number
---@field user number

---@param obj1 WebView | Chooser
---@param obj2 WebViewToolbar
---@overload fun(): WebViewToolbar
---@overload fun(obj1: WebViewToolbar | nil)
---@overload fun(obj1: WebView | Chooser): WebViewToolbar | nil
function HSWebViewToolbar.attachToolbar(obj1, obj2) end

---@param state boolean
---@return WebViewToolbar
---@overload fun(): boolean
function HSWebViewToolbar.inTitleBar(state) end

---@param toolbarName string
---@return boolean
function HSWebViewToolbar.uniqueName(toolbarName) end

---@class WebViewToolbar
