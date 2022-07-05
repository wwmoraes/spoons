---@class Alert
---@field defaultStyle Style
local Alert

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
function Alert.closeAll(seconds) end

---@param uuid string
---@param seconds? number
function Alert.closeSpecific(uuid, seconds) end

---@param str string
---@param style? Style
---@param screen? ScreenInstance
---@param seconds? number
---@return string uuid
function Alert.show(str, style, screen, seconds) end

---@param str string
---@param image ImageInstance
---@param style? Style
---@param screen? ScreenInstance
---@param seconds? number
---@return string uuid
function Alert.showWithImage(str, image, style, screen, seconds) end
