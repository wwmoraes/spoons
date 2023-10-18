--- @class Logger
--- @field public level LogLevelNumber @log level of this instance
local Logger

--- logs debug info to the console
--- @vararg any
function Logger.d(...) end

--- logs formatted debug info to the console
--- @param fmt string @formatting string as per string.format
--- @vararg any
function Logger.df(fmt, ...) end

--- logs error to the console
--- @vararg any
function Logger.e(...) end

--- logs formatted error to the console
--- @param fmt string @formatting string as per string.format
--- @vararg any
function Logger.ef(fmt, ...) end

--- logs formatted info to the console
--- @param fmt string @formatting string as per string.format
--- @vararg any
function Logger.f(fmt, ...) end

--- logs info to the console
--- @vararg any
function Logger.i(...) end

--- gets the log level of the logger instance
--- @return LogLevelNumber @The log level of this logger as a number
function Logger.getLoggerLevel() end

--- sets the log level of the logger instance
--- @param loglevel LogLevel @can be 'nothing', 'error', 'warning', 'info', 'debug', or 'verbose'; or a corresponding number between 0 and 5
function Logger.setLoggerLevel(loglevel) end

--- logs verbose info to the console
--- @vararg any
function Logger.v(...) end

--- logs formatted verbose info to the console
--- @param fmt string @formatting string as per string.format
--- @vararg any
function Logger.vf(fmt, ...) end

--- logs warning to the console
--- @vararg any
function Logger.w(...) end

--- logs formatted warning to the console
--- @param fmt string @formatting string as per string.format
--- @vararg any
function Logger.wf(fmt, ...) end
