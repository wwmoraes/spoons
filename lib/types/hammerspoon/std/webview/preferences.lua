---@class WebViewPreferences
-- enables JavaScript (default `true`)
---@field javaScriptEnabled boolean
-- enables JavaScript to open windows without user intervention (default `true`)
---@field javaScriptCanOpenWindowsAutomatically boolean
-- minimum font size (default 0.0)
---@field minimumFontSize number
-- include "Inspect Element" in the context menu (default `false`)
---@field developerExtrasEnabled boolean
-- suppresses content rendering until fully loaded into memory (default `false`)
---@field suppressesIncrementalRendering boolean
-- application name to be listed at the end of the browser's User-Agent header.
-- This is only appended to the default user agent string; if you set a custom
-- one with `hs.webview:userAgent`, this value is ignored.
---@field applicationName? string
-- enables media playback within the webview to play through AirPlay devices
-- (default `false`)
---@field allowsAirPlay boolean
-- where website data (cookies, cache, etc) storage
---@field datastore? WebViewDatastore
-- defines that the datastore should be set to a new, empty and non-persistent
-- one. Note that this will override the datastore key if both are specified and
-- this is set to true. (default `false`)
---@field privateBrowsing boolean
local WebViewPreferences = {
  javaScriptEnabled = true,
  javaScriptCanOpenWindowsAutomatically = true,
  minimumFontSize = 0.0,
  developerExtrasEnabled = false,
  suppressesIncrementalRendering = false,
  allowsAirPlay = false,
  datastore = nil,
  applicationName = nil,
  privateBrowsing = false,
}
