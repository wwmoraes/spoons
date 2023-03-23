--- An `hs.task` object
--- @class Task
local Task

--- Closes the task's stdin
---
--- Notes:
---
--- * This should only be called on tasks with a streaming callback - tasks
--- without it will automatically close stdin when any data supplied via
--- `hs.task:setInput()` has been written
--- * This is primarily useful for sending EOF to long-running tasks
---
--- @return Task @the `hs.task` object
function Task:closeInput() end

--- Returns the environment variables as a table for the task.
---
--- Notes:
---
--- * if you have not yet set an environment table with the
--- `hs.task:setEnvironment` method, this method will return a copy of the
--- Hammerspoon environment table, as this is what the task will inherit by
--- default.
---
--- @return table<string,string> @table where each key is the environment variable name
function Task:environment() end

--- @return Task @the `hs.task` object
function Task:interrupt() end

--- @return boolean @`true` if the task is running, `false` otherwise
function Task:isRunning() end

--- @return boolean
function Task:pause() end

--- @return number
function Task:pid() end

--- @return boolean
function Task:resume() end

--- @param fn TaskCallback|nil
--- @return Task
function Task:setCallback(fn) end

--- @param environment table<string,string>
--- @return Task|'false'
function Task:setEnvironment(environment) end

--- @param inputData string
--- @return Task
function Task:setInput(inputData) end

--- @param fn TaskStreamCallback|nil
--- @return Task
function Task:setStreamingCallback(fn) end

--- @param path string
--- @return Task|false
function Task:setWorkingDirectory(path) end

--- @return Task|false
function Task:start() end

--- @return Task
function Task:terminate() end

--- @return '"exit"'|'"interrupt"'|'false'
function Task:terminationReason() end

--- @return number|'false'
function Task:terminationStatus() end

--- @return Task
function Task:waitUntilExit() end

--- @return string
function Task:workingDirectory() end
