---@class Network
---@field configuration NetworkConfiguration
---@field host NetworkHost
---@field ping NetworkPing
---@field reachability NetworkReachability
local Network

---@param interface_list? string[]
---@return string[]
---@overload fun(...: string): string[]
function Network.addresses(interface_list) end

---@param interface? string
---@return InterfaceDetails
---@overload fun(favorIPv6?: boolean): InterfaceDetails
function Network.interfaceDetails(interface) end

---@param interface? string
---@return string
---@overload fun(favorIPv6?: boolean): string
function Network.interfaceName(interface) end

---@return string[]|nil
function Network.interfaces() end

---@return string|false|nil ipv4Interface
---@return string|false ipv6Interface
function Network.primaryInterfaces() end
