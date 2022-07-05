---@class Chooser
---@field globalCallback fun(chooser: ChooserObject, eventName: "'willOpen'"|"'didClose'")
local Chooser

---@class ChooserObject
local ChooserObject

---@param completionFn function
---@return ChooserObject
function Chooser.new(completionFn) end

---@param toolbar ToolbarObject | nil
---@return ChooserObject
---@overload fun(): ToolbarObject | nil
function ChooserObject:attachedToolbar(toolbar) end

---@param beDark boolean
---@return ChooserObject
---@overload fun(): boolean
function ChooserObject:bgDark(beDark) end

---@return ChooserObject
function ChooserObject:cancel() end

---@class Choice
---@param text string | StyledTextObject
---@param subText? string | StyledTextObject
---@param image? ImageInstance
---@param valid? boolean

---@param choices Choice[] | fun(): Choice[] | nil
---@return ChooserObject
function ChooserObject:choices(choices) end

function ChooserObject:delete() end

---@param color DrawingColor | nil
---@return ChooserObject
---@overload fun(): DrawingColor
function ChooserObject:fgColor(color) end

---@return ChooserObject
function ChooserObject:hide() end

---@param fn? function
---@return ChooserObject
function ChooserObject:hideCallback(fn) end

---@param fn? fun(choice: Choice)
---@return ChooserObject
function ChooserObject:invalidCallback(fn) end

---@return boolean
function ChooserObject:isVisible() end

---@param placeholderText string
---@return ChooserObject
---@overload fun(): string
function ChooserObject:placeholderText(placeholderText) end

---@param queryString string
---@return ChooserObject
---@overload fun(): string
function ChooserObject:query(queryString) end

---@param fn? fun(query: string)
---@return ChooserObject
function ChooserObject:queryChangedCallback(fn) end

---@param reload? boolean
---@return ChooserObject
function ChooserObject:refreshChoicesCallback(reload) end

---@param fn? fun(row: number)
---@return ChooserObject
function ChooserObject:rightClickCallback(fn) end

---@param numRows number
---@return ChooserObject
---@overload fun(): number
function ChooserObject:rows(numRows) end

---@param searchSubText boolean
---@return ChooserObject
---@overload fun(): boolean
function ChooserObject:searchSubText(searchSubText) end

---@param row? number
---@return ChooserObject
function ChooserObject:select(row) end

---@param row number
---@return ChooserObject
---@overload fun(): number
function ChooserObject:selectedRow(row) end

---@param row? number
---@return Choice
function ChooserObject:selectedRowContents(row) end

---@param topLeftPoint? GeometryInstance
---@return ChooserObject
function ChooserObject:show(topLeftPoint) end

---@param fn function
---@return ChooserObject
function ChooserObject:showCallback(fn) end

---@param color DrawingColor | nil
---@return ChooserObject
---@overload fun(): DrawingColor
function ChooserObject:subTextColor(color) end

---@param percent number
---@return ChooserObject
---@overload fun(): number
function ChooserObject:width(percent) end
