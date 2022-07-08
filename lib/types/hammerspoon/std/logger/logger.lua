--- @class HSLogger
--- @field defaultLogLevel LogLevel
local HSLogger

--- returns the global log history
--- @return LoggerLogEntry[]
function HSLogger.history() end

--- sets or gets the global log history size
--- @param size number|nil @desired number of log entries to keep in the history; if omitted, will return the current size; the starting value is 0 (disabled)
--- @return number @current or new history size
function HSLogger.historySize(size) end

--- creates a new logger instance
--- @param id string @identifier for the instance
--- @param loglevel LogLevel @can be 'nothing', 'error', 'warning', 'info', 'debug', or 'verbose', or a corresponding number between 0 and 5; uses hs.logger.defaultLogLevel if omitted
--- @return Logger @new logger instance
---@overload fun(id:string)
function HSLogger.new(id, loglevel) end

--- prints the global log history to the console
--- @param entries number|nil @maximum number of entries to print; if omitted, all entries in the history will be printed
--- @param level LogLevel|nil @desired log level (see hs.logger:setLogLevel()); if omitted, defaults to verbose
--- @param filter string|nil @string to filter the entries (by logger id or message) via string.find plain matching
--- @param caseSensitive boolean|nil @if `true`, filtering is case sensitive
function HSLogger.printHistory(entries, level, filter, caseSensitive) end

--- sets the log level for all logger instances (including objects' loggers)
--- @param lvl LogLevel @can be 'nothing', 'error', 'warning', 'info', 'debug', or 'verbose', or a corresponding number between 0 and 5
function HSLogger.setGlobalLogLevel(lvl) end

--- sets the log level for all currently loaded modules
--- @param lvl LogLevel @can be 'nothing', 'error', 'warning', 'info', 'debug', or 'verbose', or a corresponding number between 0 and 5
function HSLogger.setModulesLogLevel(lvl) end
