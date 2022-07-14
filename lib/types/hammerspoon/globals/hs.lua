--- Core Hammerspoon functionality
--- @class Hammerspoon
---
--- configuration directory (typically `~/.hammerspoon`)
--- @field configdir string
--- full path to the `docs.json` file inside Hammerspoon's app bundle. This
--- contains the full Hammerspoon API documentation and can be accessed in the
--- Console using `help("someAPI")`. It can also be loaded and processed by the
--- `hs.doc` extension
--- @field docstrings_json_file string
--- read-only information about the current Hammerspoon instance
--- @field processInfo ProcessInfo
--- an optional function that will be called when the Accessibility State is
--- changed
---
--- Notes:
---
--- * The function will not receive any arguments when called. To check what the
--- accessibility state has been changed to, you should call
--- `hs.accessibilityState` from within your function
--- @field accessibilityStateCallback VoidCallback
--- Gathers tab completion options for the Console window
---
--- Notes:
---
--- * Hammerspoon provides a default implementation of this function, which can
--- complete against the global Lua namespace, the `hs` (i.e. extension)
--- namespace, and object metatables. You can assign a new function to the
--- variable to replace it with your own variant.
--- @field completionsForInputString CompletionsCallback
--- @field dockIconClickCallback VoidCallback
--- @field fileDroppedToDockIconCallback FileCallback
--- @field shutdownCallback VoidCallback
--- @field textDroppedToDockIconCallback TextCallback
---
--- @field alert HSAlert
--- @field appfinder HSAppFinder
--- @field applescript HSAppleScript
--- @field application HSApplication
--- @field audiodevice HSAudioDevice
--- @field axuielement HSAxUIElement
--- @field base64 HSBase64
--- @field battery HSBattery
--- @field bonjour HSBonjour
--- @field brightness HSBrightness
--- @field caffeinate HSCaffeinate
--- @field canvas HSCanvas
--- @field chooser HSChooser
--- @field console HSConsole
--- @field crash HSCrash
--- @field deezer HSDeezer
--- @field dialog HSDialog
--- @field distributednotifications HSDistributedNotifications
--- @field doc HSDoc
--- @field dockicon HSDockIcon
--- @field drawing HSDrawing
--- @field eventtap HSEventTap
--- @field expose HSExpose
--- @field fnutils HSFnUtils
--- @field fs HSFs
--- @field geometry HSGeometry
--- @field grid HSGrid
--- @field hash HSHash
--- @field hid HSHID
--- @field hints HSHints
--- @field host HSHost
--- @field hotkey HSHotkey
--- @field http HSHTTP
--- @field httpserver HSHTTPServer
--- @field image HSImage
--- @field inspect HSInspect
--- @field ipc HSIPC
--- @field itunes HSItunes
--- @field json HSJSON
--- @field keycodes HSKeycodes
--- @field layout HSLayout
--- @field location HSLocation
--- @field logger HSLogger
--- @field math HSMath
--- @field menubar HSMenubar
--- @field messages HSMessages
--- @field midi HSMidi
--- @field milight HSMilight
--- @field mjomatic HSMjomatic
--- @field mouse HSMouse
--- @field network HSNetwork
--- @field noises HSNoises
--- @field notify HSNotify
--- @field osascript HSOSAScript
--- @field pasteboard HSPasteboard
--- @field pathwatcher HSPathwatcher
--- @field plist HSPlist
--- @field redshift HSRedshift
--- @field screen HSScreen
--- @field serial HSSerial
--- @field settings HSSettings
--- @field sharing HSSharing
--- @field socket HSSocket
--- @field sound HSSound
--- @field spaces HSSpaces
--- @field speech HSSpeech
--- @field spoons HSSpoons
--- @field spotify HSSpotify
--- @field spotlight HSSpotlight
--- @field sqlite3 HSSqlite3
--- @field streamdeck HSStreamdeck
--- @field styledtext HSStyledText
--- @field tabs HSTabs
--- @field tangent HSTangent
--- @field task HSTask
--- @field timer HSTimer
--- @field uielement HSUIElement
--- @field urlevent HSURLEvent
--- @field usb HSUSB
--- @field utf8 HSUTF8
--- @field vox HSVox
--- @field watchable HSWatchable
--- @field websocket HSWebsocket
--- @field webview HSWebView
--- @field wifi HSWifi
--- @field window HSWindow
local Hammerspoon

---@param shouldPrompt boolean
---@return boolean isEnabled
function Hammerspoon.accessibilityState(shouldPrompt) end

---@param state boolean
---@return boolean isEnabled
function Hammerspoon.allowAppleScript(state) end

---@param state boolean
---@return boolean isEnabled
function Hammerspoon.autoLaunch(state) end

---@param setting boolean
---@return boolean isEnabled
function Hammerspoon.automaticallyCheckForUpdates(setting) end

---@param shouldPrompt boolean
---@return boolean isEnabled
function Hammerspoon.cameraState(shouldPrompt) end

---@return boolean
function Hammerspoon.canCheckForUpdates() end

---@param silent boolean
function Hammerspoon.checkForUpdates(silent) end

---@param inString string
---@return string outString
function Hammerspoon.cleanUTF8forConsole(inString) end

function Hammerspoon.closeConsole() end

function Hammerspoon.closePreferences() end

---@param state boolean
---@return boolean isEnabled
function Hammerspoon.consoleOnTop(state) end

---@param delay number
function Hammerspoon.coroutineApplicationYield(delay) end

---@param state boolean
---@return boolean isEnabled
function Hammerspoon.dockIcon(state) end

---Runs a shell command, optionally loading the users shell environment first,
---and returns stdout, followed by the same result codes as `os.execute` would
---return.
---
--- * Setting `with_user_env` to `true` does incur noticeable overhead, so it should only be used if necessary (to set the path or other environment variables).
--- * Because this function returns the stdout as it's first return value, it is not quite a drop-in replacement for `os.execute`. In most cases, it is probable that stdout will be the empty string when status is `nil`, but this is not guaranteed, so this trade off of shifting `os.execute`'s results was deemed acceptable.
--- * This particular function is most useful when you're more interested in the command's output then a simple check for completion and result codes. If you only require the result codes or verification of command completion, then `os.execute` will be slightly more efficient.
--- * If you need to execute commands that have spaces in their paths, use a form like: `hs.execute [["/Some/Path To/An/Executable" "--first-arg" "second-arg"]]`
---
---@param command string @shell command to execute
---@param with_user_env? boolean @if true, executes the command in the users login shell as an "interactive" login shell causing the user's local profile (or other login scripts) to be loaded first.
---@return string output @stdout of the command. May contain an extra terminating new-line (\n).
---@return boolean status @`true` if the command terminated successfully or `nil` otherwise.
---@return '"exit"'|'"signal"' type @indicates whether the command terminated of its own accord or if it was terminated by a signal
---@return number rc @return code
function Hammerspoon.execute(command, with_user_env) end

function Hammerspoon.focus() end

---@param name string
---@return table|nil
function Hammerspoon.getObjectMetatable(name) end

---@param identifier string
function Hammerspoon.help(identifier) end

---@param identifier string
function Hammerspoon.hsdocs(identifier) end

--- Loads a Spoon
---@param name string @The name of a Spoon (without the trailing `.spoon`)
---@param global boolean @If `true`, this function will insert the spoon into Lua's global namespace as `spoon.NAME`. Defaults to `true`.
---@return Spoon
function Hammerspoon.loadSpoon(name, global) end

---@param state boolean
---@return boolean isEnabled
function Hammerspoon.menuIcon(state) end

---@param shouldPrompt boolean
---@return boolean isEnabled
function Hammerspoon.microphoneState(shouldPrompt) end

---@param filePath string
function Hammerspoon.open(filePath) end

function Hammerspoon.openAbout() end

---@param bringToFront boolean
function Hammerspoon.openConsole(bringToFront) end

---@param state boolean
---@return boolean isEnabled
function Hammerspoon.openConsoleOnDockClick(state) end

function Hammerspoon.openPreferences() end

---@param state boolean
---@return boolean isEnabled
function Hammerspoon.preferencesDarkMode(state) end

---@param format string
---@param ... any
function Hammerspoon.printf(format, ...) end

---@param aString string
function Hammerspoon.rawprint(aString) end

function Hammerspoon.relaunch() end

function Hammerspoon.reload() end

---@param shouldPrompt boolean
---@return boolean isEnabled
function Hammerspoon.screenRecordingState(shouldPrompt) end

---@param err string
function Hammerspoon.showError(err) end

function Hammerspoon.toggleConsole() end

--- Gets the version & build number of an available update
---@return string|boolean @display version of the latest release, `false` if no update is available
---@return string|nil
function Hammerspoon.updateAvailable() end

---@param state boolean
---@return boolean isEnabled
function Hammerspoon.uploadCrashData(state) end

hs = Hammerspoon
