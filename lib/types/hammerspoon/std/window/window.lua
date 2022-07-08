--- @class HSWindow
--- @field filter WindowFilter
--- @field highlight WindowHighlight
--- @field layout WindowLayout
--- @field switcher WindowSwitcher
--- @field tiling WindowTiling
--- @field animationDuration number
--- @field setFrameCorrectness boolean
local HSWindow

--- @return Window[]
function HSWindow.allWindows() end

--- @return Window
function HSWindow.desktop() end

--- @return Window[]
function HSWindow.invisibleWindows() end

--- @param allWindows boolean|nil
--- @return CGWindow[]
function HSWindow.list(allWindows) end

--- @return Window[]
function HSWindow.minimizedWindows() end

--- @return Window[]
function HSWindow.orderedWindows() end

--- @param shadows boolean
function HSWindow.setShadows(shadows) end

--- @param ID integer
--- @param keepTransparency boolean|nil
--- @return Image|nil
function HSWindow.snapshotForID(ID, keepTransparency) end

--- @param value integer
--- @return boolean
function HSWindow.timeout(value) end

--- @return Window[]
function HSWindow.visibleWindows() end

--- @param hint integer|string
--- @return Window|Window[]|nil
function HSWindow.find(hint) end

--- @return Window
function HSWindow.focusedWindow() end

--- @return Window|nil
function HSWindow.frontmostWindow() end

--- @param hint integer|string
--- @return Window|nil
function HSWindow.get(hint) end
