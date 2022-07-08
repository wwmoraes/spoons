--- @class Application
local Application

--- @param allWindows boolean|nil
--- @return boolean
function Application:activate(allWindows) end

--- @return Window[]
function Application:allWindows() end

--- @return string
function Application:bundleID() end

--- @param menuItem string|string[]
--- @param isRegex boolean|nil
--- @return ApplicationMenuItemState|nil
function Application:findMenuItem(menuItem, isRegex) end

--- @param titlePattern string
--- @return Window[]|nil
function Application:findWindow(titlePattern) end

--- @return Window|nil
function Application:focusedWindow() end

--- @param fn function|nil
--- @return ApplicationMenuItem[]|nil|Application
function Application:getMenuItems(fn) end

--- @param title string
--- @return Window|nil
function Application:getWindow(title) end

--- @return boolean
function Application:hide() end

--- @return boolean
function Application:isFrontmost() end

--- @return boolean
function Application:isHidden() end

--- @return boolean
function Application:isRunning() end

function Application:kill() end

function Application:kill9() end

--- @return number
function Application:kind() end

--- @return Window|nil
function Application:mainWindow() end

--- @return string
function Application:name() end

--- @return string
function Application:path() end

--- @return integer
function Application:pid() end

--- @param menuitem string|string[]
--- @param isRegex boolean|nil
--- @return 'true'|nil
function Application:selectMenuItem(menuitem, isRegex) end

--- @param allWindows boolean|nil
--- @return boolean
function Application:setFrontmost(allWindows) end

--- @return string
function Application:title() end

--- @return boolean
function Application:unhide() end

--- @return Window[]
function Application:visibleWindows() end
