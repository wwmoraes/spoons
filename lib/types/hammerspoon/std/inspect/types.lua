-- process a variable and either returns the original value, a transformed one,
-- or `nil` to remove the item from the inspected output
---@generic T
---@alias InspectProcessFn fun(item: T, path: string): T?
