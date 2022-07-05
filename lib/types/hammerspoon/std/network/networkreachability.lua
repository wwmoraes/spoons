---@class NetworkReachability
---@field flags NetworkFlags
local NetworkReachability

---@param address string|number
---@return Reachability
function NetworkReachability.forAddress(address) end

---@param localAddress string|number
---@param remoteAddress string|number
---@return Reachability
function NetworkReachability.forAddressPair(localAddress, remoteAddress) end

---@param hostName string
---@return Reachability
function NetworkReachability.forHostName(hostName) end

---@return Reachability
function NetworkReachability.internet() end

---@return Reachability
function NetworkReachability.linkLocal() end

---@class Reachability
local Reachability

---@alias ReachabilityCallback fun(self:Reachability, flags:number)

---@param callback ReachabilityCallback|nil
---@return Reachability
function Reachability:setCallback(callback) end

---@return Reachability
function Reachability:start() end

---@return number
function Reachability:status() end

---@return string
function Reachability:statusString() end

---@return Reachability
function Reachability:stop() end
