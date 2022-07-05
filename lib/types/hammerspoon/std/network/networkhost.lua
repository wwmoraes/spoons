---@class NetworkHost
local NetworkHost

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
---@return NetworkHostObject
---@overload fun(name: string): string[]
function NetworkHost.addressesForHostname(name, fn) end

---@param address string|number
---@param fn NetworkHostResolutionCallback
---@return NetworkHostObject
---@overload fun(address: string|number): string[]
function NetworkHost.hostnamesForAddress(address, fn) end

---@param address string|number
---@param fn NetworkHostReachabilityCallback
---@return NetworkHostObject
---@overload fun(address: string|number): string[]
function NetworkHost.reachabilityForAddress(address, fn) end

---@param name string|number
---@param fn NetworkHostReachabilityCallback
---@return NetworkHostObject
---@overload fun(name: string|number): string[]
function NetworkHost.reachabilityForHostname(name, fn) end

---@class NetworkHostObject
local NetworkHostObject

---@return NetworkHostObject
function NetworkHostObject:cancel() end

---@return boolean
function NetworkHostObject:isRunning() end
