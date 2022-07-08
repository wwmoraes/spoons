--- @class HSGeometry
local HSGeometry

--- @param geom Geometry
--- @return Geometry
function HSGeometry.copy(geom) end

--- @vararg any
--- @return Geometry
function HSGeometry.new(...) end

--- @param x integer
--- @param y integer
--- @return Geometry
function HSGeometry.point(x, y) end

--- @param x integer
--- @param y integer
--- @param w integer
--- @param h integer
--- @return Geometry
function HSGeometry.rect(x, y, w, h) end

--- @param w integer
--- @param h integer
--- @return Geometry
function HSGeometry.size(w, h) end
