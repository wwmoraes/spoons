--- === Contexts ===
---
--- close/open/hide groups of applications based on contexts
---
--- there's a built-in switcher that can be used with ^ + ⌥ + ⌘ + C, unless
--- overridden
---
--- there's also timers that run on 9am and 5pm to ask to open and close,
--- respectively, the work context
---

--- weekday, 1-7, Sunday is 1
---@alias Weekday '1'|'2'|'3'|'4'|'5'|'6'|'7'

---@alias Action '"open"'|'"kill"'

---@class ContextEntry
--- context title used on notifications and on the chooser
---@field title string
--- optional time string on when to emit the notification to open the context
---@field openAt string|nil
--- optional time string on when to emit the notification to close the context
---@field closeAt string|nil
--- rules to enable/disable the timers per hostname (default true for all hosts)
---@field hostnames table<string,boolean>|nil
--- days to skip the scheduled open/close
---@field exceptDays table<Weekday,boolean>|nil
--- list of plain application bundle IDs or tables with bundle IDs and arguments
---@field applications (string|table<string>)[]

--- extra functionality when opening/closing applications
---@class EventOptions
--- arguments to launch the application with
---@field arguments string[]?

--- relation of application actions and application names/bundles to act upon
---@class EventActions
--- opens the application if it is not open yet
---@field open table<string,EventOptions>?
--- kills the application if it is open
---@field kill table<string,EventOptions>?

---@class ContextsConfig
--- context details to use throughout the module
---@field public contexts ContextEntry[]
--- actions to be executed when the host wakes up
---@field public onWake EventActions
--- actions to be executed when the host is about to sleep
---@field public onSleep EventActions

--- Contexts Spoon object
---@class Contexts : ContextsConfig, Spoon
--- list of timers created to notify about opening and closing contexts at
--- certain times
---@field protected timers Timer[]
--- list of choices available on the chooser
---@field protected choices table
--- chooser placeholder text shown on the input box
---@field public chooserPlaceholderText string
--- map of system events to functions to execute
---@field public eventCallback table<number,function>
--- system events watcher
---@field protected watcher CaffeinateWatcher
--- actions to be executed when the system wakes
-- -@field public onWake EventActions
--- actions to be executed when the system sleeps/shuts down
-- -@field public onSleep EventActions
--- application action handlers that work with the app name only
---@field protected applicationActionHandlers table<string,function>
local obj = {
  timers = {},
  choices = {},
  chooserPlaceholderText = "Which context you want to %s?",
  ---@type ContextEntry[]
  contexts = {},
  ---@type EventActions
  onWake = {},
  ---@type EventActions
  onSleep = {},
  ---@type table<string,function>
  watchers = {}
}
obj.__index = obj

-- Metadata
obj.name = "Contexts"
obj.version = "1.0"
obj.author = "William Artero"
obj.license = "MIT - https://opensource.org/licenses/MIT"

obj.eventName = {
  [0] = "systemDidWake",
  [1] = "systemWillSleep",
  [2] = "systemWillPowerOff",
  [3] = "screensDidSleep",
  [4] = "screensDidWake",
  [5] = "sessionDidResignActive",
  [6] = "sessionDidBecomeActive",
  [7] = "screensaverDidStart",
  [8] = "screensaverWillStop",
  [9] = "screensaverDidStop",
  [10] = "screensDidLock",
  [11] = "screensDidUnlock"
}

---@type HotkeyMapping
obj.defaultHotkeys = {
  killChooser = { { "ctrl", "option", "cmd" }, "k" },
  hideChooser = { { "ctrl", "option", "cmd" }, "h" },
  openChooser = { { "ctrl", "option", "cmd" }, "o" }
}

---@alias ActionHandler fun(name: string, options:EventOptions?): Application?

---@param info table<string>
---@return Application|nil
local function openWith(info)
  if type(info) ~= "table" then
    error("openWith only works with tables of strings")
  end

  local open = hs.task.new(
    "/usr/bin/open",
    nil,
    function() return false end,
    table.move(info, 2, #info, 4, { "-b", info[1], "--args" })
  ):start()
  if open == false then
    return nil
  end

  open:waitUntilExit()

  return hs.application.get(info[1])
end

---@type table<Action,ActionHandler>
obj.applicationActionHandlers = {
  ["open"] = function(name, options)
    -- first, we check if the application is open already. If so, nothing to do
    ---@type Application|nil
    local app = hs.application.get(name)
    if app ~= nil then
      return
    end

    -- open application with arguments
    if options.arguments ~= nil and #options.arguments > 0 then
      openWith(table.pack(name, table.unpack(options.arguments)))
    else
      hs.application.open(name)
    end
  end,
  ---@param name string
  ["kill"] = function(name)
    local app = hs.application.get(name)
    if app == nil then
      return
    end

    app:kill()
  end,
}

--- wraps `fn` with a closure, which calls `fn` within a protected call using `pcall`, and logs the error using the `logger.e`
---@param logger Logger
---@param fn function
---@vararg any
---@return function
local function protectedPartial(logger, fn, ...)
  local partialFn = hs.fnutils.partial(fn, ...)
  return function()
    local status, err = pcall(partialFn)
    if not status then
      logger.e(err)
    end
  end
end

--- callback that fires the context switch action if not on `exceptDays`
---@param context ContextEntry
---@param contextName string
---@param baseURL string
---@param action string
local function doAtCallback(context, contextName, baseURL, action)
  if context.exceptDays ~= nil and context.exceptDays[os.date("*t").wday] then
    return
  end

  hs.urlevent.openURL(string.format("%s?name=%s&action=%s", baseURL, contextName, action))
end

--- processes caffeinate watcher events
---@param eventType number
function obj:processEvent(eventType)
  local eventName = self.eventName[eventType]
  local fn = self.eventCallback[eventType]
  if fn == nil then
    self.logger.i("no handler registered for event", eventName)
    return
  end

  self.logger.f("executing %s handler", eventName)
  fn(self)
end

--- actions available on application instances
---@alias AppAction "'kill'" | "'open'" | "'hide'" | nil

--- gracefully kill all applications within context
---@param context string
---@return Contexts @the Contexts object
function obj:killContext(context)
  self:doContext("kill", context)
  return self
end

--- execute the action on all applications within context
---@param action AppAction
---@param contextName string
---@return Contexts @the Contexts object
function obj:doContext(action, contextName)
  assert(action, "no action provided")
  assert(type(action) == "string", "action must be a string")
  assert(contextName, "no context provided")
  assert(type(contextName) == "string", "context must be a string")
  local context = assert(self.contexts[contextName], string.format("context %s does not exist", contextName))
  local appNames = assert(context.applications, string.format("context %s has no applications set", contextName))

  for _, appName in ipairs(appNames) do
    self.applicationActionHandlers[action](appName)
  end

  hs.alert.show(string.format("%s executed for %s applications", action, contextName))
  return self
end

--- shows a chooser to pick a context and execute the action
---@param action AppAction
---@return Contexts @the Contexts object
function obj:contextChooser(action)
  local action = action or "kill"

  local completionFn = function(choice)
    -- noop if the chooser is dismissed
    if choice == nil then
      obj.logger.i("no choice made")
      return
    end

    assert(choice.context, "choice has no context set")

    self:doContext(action, choice.context)
  end

  local chooser = hs.chooser.new(completionFn)
  chooser:placeholderText(string.format(self.chooserPlaceholderText, action))
  chooser:choices(self.choices)
  chooser:show()
  return self
end

--- callback to process URL events from hs.urlevent
---@param eventName string
---@param params table
---@return Contexts @the Contexts object
function obj:handleURLEvent(eventName, params)
  -- check if the event is contexts
  assert(eventName == string.lower(self.name), string.format("unknown event %s", eventName))
  -- get the context name
  local contextName = assert(params.name, "no context provided")
  -- get the action name
  local action = assert(params.action, "no action provided")
  -- get the interactive flag, or default to true
  local interactive = true
  if params.interactive ~= nil and params.interactive == "false" then
    interactive = false
  end

  if interactive then
    -- create the notification
    local information = string.format("%s all %s-related applications?", action, contextName)
    hs.notify.new(
      function()
        self:doContext(action, contextName)
      end,
      {
        title = self.name,
        subTitle = contextName,
        informativeText = information,
        withdrawAfter = 0,
        hasActionButton = true,
        actionButtonTitle = "Yes",
        otherButtonTitle = "Not yet"
      }
    ):send()
  else
    self:doContext(action, contextName)
  end

  return self
end

---@param mapping HotkeyMapping table of strings that describe bindable actions of the spoon, with hotkey spec values
---@return Contexts @the Contexts object
function obj:bindHotkeys(mapping)
  local def = {
    killChooser = protectedPartial(self.logger, self.contextChooser, self, "kill"),
    hideChooser = protectedPartial(self.logger, self.contextChooser, self, "hide"),
    openChooser = protectedPartial(self.logger, self.contextChooser, self, "open")
  }
  hs.spoons.bindHotkeysToSpec(def, mapping)
  return self
end

--- create choice entries based on current contexts, using the title field value
--- as chooser text, if present, or the context name itself otherwise
---@return Contexts @the Contexts object
function obj:generateChoices()
  self.choices = {}
  for contextName, _ in pairs(self.contexts) do
    local text = self.contexts[contextName].title or contextName
    table.insert(
      self.choices,
      {
        text = text,
        context = contextName
      }
    )
  end

  return self
end

--- setup context timers and run on-wake triggers
---@return Contexts @the Contexts object
function obj:wake()
  --- execute on wake rules
  ---@param action string
  ---@param apps table<string, EventOptions>
  for action, apps in pairs(self.onWake) do
    for appName, appOptions in pairs(apps) do
      self.logger.i(string.format("[wake] %s application %s", action, appName))
      self.applicationActionHandlers[action](appName, appOptions)
    end
  end
  self.logger.i("on wake application actions executed successfully")

  local baseURL = "hammerspoon://" .. string.lower(self.name)
  local host = hs.network.configuration.open():hostname()

  ---@param contextName string
  ---@param context ContextEntry
  for contextName, context in pairs(self.contexts) do
    -- do not enable the timers on hosts explicitly listed as false
    if context.hostnames == nil or context.hostnames[host] ~= false then
      if context.openAt ~= nil then
        table.insert(
          self.timers,
          hs.timer.doAt(
            context.openAt,
            "1d",
            hs.fnutils.partial(doAtCallback, context, contextName, baseURL, "open"),
            true
          )
        )
      end

      if context.closeAt ~= nil then
        table.insert(
          self.timers,
          hs.timer.doAt(
            context.closeAt,
            "1d",
            hs.fnutils.partial(doAtCallback, context, contextName, baseURL, "kill"),
            true
          )
        )
      end
    end
  end
  self.logger.i("timers set up successfully")
  return self
end

--- stop context timers and run on-sleep triggers
---@return Contexts @the Contexts object
function obj:sleep()
  --- execute on sleep rules
  for action, appNames in pairs(self.onSleep) do
    for _, appName in ipairs(appNames) do
      self.logger.i(string.format("[wake] %s application %s", action, appName))
      self.applicationActionHandlers[action](appName)
    end
  end
  self.logger.i("on sleep application actions executed successfully")

  while #self.timers > 0 do
    table.remove(self.timers, #self.timers):stop()
  end

  self.logger.i("timers cleaned up successfully")
  return self
end

---@return Contexts @the Contexts object
function obj:init()
  self.logger = hs.logger.new(string.lower(self.name))
  self.watcher = hs.caffeinate.watcher.new(hs.fnutils.partial(self.processEvent, self))
  self.eventCallback = {
    [hs.caffeinate.watcher.systemDidWake] = hs.fnutils.partial(self.wake, self),
    [hs.caffeinate.watcher.systemWillSleep] = hs.fnutils.partial(self.sleep, self),
  }

  return self
end

---@return Contexts @the Contexts object
function obj:start()
  -- bind URL event
  local eventName = string.lower(self.name)
  hs.urlevent.bind(
    eventName,
    function(...)
      local status, err = pcall(self.handleURLEvent, self, ...)
      if not status then
        self.logger.e(err)
      end
    end
  )

  -- generate the chooser panel options
  self:generateChoices()

  -- setup context timers
  self:wake()

  -- starts the system events watcher
  self.watcher:start()

  return self
end

---@return Contexts @the Contexts object
function obj:stop()
  -- unbind URL event
  hs.urlevent.bind(string.lower(self.name), nil)

  -- cleanup context timers
  self:sleep()

  -- stops the system events watcher
  self.watcher:stop()

  return self
end

return obj
