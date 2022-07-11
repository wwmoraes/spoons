---@class Menubar
local Menubar

function Menubar:delete()end

---@return Geometry | nil
function Menubar:frame()end

---@return Image
function Menubar:icon()end

---@param position number
---@return Menubar
---@overload fun(): number
function Menubar:imagePosition(position)end

---@return boolean
function Menubar:isInMenuBar()end

---@param point Point
---@param darkMode? boolean
---@return Menubar
function Menubar:popupMenu(point, darkMode)end

---@param priority number
---@return Menubar
---@overload fun(): number
function Menubar:priority(priority)end

---@return Menubar
function Menubar:removeFromMenuBar()end

---@return Menubar
function Menubar:returnToMenuBar()end

---@class ModifiersInfo
---@field cmd? boolean
---@field alt? boolean
---@field shift? boolean
---@field ctrl? boolean
---@field fn? boolean

---@alias MenubarClickCallback fun(modifiers: ModifiersInfo)

---@param fn MenubarClickCallback
---@return Menubar
function Menubar:setClickCallback(fn)end

---@param imageData Image | string | nil
---@param template? boolean
---@return Menubar | nil
function Menubar:setIcon(imageData, template)end

---@class MenubarItem
---@field title string | StyledText | "-"
---@field fn? MenubarItemCallback
---@field checked? boolean
---@field state? "on" | "off" | "mixed"
---@field menu? MenubarItem[]
---@field image? Image
---@field tooltip? string
---@field shortcut? string
---@field indent? number
---@field onStateImage? Image
---@field offStateImage? Image
---@field mixedStateImage? Image

---@alias MenubarItemCallback fun(modifiers: ModifiersInfo, item: MenubarItem)

---@alias MenubarCallback fun(modifiers: ModifiersInfo): MenubarItem

---@param menuTable? MenubarItem | MenubarCallback
---@return Menubar
function Menubar:setMenu(menuTable)end

---@param title string | StyledText | nil
---@return Menubar
function Menubar:setTitle(title)end

---@param tooltip string
---@return Menubar
function Menubar:setTooltip(tooltip)end

---@param size Size
---@return Menubar
---@overload fun(): Size
function Menubar:stateImageSize(size)end

---@param styled? boolean
---@return string | StyledText
function Menubar:title(styled)end
