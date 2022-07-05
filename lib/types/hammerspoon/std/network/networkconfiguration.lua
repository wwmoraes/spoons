---@class NetworkConfiguration
local NetworkConfiguration

---@return SystemConfigurationStore
function NetworkConfiguration.open() end

---@class SystemConfigurationStore
local SystemConfigurationStore

---@return string
function SystemConfigurationStore:hostname() end

---@param keypattern? string
---@return string[]
function SystemConfigurationStore:keys(keypattern) end

---@return string
function SystemConfigurationStore:location() end

---@return table<string,string>
function SystemConfigurationStore:locations() end

---@param keys? string|string[]
---@param pattern? boolean
---@return SystemConfigurationStore
function SystemConfigurationStore:monitorKeys(keys, pattern) end

---@class ScopedProxyInfo
---@field ExcludeSimpleHostnames 0|1
---@field FTPEnable 0|1
---@field HTTPEnable 0|1
---@field HTTPSEnable 0|1
---@field ProxyAutoConfigEnable 0|1
---@field ProxyAutoConfigURLString string
---@field ProxyAutoDiscoveryEnable 0|1
---@field SOCKSEnable 0|1

---@class ProxyInfo : ScopedProxyInfo
---@field __SCOPED__ table<string,ScopedProxyInfo>

---@return ProxyInfo
function SystemConfigurationStore:proxies() end

---@alias SystemConfigurationStoreCallback fun(store: SystemConfigurationStore, keys: string[])

---@param func SystemConfigurationStoreCallback
---@return SystemConfigurationStore
function SystemConfigurationStore:setCallback(func) end

---@param location string
---@return boolean
function SystemConfigurationStore:setLocation(location) end

---@return SystemConfigurationStore
function SystemConfigurationStore:start() end

---@return SystemConfigurationStore
function SystemConfigurationStore:stop() end
