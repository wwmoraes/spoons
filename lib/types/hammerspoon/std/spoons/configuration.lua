--- @alias Hotkeys HotkeyMapping|"default"

--- @class SpoonConfiguration
--- @field public config table? @a table containing variables to be stored in the Spoon object to configure it. For example, config = { answer = 42 } will result in spoon.<LoadedSpoon>.answer being set to 42.
--- @field public hotkeys Hotkeys? @a table containing hotkey bindings. If provided, will be passed as-is to the Spoon's bindHotkeys() method. The special string "default" can be given to use the Spoons defaultHotkeys variable, if it exists.
--- @field public fn SpoonConfigurationCallback? @function which will be called with the freshly-loaded Spoon object as its first argument
--- @field public loglevel LogLevel? @if the Spoon has a variable called logger, its setLogLevel() method will be called with this value.
--- @field public start boolean? @if `true`, call the Spoon's `start()` method after configuring everything else
