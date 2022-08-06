---@class HSOSAScript
local HSOSAScript

-- Runs osascript code
---@param source string
---@param language? "'AppleScript'" | "'JavaScript'"
---@return boolean success
---@return table? output
---@return string raw
function HSOSAScript._osascript(source, language) end

---@param source string
---@return boolean success
---@return table? output
---@return string|table raw
function HSOSAScript.applescript(source) end

---@param fileName string
---@return boolean success
---@return table? output
---@return string|table raw
function HSOSAScript.applescriptFromFile(fileName) end

---@param source string
---@return boolean success
---@return table? output
---@return string|table raw
function HSOSAScript.javascript(source) end

---@param fileName string
---@return boolean success
---@return table? output
---@return string|table raw
function HSOSAScript.javascriptFromFile(fileName) end
