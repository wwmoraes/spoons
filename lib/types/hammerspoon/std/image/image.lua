---@class HSImage
---@field additionalImageNames AdditionalImageNames
---@field systemImageNames SystemImageNames
local HSImage

---@param path string
---@return table? -- // TODO EXIF table
function HSImage.getExifFromPath(path) end

---@param file string | string[]
---@return Image?
function HSImage.iconForFile(file) end

---@param fileType string
---@return Image?
function HSImage.iconForFileType(fileType) end

---@param bundleID string
---@return Image?
function HSImage.imageFromAppBundle(bundleID) end

---@param ascii string
---@param context? ContextOptions[]
---@return Image?
function HSImage.imageFromASCII(ascii, context) end

---@class ContextOptions
-- the color with which the shape will be filled (defaults to black)
---@field fillColor? RGBColor
-- the color with which the shape will be stroked (defaults to black)
---@field strokeColor RGBColor
-- the line width for the stroke of the shape (defaults to 1 if anti-aliasing is
-- on or (√2)/2 if it is off - approximately 0.7)
---@field lineWidth number
-- a boolean indicating whether or not the shape should be closed
-- (defaults to `true`)
---@field shouldClose boolean
-- a boolean indicating whether or not the shape should be antialiased
-- (defaults to `true`)
---@field antialias boolean

---@param file string
---@return Image?
function HSImage.imageFromMediaFile(file) end

---@param name string
---@return Image?
function HSImage.imageFromName(name) end

---@param path string
---@return Image?
function HSImage.imageFromPath(path) end

---@alias ImageCallback fun(image: Image) -- // TODO confirm callback argument

---@param url string
---@param callbackFn? ImageCallback
---@return Image?
function HSImage.imageFromURL(url, callbackFn) end
