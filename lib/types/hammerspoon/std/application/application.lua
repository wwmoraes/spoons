--- @class HSApplication
--- @field menuGlyphs table<number,string>
local HSApplication

--- @param pid integer
--- @return Application|nil
function HSApplication.applicationForPID(pid) end

--- @param bundleID string
--- @return Application[]
function HSApplication.applicationsForBundleID(bundleID) end

--- @param uti string
--- @return string|nil
function HSApplication.defaultAppForUTI(uti) end

--- @param state boolean|nil
--- @return boolean
function HSApplication.enableSpotlightForNameSearches(state) end

--- @return Application
function HSApplication.frontmostApplication() end

--- @param bundleID string
--- @return table|nil
function HSApplication.infoForBundleID(bundleID) end

--- @param bundlePath string
--- @return table|nil
function HSApplication.infoForBundlePath(bundlePath) end

--- @param name string
--- @return boolean
function HSApplication.launchOrFocus(name) end

--- @param bundleID string
--- @return boolean
function HSApplication.launchOrFocusByBundleID(bundleID) end

--- @param bundleID string
--- @return string|nil
function HSApplication.nameForBundleID(bundleID) end

--- @param bundleID string
--- @return string|nil
function HSApplication.pathForBundleID(bundleID) end

--- @return Application[]
function HSApplication.runningApplications() end

--- @param hint number|string
--- @return Application[]|nil
function HSApplication.find(hint) end

--- @param hint number|string
--- @return Application|nil
function HSApplication.get(hint) end

--- @param app string
--- @param wait number|nil
--- @param waitForFirstWindow boolean|nil
--- @return Application|nil
function HSApplication.open(app, wait, waitForFirstWindow) end
