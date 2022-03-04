---@class SpoonInstallRepo
---@field url string
---@field desc string
---@field branch string

--- Install and manage Spoons and Spoon repositories
---@class SpoonInstall : Spoon
--- Whether `andUse()` updates repos and install packages synchronously.
--- Defaults to `false`.
---@field use_syncinstall boolean
--- dictionary of available Spoon repositories
---@field repos table<string,SpoonInstallRepo>
SpoonInstall = SpoonInstall

---@param name string
---@param arg SpoonConfiguration
function SpoonInstall:andUse(name, arg)end
