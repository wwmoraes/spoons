--- @class Window
local Window

--- @return Application|nil
function Window:application() end

--- @return Window
function Window:becomeMain() end

--- @param screen Screen|nil
--- @param ensureIsInScreenBounds boolean|nil
--- @param duration integer|nil
--- @return Window
function Window:centerOnScreen(screen, ensureIsInScreenBounds, duration) end

--- @return boolean
function Window:close() end

--- @return Window
function Window:focus() end

--- @param index integer
--- @return boolean
function Window:focusTab(index) end

--- @param candidateWindows Window[]|nil
--- @param frontmost boolean|nil
--- @param strict boolean|nil
--- @return boolean
function Window:focusWindowEast(candidateWindows, frontmost, strict) end

--- @param candidateWindows Window[]|nil
--- @param frontmost boolean|nil
--- @param strict boolean|nil
--- @return boolean
function Window:focusWindowNorth(candidateWindows, frontmost, strict) end

--- @param candidateWindows Window[]|nil
--- @param frontmost boolean|nil
--- @param strict boolean|nil
--- @return boolean
function Window:focusWindowSouth(candidateWindows, frontmost, strict) end

--- @param candidateWindows Window[]|nil
--- @param frontmost boolean|nil
--- @param strict boolean|nil
--- @return boolean
function Window:focusWindowWest(candidateWindows, frontmost, strict) end

--- @return Geometry
function Window:frame() end

--- @return integer|nil
function Window:id() end

--- @return boolean|nil
function Window:isFullScreen() end

--- @return boolean|nil
function Window:isMaximizable() end

--- @return boolean
function Window:isMinimized() end

--- @return boolean
function Window:isStandard() end

--- @return boolean
function Window:isVisible() end

--- @param duration integer|nil
--- @return Window
function Window:maximize(duration) end

--- @return Window
function Window:minimize() end

--- @param rect Geometry
--- @param screen Screen|nil
--- @param ensureIsInScreenBounds boolean|nil
--- @param duration integer|nil
--- @return Window
function Window:move(rect, screen, ensureIsInScreenBounds, duration) end

--- @param noResize boolean|nil
--- @param ensureIsInScreenBounds boolean|nil
--- @param duration integer|nil
--- @return Window
function Window:moveOneScreenEast(noResize, ensureIsInScreenBounds, duration) end

--- @param noResize boolean|nil
--- @param ensureIsInScreenBounds boolean|nil
--- @param duration integer|nil
--- @return Window
function Window:moveOneScreenNorth(noResize, ensureIsInScreenBounds, duration) end

--- @param noResize boolean|nil
--- @param ensureIsInScreenBounds boolean|nil
--- @param duration integer|nil
--- @return Window
function Window:moveOneScreenSouth(noResize, ensureIsInScreenBounds, duration) end

--- @param noResize boolean|nil
--- @param ensureIsInScreenBounds boolean|nil
--- @param duration integer|nil
--- @return Window
function Window:moveOneScreenWest(noResize, ensureIsInScreenBounds, duration) end

--- @param screen Screen
--- @param noResize boolean|nil
--- @param ensureIsInScreenBounds boolean|nil
--- @param duration integer|nil
--- @return Window
function Window:moveToScreen(screen, noResize, ensureIsInScreenBounds, duration) end

--- @param unitrect Geometry
--- @param duration integer|nil
--- @return Window
function Window:moveToUnit(unitrect, duration) end

function Window:otherWindowsAllScreens() end

function Window:otherWindowsSameScreen() end

function Window:raise() end

function Window:role() end

function Window:screen() end

function Window:sendToBack() end

function Window:setFrame() end

function Window:setFrameInScreenBounds() end

function Window:setFrameWithWorkarounds() end

function Window:setFullScreen() end

function Window:setSize() end

function Window:setTopLeft() end

function Window:size() end

function Window:snapshot() end

function Window:subrole() end

function Window:tabCount() end

function Window:title() end

function Window:toggleFullScreen() end

function Window:toggleZoom() end

function Window:topLeft() end

function Window:unminimize() end

function Window:windowsToEast() end

function Window:windowsToNorth() end

function Window:windowsToSouth() end

function Window:windowsToWest() end

function Window:zoomButtonRect() end
