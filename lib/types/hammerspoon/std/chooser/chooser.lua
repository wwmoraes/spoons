---@class HSChooser
---@field globalCallback fun(chooser: Chooser, eventName: "'willOpen'"|"'didClose'")
local HSChooser

---@param completionFn function
---@return Chooser
function HSChooser.new(completionFn) end
