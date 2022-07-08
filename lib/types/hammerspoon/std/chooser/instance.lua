---@class Chooser
local Chooser

---@param toolbar WebViewToolbar | nil
---@return Chooser
---@overload fun(): WebViewToolbar | nil
function Chooser:attachedToolbar(toolbar) end

---@param beDark boolean
---@return Chooser
---@overload fun(): boolean
function Chooser:bgDark(beDark) end

---@return Chooser
function Chooser:cancel() end

---@param choices Choice[] | fun(): Choice[] | nil
---@return Chooser
function Chooser:choices(choices) end

function Chooser:delete() end

---@param color DrawingColor | nil
---@return Chooser
---@overload fun(): DrawingColor
function Chooser:fgColor(color) end

---@return Chooser
function Chooser:hide() end

---@param fn? function
---@return Chooser
function Chooser:hideCallback(fn) end

---@param fn? fun(choice: Choice)
---@return Chooser
function Chooser:invalidCallback(fn) end

---@return boolean
function Chooser:isVisible() end

---@param placeholderText string
---@return Chooser
---@overload fun(): string
function Chooser:placeholderText(placeholderText) end

---@param queryString string
---@return Chooser
---@overload fun(): string
function Chooser:query(queryString) end

---@param fn? fun(query: string)
---@return Chooser
function Chooser:queryChangedCallback(fn) end

---@param reload? boolean
---@return Chooser
function Chooser:refreshChoicesCallback(reload) end

---@param fn? fun(row: number)
---@return Chooser
function Chooser:rightClickCallback(fn) end

---@param numRows number
---@return Chooser
---@overload fun(): number
function Chooser:rows(numRows) end

---@param searchSubText boolean
---@return Chooser
---@overload fun(): boolean
function Chooser:searchSubText(searchSubText) end

---@param row? number
---@return Chooser
function Chooser:select(row) end

---@param row number
---@return Chooser
---@overload fun(): number
function Chooser:selectedRow(row) end

---@param row? number
---@return Choice
function Chooser:selectedRowContents(row) end

---@param topLeftPoint? Geometry
---@return Chooser
function Chooser:show(topLeftPoint) end

---@param fn function
---@return Chooser
function Chooser:showCallback(fn) end

---@param color DrawingColor | nil
---@return Chooser
---@overload fun(): DrawingColor
function Chooser:subTextColor(color) end

---@param percent number
---@return Chooser
---@overload fun(): number
function Chooser:width(percent) end
