---@class InspectOptions
--- maximum depth to recurse into variable. Below that depth, data will be displayed as {...}
---@field depth number
--- line breaks string. Defaults to `\n`
---@field newline string
--- indentation string. Defaults to `  ` (two spaces)
---@field indent string
--- function that will be called for each item
---@field process InspectProcessFn
--- if true, include (and traverse) metatables
---@field metatables boolean
