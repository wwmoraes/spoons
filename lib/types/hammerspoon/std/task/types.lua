--- function called by an `hs.task` object when it terminates
--- @alias TaskCallback fun(exitCode:number, stdOut:string, stdErr:string)

--- function called by an `hs.task` object whenever the task outputs data to
--- stdout or stderr
--- @alias TaskStreamCallback fun(task:Task|nil, stdOut:string, stdErr:string):boolean
