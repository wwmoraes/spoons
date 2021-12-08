--- function called by an `hs.task` object when it terminates
--- @param exitCode number @exit code of the process
--- @param stdOut string @standard output of the process
--- @param stdErr string @error output of the process
--- @alias TaskCallback "function(exitCode:number, stdOut:string, stdErr:string)"

--- function called by an `hs.task` object whenever the task outputs data to
--- stdout or stderr
--- @param task TaskInstance|nil @`hs.task` object or `nil` if this is the final output
--- @param stdOut string @standard output since the last call to this callback
--- @param stdErr string @error output since the last call to this callback
--- @return boolean @`true` to continue calling this callback, `false` to stop
--- @alias TaskStreamCallback "function(task:TaskInstance|nil, stdOut:string, stdErr:string):boolean"