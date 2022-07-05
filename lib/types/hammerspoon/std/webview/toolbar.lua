---@class WebViewToolbar
---@field itemPriorities ToolbarPriorities
---@field systemToolbarItems string[]
local WebViewToolbar

---@class ToolbarPriorities
---@field high number
---@field low number
---@field standard number
---@field user number

---@param obj1 WebViewObject | ChooserObject
---@param obj2 ToolbarObject
---@overload fun(): ToolbarObject
---@overload fun(obj1: ToolbarObject | nil)
---@overload fun(obj1: WebViewObject | ChooserObject): ToolbarObject | nil
function WebViewToolbar.attachToolbar(obj1, obj2) end

---@param state boolean
---@return ToolbarObject
---@overload fun(): boolean
function WebViewToolbar.inTitleBar(state) end

---@param toolbarName string
---@return boolean
function WebViewToolbar.uniqueName(toolbarName) end

---@class ToolbarObject
