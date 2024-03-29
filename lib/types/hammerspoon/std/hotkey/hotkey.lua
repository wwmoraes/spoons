--- Create and manage global keyboard shortcuts
--- @class HSHotkey
--- Duration of the alert shown when a hotkey created with a message parameter is triggered, in seconds. Default is 1.
--- @field alertDuration number
local HSHotkey

--- Determines whether the hotkey combination can be assigned a callback
---
--- Notes:
---
--- The most common reason a hotkey combination cannot be given an assignment by
--- is because it is in use by the Mac operating system -- see the Shortcuts tab
--- of Keyboard in the System Preferences application or
--- `hs.hotkey.systemAssigned`.
---
--- @param mods HotkeyModifier[]|string @list or string containing (as elements, or as substrings with any separator) the keyboard modifiers
--- @param key string|number @name of a keyboard key (as found in `hs.keycodes.map`), or a raw keycode number
--- @return boolean @`true` if the hotkey can be assigned, `false` otherwise
function HSHotkey.assignable(mods, key) end

--- @param mods HotkeyModifier[]|string @list or string containing (as elements, or as substrings with any separator) the keyboard modifiers
--- @param key string|number @name of a keyboard key (as found in `hs.keycodes.map`), or a raw keycode number
function HSHotkey.deleteAll(mods, key) end

--- @param mods HotkeyModifier[]|string @list or string containing (as elements, or as substrings with any separator) the keyboard modifiers
--- @param key string|number @name of a keyboard key (as found in `hs.keycodes.map`), or a raw keycode number
function HSHotkey.disableAll(mods, key) end

---@class HotkeyInfo
---@field idx string
---@field msg string

---@return HotkeyInfo[]
function HSHotkey.getHotkeys() end

--- @param mods HotkeyModifier[]|string @list or string containing (as elements, or as substrings with any separator) the keyboard modifiers
--- @param key string|number @name of a keyboard key (as found in `hs.keycodes.map`), or a raw keycode number
---@return Hotkey
function HSHotkey.showHotkeys(mods, key) end

---@class SystemHotkeyInfo
---@field keycode number
---@field mods number
---@field enabled boolean

--- @param mods HotkeyModifier[]|string|nil @list or string containing (as elements, or as substrings with any separator) the keyboard modifiers
--- @param key string|number @name of a keyboard key (as found in `hs.keycodes.map`), or a raw keycode number
---@return SystemHotkeyInfo|false
function HSHotkey.systemAssigned(mods, key) end

---@param mods HotkeyModifier[]|string|nil
---@param key string|number
---@param message string|nil
---@param pressedFn function|nil
---@param releasedFn function|nil
---@param repeatFn function|nil
---@return Hotkey
---@overload fun(mods: HotkeyModifier[]|string, key: string|number, pressedFn: function|nil, releasedFn: function|nil, repeatFn: function|nil): Hotkey
function HSHotkey.bind(mods, key, message, pressedFn, releasedFn, repeatFn) end

---@class KeySpec
---@field [1] HotkeyModifier[]|string
---@field [2] string|number

---@param keySpec KeySpec
---@param message string|nil
---@param pressedFn function|nil
---@param releasedFn function|nil
---@param repeatFn function|nil
---@return Hotkey
---@overload fun(keySpec: KeySpec, pressedFn: function|nil, releasedFn: function|nil, repeatFn: function|nil): Hotkey
function HSHotkey.bindSpec(keySpec, message, pressedFn, releasedFn, repeatFn) end

---@param mods HotkeyModifier[]|string
---@param key string|number
---@param message string|nil
---@param pressedFn function|nil
---@param releasedFn function|nil
---@param repeatFn function|nil
---@return Hotkey
---@overload fun(mods: HotkeyModifier[]|string, key: string|number, pressedFn: function|nil, releasedFn: function|nil, repeatFn: function|nil): Hotkey
function HSHotkey.new(mods, key, message, pressedFn, releasedFn, repeatFn) end
