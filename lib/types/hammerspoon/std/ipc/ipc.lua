---@class HSIPC
local HSIPC

---@class CLIColors
---@field initial string
---@field input string
---@field output string
---@field error string

---@deprecated
---@return CLIColors
function HSIPC.cliGetColors() end

---@deprecated
function HSIPC.cliResetColors() end

---@deprecated
---@param table CLIColors
---@return CLIColors
function HSIPC.cliSetColors(table) end

---@param colors CLIColors
---@return CLIColors
function HSIPC.cliColors(colors) end

---@param path? string
---@param silent? boolean
---@return boolean
function HSIPC.cliInstall(path, silent) end

---@param state? boolean
---@return boolean
function HSIPC.cliSaveHistory(state) end

---@param size? number
---@return number
function HSIPC.cliSaveHistorySize(size) end

---@param path? string
---@param silent? boolean
---@return boolean
function HSIPC.cliStatus(path, silent) end

---@param path? string
---@param silent? boolean
---@return boolean
function HSIPC.cliUninstall(path, silent) end

---@param name string
---@param fn function
---@return IPC
function HSIPC.localPort(name, fn) end

---@param name string
---@return IPC
function HSIPC.remotePort(name) end
