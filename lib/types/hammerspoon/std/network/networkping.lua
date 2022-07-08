---@class HSNetworkPing
local HSNetworkPing

---@alias NetworkPingCallbackMessage
---| "'didStart'"
---| "'didFail'"
---| "'sendPacketFailed'"
---| "'receivedPacket'"
---| "'didFinish'"

---@alias NetworkPingCallback fun(object: NetworkPing, message: NetworkPingCallbackMessage, sequenceNumberOrError: number|string, error: string)

---@param server string
---@param count? number
---@param interval? number
---@param timeout? number
---@param class? "'any'"|"'IPv4'"|"'IPv6'"
---@param fn? NetworkPingCallback
---@return NetworkPing
function HSNetworkPing.ping(server, count, interval, timeout, class, fn) end

---@class NetworkPing
local NetworkPing

---@return string
function NetworkPing:address() end

function NetworkPing:cancel() end

---@param count? number
---@return number | NetworkPing | nil
function NetworkPing:count(count) end

---@return boolean
function NetworkPing:isPaused() end

---@return boolean
function NetworkPing:isRunning() end

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
function NetworkPing:packets(sequenceNumber) end

---@return NetworkPing | nil
function NetworkPing:pause() end

---@return NetworkPing | nil
function NetworkPing:resume() end

---@return number
function NetworkPing:sent() end

---@return string
function NetworkPing:server() end

---@param fn NetworkPingCallback
---@return NetworkPing
function NetworkPing:setCallback(fn) end

---@return string
function NetworkPing:summary() end
