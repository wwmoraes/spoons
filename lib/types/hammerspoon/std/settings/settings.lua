-- // TODO hs.settings

---@class HSSettings
---@field bundleID string
---@field dateFormat string
local HSSettings

---@param key string
---@return boolean
function HSSettings.clear(key) end

---@param key string
---@return string | boolean | number | nil | table
function HSSettings.get(key) end

---@return string[]
function HSSettings.getKeys() end

---@param key string
---@param val? string | number | boolean | table
function HSSettings.set(key, val) end

---@param key string
---@param val string
function HSSettings.setData(key, val) end

---@param key string
---@param val string | number
function HSSettings.setDate(key, val) end

---@alias WatchKeyCallback function

---@param identifier string
---@param key string
---@param fn WatchKeyCallback | nil
---@return string
---@overload fun(identifier: string, key: string): WatchKeyCallback | nil
function HSSettings.watchKey(identifier, key, fn) end
