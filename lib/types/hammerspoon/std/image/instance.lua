--- @class Image
local Image

---@param size? Size
---@param gray? boolean
---@return Image
function Image:bitmapRepresentation(size, gray) end

---@param point Point
---@return DrawingColor
function Image:colorAt(point) end

---@return Image
function Image:copy() end

---@param rectangle Rectangle
---@return Image
function Image:croppedCopy(rectangle) end

---@param scale? boolean
---@param type? ImageType
---@return string
function Image:encodeAsURLString(scale, type) end

---@param name string
---@return Image?
---@overload fun(): string
function Image:name(name) end

---@param filename string
---@param scale? boolean
---@param filetype? ImageType
---@return boolean
function Image:saveToFile(filename, scale, filetype) end

---@deprecated
---@param name string
---@return boolean
---@overload fun(): string
function Image:setName(name) end

---@deprecated
---@param size Size
---@param absolute? boolean
---@return Image
function Image:setSize(size, absolute) end

---@param size Size
---@param absolute? boolean
---@return Image
---@overload fun(): Size
function Image:size(size, absolute) end

---@param state boolean
---@return Image
---@overload fun(): boolean
function Image:template(state) end

---@param width number
---@param height number
---@return string
---@overload fun(): string
function Image:toASCII(width, height) end
