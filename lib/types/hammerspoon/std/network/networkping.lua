---@class NetworkPing
local NetworkPing

---@alias NetworkPingCallbackMessage
---| "'didStart'"
---| "'didFail'"
---| "'sendPacketFailed'"
---| "'receivedPacket'"
---| "'didFinish'"

---@alias NetworkPingCallback fun(object: NetworkPingObject, message: NetworkPingCallbackMessage, sequenceNumberOrError: number|string, error: string)

---@param server string
---@param count? number
---@param interval? number
---@param timeout? number
---@param class? "'any'"|"'IPv4'"|"'IPv6'"
---@param fn? NetworkPingCallback
---@return NetworkPingObject
function NetworkPing.ping(server, count, interval, timeout, class, fn) end

---@class NetworkPingObject
local NetworkPingObject

---@return string
function NetworkPingObject:address() end

function NetworkPingObject:cancel() end

---@param count? number
---@return number | NetworkPingObject | nil
function NetworkPingObject:count(count) end

---@return boolean
function NetworkPingObject:isPaused() end

---@return boolean
function NetworkPingObject:isRunning() end

---@class EchoRequest
---@field checksum string
---@field code 0
---@field identifier any
---@field payload string
---@field sequenceNumber number
---@field type number
---@field _raw string

---@class PacketInfo
---@field sent number
---@field recv number
---@field icmp EchoRequest

---@param sequenceNumber? number
---@return PacketInfo|PacketInfo[]
function NetworkPingObject:packets(sequenceNumber) end

---@return NetworkPingObject | nil
function NetworkPingObject:pause() end

---@return NetworkPingObject | nil
function NetworkPingObject:resume() end

---@return number
function NetworkPingObject:sent() end

---@return string
function NetworkPingObject:server() end

---@param fn NetworkPingCallback
---@return NetworkPingObject
function NetworkPingObject:setCallback(fn) end

---@return string
function NetworkPingObject:summary() end
