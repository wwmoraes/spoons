--- @class HSEventTap
--- @field event EventTapEvent
local HSEventTap

--- @param raw boolean|nil
--- @return EventTapKeyboardModifiers
function HSEventTap.checkKeyboardModifiers(raw) end

--- @return table
function HSEventTap.checkMouseButtons() end

--- @return number
function HSEventTap.doubleClickInterval() end

--- @return boolean
function HSEventTap.isSecureInputEnabled() end

--- @return number
function HSEventTap.keyRepeatDelay() end

--- @return number
function HSEventTap.keyRepeatInterval() end

--- @param modifiers EventTapKeyboardModifier[]
--- @param character string
--- @param delay number|nil
--- @param application Application|nil
function HSEventTap.keyStroke(modifiers, character, delay, application) end

--- @param text string
--- @param application Application|nil
function HSEventTap.keyStrokes(text, application) end

--- @param point EventTapPoint
--- @param delay number|nil
function HSEventTap.leftClick(point, delay) end

--- @param point EventTapPoint
--- @param delay number|nil
function HSEventTap.middleClick(point, delay) end

--- @param point EventTapPoint
--- @param delay number|nil
--- @param button number|nil
function HSEventTap.otherClick(point, delay, button) end

--- @param point EventTapPoint
--- @param delay number|nil
function HSEventTap.rightClick(point, delay) end

--- @param offsets EventTapOffsets
--- @param modifiers EventTapKeyboardModifier[]|nil
--- @param unit EventTapScrollWheelUnit|nil
function HSEventTap.scrollWheel(offsets, modifiers, unit) end

--- @param types EventTapEventType|'"all"'[]
--- @param fn EventTapCallback
--- @return EventTap
function HSEventTap.new(types, fn) end
