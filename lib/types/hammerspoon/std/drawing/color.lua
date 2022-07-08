---@alias ColorCollection table<string, DrawingColor>

---@class Color : ColorCollections
---@field definedCollections ColorCollections
local Color

---@class ColorCollections
---@field ansiTerminalColors ColorCollection
---@field hammerspoon ColorCollection
---@field x11 ColorCollection

---@alias DrawingColor ImageColor | SystemColor | HSBColor | GrayscaleColor | RGBColor

---@class RGBColor
---@field red number
---@field green number
---@field blue number
---@field alpha number

---@class HSBColor
---@field hue number
---@field saturation number
---@field brightness number
---@field alpha number

---@class GrayscaleColor
---@field white number
---@field alpha number

---@class SystemColor
---@field list string
---@field name string

---@class HTMLColor
---@field hex string
---@field alpha number

---@class ImageColor
---@field image Image

---@param color DrawingColor
---@return HSBColor | string
function Color.asHSB(color) end

---@param color DrawingColor
---@return RGBColor | string
function Color.asRGB(color) end

---@param list string
---@return ColorCollection
function Color.colorsFor(list) end

---@return table<string, ColorCollection>
function Color.lists() end
