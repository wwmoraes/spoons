--- pathwatcher callback function to process the changes
---@param paths string[] @list of file paths that have changed
---@param flagTables table<string,PathwatcherFlags> @list of tables denoting how each corresponding file in paths has changed
---@alias PathwatcherFn "function(paths:string[], flagTables:table<string,Flags>)"
