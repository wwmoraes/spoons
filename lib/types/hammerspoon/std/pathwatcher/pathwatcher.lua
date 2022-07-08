--- Creates recursive path watchers that triggers on changes
--- @class HSPathwatcher
local HSPathwatcher

--- Creates a new path watcher object
---
--- @param path string @path to be watched
--- @param fn PathwatcherFn @function to be called when changes are detected
--- @return Pathwatcher @an `PathwatcherInstance` object
function HSPathwatcher.new(path, fn) end
