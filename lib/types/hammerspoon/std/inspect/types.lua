--- function that will be called for each item of an inspection
--- @param item any @current item being processed
--- @param path string @item's position in the variable being inspected
--- @return any @either a processed form of the variable, the original variable itself if it requires no processing, or nil to remove the item from the inspected output
--- @alias InspectProcessFn "function(item:any, path:string):any"
