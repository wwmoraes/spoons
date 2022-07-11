---@class HSMenubar
---@field imagePositions ImagePositions
---@field priorities MenuPriorities
local HSMenubar

---@param inMenuBar? boolean
---@return Menubar | nil
function HSMenubar.new(inMenuBar) end

---@param priority number
---@return Menubar
function HSMenubar.newWithPriority(priority) end
