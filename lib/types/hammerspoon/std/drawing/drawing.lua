-- // TODO document drawing types

---@deprecated
---@class HSDrawing
---@field windowBehaviors WindowBehaviors
---@field windowLevels WindowLevels
local HSDrawing

---@deprecated
---@class Drawing
local Drawing

---@class WindowBehaviors
---@field [string] number
---@field default 0
---@field canJoinAllSpaces 1
---@field moveToActiveSpace 2
---@field managed 4
---@field transient 8
---@field stationary 16
---@field fullScreenPrimary 28
---@field participatesInCycle 32
---@field fullScreenAllowsTiling 48
---@field fullScreenAuxiliary 56
---@field ignoresCycle 64
---@field fullScreenDisallowsTiling 96

---@class WindowLevels
---@field [string] number
---@field _MinimumWindowLevelKey -2147483643
---@field desktop -2147483623
---@field desktopIcon -2147483603
---@field normal 0
---@field floating 3
---@field tornOffMenu 3
---@field modalPanel 8
---@field utility 19
---@field dock 20
---@field mainMenu 24
---@field status 25
---@field popUpMenu 101
---@field overlay 102
---@field help 200
---@field dragging 500
---@field screenSaver 1000
---@field assistiveTechHigh 1500
---@field cursor 2147483630
---@field _MaximumWindowLevelKey 2147483631
