---@class HSFnUtils
local HSFnUtils

---@generic T1 : table, T2 : table
---@param table1 T1
---@param table2 T2
---@return T1|T2
function HSFnUtils.concat(table1, table2) end

---@generic Key: any, Value: any
---@param tbl table<Key, Value>
---@param element Value
---@return boolean
function HSFnUtils.contains(tbl, element) end

---@generic Table : table
---@param tbl Table
---@return Table
function HSFnUtils.copy(tbl) end

---@generic Key: any, Value: any
---@param tbl table<Key, Value>
---@param fn fun(element: Value)
function HSFnUtils.each(tbl, fn) end

---@generic Key: any, Value: any
---@param tbl table<Key, Value>
---@param fn fun(element: Value): boolean
---@return boolean
function HSFnUtils.every(tbl, fn) end

---@generic Table: table, Key: any, Value: any
---@param tbl Table<Key, Value>
---@param fn fun(element: Value): boolean
---@return Table
function HSFnUtils.filter(tbl, fn) end

---@generic Key: any, Value: any
---@param tbl table<Key, Value>
---@param fn fun(element: Value): boolean
---@return Value
function HSFnUtils.find(tbl, fn) end

---@generic Value: any
---@param list Value[]
---@param fn fun(element: Value)
function HSFnUtils.ieach(list, fn) end

---@generic Value: any
---@param list Value[]
---@param fn fun(element: Value): boolean
---@return Value[]
function HSFnUtils.ifilter(list, fn) end

---@generic Value: any, Result: any
---@param list Value[]
---@param fn fun(element: Value): Result|nil
---@return Result[]
function HSFnUtils.imap(list, fn) end

---@generic Key: any, Value: any
---@param tbl table<Key, Value>
---@param element Value
---@return number | nil
function HSFnUtils.indexOf(tbl, element) end

---@generic Key: any, Value: any, Result: any
---@param tbl table<Key, Value>|Value[]
---@param fn fun(element: Value): Result
---@return table<Key, Result>|Result[]
function HSFnUtils.map(tbl, fn) end

---@generic Key: any, Value: any, Result: table
---@param tbl table<Key, Value>
---@param fn fun(element: Value): Result
---@return Result[]
function HSFnUtils.mapCat(tbl, fn) end

---@generic Key: any, Value: any
---@param tbl table<Key, Value>
---@param fn fun(first: Value, second: Value): Value
---@return Value
function HSFnUtils.reduce(tbl, fn) end

---@generic Key: any, Value: any
---@param tbl table<Key, Value>
---@param fn fun(element: Value): boolean
---@return boolean
function HSFnUtils.some(tbl, fn) end

---@param sString string
---@param sSeparator string
---@param nMax? number
---@param bPlain? boolean
---@return string[]
function HSFnUtils.split(sString, sSeparator, nMax, bPlain) end

---@generic Key: any, Value: any
---@param tbl table<Key, Value>
---@return fun(): Value
function HSFnUtils.cycle(tbl) end

---@param fn function
---@param ... any
---@return function
function HSFnUtils.partial(fn, ...) end

---@generic Value: any
---@param ... fun(): Value
---@return fun(): Value[]
function HSFnUtils.sequence(...) end

---@generic Key: any, Value: any
---@param tbl table<Key, Value>
---@param fn fun(a: Key, b: Key): boolean
---@return fun(): Key, Value
function HSFnUtils.sortByKeys(tbl, fn) end

---@generic Key: any, Value: any
---@param tbl table<Key, Value>
---@param fn fun(a: Value, b: Value): boolean
---@return fun(): Key, Value
function HSFnUtils.sortByKeyValues(tbl, fn) end
