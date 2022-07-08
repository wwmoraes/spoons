---@class HSNetworkHost
local HSNetworkHost

-- indicates which type of resolution was performed
---@param action "'addresses'"|"'names'"
-- resolved addresses or hostnames
---@param result string[]
-- processes a network resolution request result
---@alias NetworkHostResolutionCallback fun(action: "'addresses'"|"'names'", result: string[])

-- indicates which type of resolution was performed
---@param action "'reachability'"
-- resolved reachability status
---@param result number
-- processes a network resolution request result
---@alias NetworkHostReachabilityCallback fun(action: "'reachability'", result: number)

---@param name string
---@param fn NetworkHostResolutionCallback
---@return NetworkHost
---@overload fun(name: string): string[]
function HSNetworkHost.addressesForHostname(name, fn) end

---@param address string|number
---@param fn NetworkHostResolutionCallback
---@return NetworkHost
---@overload fun(address: string|number): string[]
function HSNetworkHost.hostnamesForAddress(address, fn) end

---@param address string|number
---@param fn NetworkHostReachabilityCallback
---@return NetworkHost
---@overload fun(address: string|number): string[]
function HSNetworkHost.reachabilityForAddress(address, fn) end

---@param name string|number
---@param fn NetworkHostReachabilityCallback
---@return NetworkHost
---@overload fun(name: string|number): string[]
function HSNetworkHost.reachabilityForHostname(name, fn) end

---@class NetworkHost
local NetworkHost

---@return NetworkHost
function NetworkHost:cancel() end

---@return boolean
function NetworkHost:isRunning() end
