--- @class Timer
local Timer

--- immediately fires a timer
---
--- Notes:
--- * This cannot be used on a timer which has already stopped running
---
--- @return Timer @a timer object
function Timer:fire() end

--- returns the number of seconds until the timer will next trigger
---
--- Notes:
--- * The return value may be a negative integer in two circumstances:
---   * Hammerspoon's runloop is backlogged and is catching up on missed timer
--- triggers
---   * The timer object is not currently running. In this case, the return
--- value of this method is the number of seconds since the last firing (you can
--- check if the timer is running or not, with `hs.timer:running()`)
---
--- @return number @seconds until the next firing
function Timer:nextTrigger() end

--- returns a boolean indicating whether or not the timer is currently running
---
--- @return boolean @`true` if the timer is currently running, `false` otherwise
function Timer:running() end

--- sets the next trigger time of a timer
---
--- Notes:
--- * If the timer is not already running, this will start it
---
--- @param seconds number @seconds after which to trigger the timer
--- @return Timer|nil @a timer object or `nil` if an error occurred
function Timer:setNextTrigger(seconds) end

--- starts this timer
---
--- Notes:
--- * The timer will not call the callback immediately, the timer will wait
--- until it fires
--- * If the callback function results in an error, the timer will be stopped to
--- prevent repeated error notifications (see the `continueOnError` parameter to
--- `hs.timer.new()` to override this)
---
--- @return Timer @a timer object
function Timer:start() end

--- Stops this timer
---
--- @return Timer @a timer object
function Timer:stop() end
