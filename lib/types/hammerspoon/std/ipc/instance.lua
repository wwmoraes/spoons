---@class IPC
local IPC

function IPC:delete() end

---@return boolean
function IPC:isRemote() end

---@return boolean
function IPC:isValid() end

---@return string
function IPC:name() end

---@param data any
---@param msgID number
---@param waitTimeout? number
---@param oneWay? boolean
---@return boolean status
---@return string|nil response
function IPC:sendMessage(data, msgID, waitTimeout, oneWay) end
