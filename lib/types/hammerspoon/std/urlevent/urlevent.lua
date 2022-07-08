---@alias URLCallback fun(scheme:string, host:string, params:table<string,string>, fullURL:string, senderPID: number)

---@alias EventCallback fun(eventName:string, params:table<string,string>, senderPID: number)

---@class HSURLEvent
---function that wil handle http:// and https:// URL events
---@field httpCallback URLCallback
---function that will handle mailto: URL events
---@field mailtoCallback URLCallback
local HSURLEvent

---Registers a callback for hammerspoon:// URL events
---@param eventName string @the name of an event
---@param callback EventCallback|nil @the function to be called when the event is received, or `nil` to remove an existing callback
function HSURLEvent.bind(eventName, callback) end

---Gets all of the application bundle identifiers of applications able to handle a URL scheme
---@param scheme string
---@return string[]
function HSURLEvent.getAllHandlersForScheme(scheme) end

---Gets the application bundle identifier of the application currently registered to handle a URL scheme
---@param scheme string
---@return string @the bundle identifier of the current default application
function HSURLEvent.getDefaultHandler(scheme) end

---Opens a URL with the default application
---@param url string
---@return boolean @`true` if the URL was opened successfully, otherwise `false`
function HSURLEvent.openURL(url) end

---Opens a URL with a specified application
---@param url string
---@param bundleID string @an application bundle identifier (e.g. "com.apple.Safari")
---@return boolean @`true` if the application was launched successfully, otherwise `false`
function HSURLEvent.openURLWithBundle(url, bundleID) end

---Sets the default system handler for URLs of a given scheme
---
---Notes:
--- * Changing the default handler for http/https URLs will display a system prompt asking the user to confirm the change
---@param scheme "'http'"|"'https'" @URL scheme to change (either way both will change)
---@param bundleID string|nil @application bundle identifier (Defaults to `org.hammerspoon.Hammerspoon`)
function HSURLEvent.setDefaultHandler(scheme, bundleID) end

---Stores a URL handler that will be restored when Hammerspoon reloads its config
---
---Notes:
--- * You don't have to call this function if you want Hammerspoon to permanently be your default handler. Only use this if you want the handler to be automatically reverted to something else when Hammerspoon exits/reloads.
---@param scheme "'http'" @URL scheme to change (either way both `http` and `https` will change)
---@param bundleID string @application bundle identifier (e.g. 'com.apple.Safari') for the application to set as the default handler when Hammerspoon exits or reloads its config
function HSURLEvent.setRestoreHandler(scheme, bundleID) end
