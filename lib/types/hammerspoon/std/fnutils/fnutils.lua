---@class FnUtils
local FnUtils

---@generic T1 : table, T2 : table
---@param table1 T1
---@param table2 T2
---@return T1|T2
function FnUtils.concat(table1, table2) end

---@generic Key: any, Value: any
---@param tbl table<Key, Value>
---@param element Value
---@return boolean
function FnUtils.contains(tbl, element) end

---@generic Table : table
---@param tbl Table
---@return Table
function FnUtils.copy(tbl) end

---@generic Key: any, Value: any
---@param tbl table<Key, Value>
---@param fn fun(element: Value)
function FnUtils.each(tbl, fn) end

---@generic Key: any, Value: any
---@param tbl table<Key, Value>
---@param fn fun(element: Value): boolean
---@return boolean
function FnUtils.every(tbl, fn) end

---@generic Table: table, Key: any, Value: any
---@param tbl Table<Key, Value>
---@param fn fun(element: Value): boolean
---@return Table
function FnUtils.filter(tbl, fn) end

---@generic Key: any, Value: any
---@param tbl table<Key, Value>
---@param fn fun(element: Value): boolean
---@return Value
function FnUtils.find(tbl, fn) end

---@generic Value: any
---@param list Value[]
---@param fn fun(element: Value)
function FnUtils.ieach(list, fn) end

---@generic Value: any
---@param list Value[]
---@param fn fun(element: Value): boolean
---@return Value[]
function FnUtils.ifilter(list, fn) end

---@generic Value: any, Result: any
---@param list Value[]
---@param fn fun(element: Value): Result|nil
---@return Result[]
function FnUtils.imap(list, fn) end

---@generic Key: any, Value: any
---@param tbl table<Key, Value>
---@param element Value
---@return number | nil
function FnUtils.indexOf(tbl, element) end

---@generic Key: any, Value: any, Result: any
---@param tbl table<Key, Value>|Value[]
---@param fn fun(element: Value): Result
---@return table<Key, Result>|Result[]
function FnUtils.map(tbl, fn) end

---@generic Key: any, Value: any, Result: table
---@param tbl table<Key, Value>
---@param fn fun(element: Value): Result
---@return Result[]
function FnUtils.mapCat(tbl, fn) end

---@generic Key: any, Value: any
---@param tbl table<Key, Value>
---@param fn fun(first: Value, second: Value): Value
---@return Value
function FnUtils.reduce(tbl, fn) end

---@generic Key: any, Value: any
---@param tbl table<Key, Value>
---@param fn fun(element: Value): boolean
---@return boolean
function FnUtils.some(tbl, fn) end

---@param sString string
---@param sSeparator string
---@param nMax? number
---@param bPlain? boolean
---@return string[]
function FnUtils.split(sString, sSeparator, nMax, bPlain) end

---@generic Key: any, Value: any
---@param tbl table<Key, Value>
---@return fun(): Value
function FnUtils.cycle(tbl) end

---@param fn function
---@param ... any
---@return function
function FnUtils.partial(fn, ...) end

---@generic Value: any
---@param ... fun(): Value
---@return fun(): Value[]
function FnUtils.sequence(...) end

---@generic Key: any, Value: any
---@param tbl table<Key, Value>
---@param fn fun(a: Key, b: Key): boolean
---@return fun(): Key, Value
function FnUtils.sortByKeys(tbl, fn) end

---@generic Key: any, Value: any
---@param tbl table<Key, Value>
---@param fn fun(a: Value, b: Value): boolean
---@return fun(): Key, Value
function FnUtils.sortByKeyValues(tbl, fn) end
