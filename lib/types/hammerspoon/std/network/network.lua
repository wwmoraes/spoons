---@class HSNetwork
---@field configuration HSNetworkConfiguration
---@field host HSNetworkHost
---@field ping HSNetworkPing
---@field reachability HSNetworkReachability
local HSNetwork

---@param interface_list? string[]
---@return string[]
---@overload fun(...: string): string[]
function HSNetwork.addresses(interface_list) end

---@param interface? string
---@return InterfaceDetails
---@overload fun(favorIPv6?: boolean): InterfaceDetails
function HSNetwork.interfaceDetails(interface) end

---@param interface? string
---@return string
---@overload fun(favorIPv6?: boolean): string
function HSNetwork.interfaceName(interface) end

---@return string[]|nil
function HSNetwork.interfaces() end

---@return string|false|nil ipv4Interface
---@return string|false ipv6Interface
function HSNetwork.primaryInterfaces() end
