---@class HSNetworkReachability
---@field flags NetworkFlags
local HSNetworkReachability

---@param address string|number
---@return NetworkReachability
function HSNetworkReachability.forAddress(address) end

---@param localAddress string|number
---@param remoteAddress string|number
---@return NetworkReachability
function HSNetworkReachability.forAddressPair(localAddress, remoteAddress) end

---@param hostName string
---@return NetworkReachability
function HSNetworkReachability.forHostName(hostName) end

---@return NetworkReachability
function HSNetworkReachability.internet() end

---@return NetworkReachability
function HSNetworkReachability.linkLocal() end

---@class NetworkReachability
local NetworkReachability

---@alias ReachabilityCallback fun(self:NetworkReachability, flags:number)

---@param callback ReachabilityCallback|nil
---@return NetworkReachability
function NetworkReachability:setCallback(callback) end

---@return NetworkReachability
function NetworkReachability:start() end

---@return number
function NetworkReachability:status() end

---@return string
function NetworkReachability:statusString() end

---@return NetworkReachability
function NetworkReachability:stop() end
