--- === Hazel ===
---
--- watches path changes to execute actions on them
---

--- callback to process a pair of path and flags from a pathwatcher event.
--- Should return `true` if the event was consumed and stop rule parsing for it
--- @alias RuleFn fun(path:string, flags:PathwatcherFlags): boolean

---@class HazelConfig
--- set of paths and its rules
--- @field public ruleSets table<string,RuleFn[]>

--- Hazel Spoon object
--- @class Hazel : HazelConfig, Spoon
--- global logger instance
--- @field protected logger Logger
--- system events watcher
--- @field protected watchers CaffeinateWatcher[]
local obj = {
  watchers = {}
}
obj.__index = obj

-- Metadata
obj.name = "Hazel"
obj.version = "1.0"
obj.author = "William Artero"
obj.license = "MIT - https://opensource.org/licenses/MIT"

--- @param paths string[]
--- @param flagTables table<string,PathwatcherFlags>
--- @return Hazel @the Hazel object
function obj:execute(paths, flagTables)
  self.logger.i("executing rules for " .. hs.json.encode(paths, false))
  for index, path in pairs(paths) do
    local rules = self.ruleSets[path]
    if rules ~= nil then
      for _, rule in ipairs(rules) do
        if rule(path, flagTables[index]) == false then return self end
      end
    end
  end

  return self
end

--- @return Hazel
function obj:init()
  self.logger = hs.logger.new(string.lower(self.name))

  return self
end

--- @return Hazel
function obj:start()
  for path, rules in pairs(self.ruleSets) do
    if #rules > 0 then
      table.insert(self.watchers, hs.pathwatcher.new(
        path,
        hs.fnutils.partial(obj.execute, obj)
      ):start())
      self.logger.i("watcher set for " .. path)
    end
  end

  return self
end

--- @return Hazel
function obj:stop()
  while #self.watchers > 0 do
    table.remove(self.watchers, #self.watchers):stop()
  end

  return self
end

return obj
