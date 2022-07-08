---@class HSAlert
---@field defaultStyle Style
local HSAlert

---@class Style
---@field atScreenEdge number
---@field fadeInDuration number
---@field fadeOutDuration number
---@field fillColor GrayscaleColor
---@field radius number
---@field strokeColor GrayscaleColor
---@field strokeWidth number
---@field textColor GrayscaleColor
---@field textFont string
---@field textSize number

---@param seconds? number
function HSAlert.closeAll(seconds) end

---@param uuid string
---@param seconds? number
function HSAlert.closeSpecific(uuid, seconds) end

---@param str string
---@param style? Style
---@param screen? Screen
---@param seconds? number
---@return string uuid
function HSAlert.show(str, style, screen, seconds) end

---@param str string
---@param image Image
---@param style? Style
---@param screen? Screen
---@param seconds? number
---@return string uuid
function HSAlert.showWithImage(str, image, style, screen, seconds) end
