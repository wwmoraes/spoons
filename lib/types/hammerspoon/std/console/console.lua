-- // TODO hs.console

---@class HSConsole
---@field defaultToolbar WebViewToolbar
local HSConsole

---@deprecated
---@return Drawing
function HSConsole.asHSDrawing() end

---@deprecated
---@return Window
function HSConsole.asHSWindow() end

---@param alpha? number
---@return number
function HSConsole.alpha(alpha) end

---@param behaviorTable? (string|number)[]
---@overload fun(): number
function HSConsole.behaviorAsLabels(behaviorTable) end

function HSConsole.clearConsole() end

---@param color? DrawingColor
---@return DrawingColor
function HSConsole.consoleCommandColor(color) end

---@class FontAndSize
---@field name string
---@field size number

---@param font? string | FontAndSize
---@return FontAndSize
function HSConsole.consoleFont(font) end

---@param color? DrawingColor
---@return DrawingColor
function HSConsole.consolePrintColor(color) end

---@param color? DrawingColor
---@return DrawingColor
function HSConsole.consoleResultColor(color) end

---@param state? boolean
---@return boolean
function HSConsole.darkMode(state) end

---@param styled? boolean
---@return string | StyledText
function HSConsole.getConsole(styled) end

---@return string[]
function HSConsole.getHistory() end

---@return Window
function HSConsole.hswindow() end

---@param color? DrawingColor
---@return DrawingColor
function HSConsole.inputBackgroundColor(color) end

---@param theLevel? number
---@return number
function HSConsole.level(theLevel) end

---@param color? DrawingColor
---@return DrawingColor
function HSConsole.outputBackgroundColor(color) end

---@vararg any
function HSConsole.printStyledtext(...) end

---@param styledText? StyledText
function HSConsole.setConsole(styledText) end

---@param array? string[]
function HSConsole.setHistory(array) end

---@param flag? boolean
---@return boolean
function HSConsole.smartInsertDeleteEnabled(flag) end

---@alias Visibility
---| "visible"
---| "hidden"

---@param state? Visibility
---@return Visibility
function HSConsole.titleVisibility(state) end

---@param color? DrawingColor
---@return DrawingColor
function HSConsole.windowBackgroundColor(color) end

---@param behavior? number
---@return number
function HSConsole.behavior(behavior) end

---@param toolbar? WebViewToolbar
---@return WebViewToolbar | nil
function HSConsole.toolbar(toolbar) end
