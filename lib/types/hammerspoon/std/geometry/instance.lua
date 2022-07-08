--- @class Geometry : Rectangle
--- @field area number
--- @field aspect number
--- @field bottomright Point|nil
--- @field center Point
--- @field length number
--- @field string string
--- @field table Rectangle
--- @field topleft Point|nil
--- @field wh Size|nil
--- @field x1 number|nil
--- @field x2 number|nil
--- @field x2y2 Point|nil
--- @field xy Point|nil
--- @field y1 number|nil
--- @field y2 number|nil
local Geometry

--- @return number
function Geometry:angle() end

--- @param point Geometry
--- @return number
function Geometry:angleTo(point) end

--- @param point Geometry
--- @return number
function Geometry:distance(point) end

--- @param other Geometry
--- @return boolean
function Geometry:equals(other) end

--- @param bounds Rectangle | string
--- @return Geometry
function Geometry:fit(bounds) end

--- @return Geometry
function Geometry:floor() end

--- @param frame Rectangle | string
--- @return Geometry
function Geometry:fromUnitRect(frame) end

--- @param rect Rectangle | string
--- @return boolean
function Geometry:inside(rect) end

function Geometry:intersect() end

function Geometry:move() end

function Geometry:normalize() end

function Geometry:rotateCCW() end

function Geometry:scale() end

function Geometry:toUnitRect() end

function Geometry:type() end

function Geometry:union() end

--- @param point Geometry
--- @return Geometry
function Geometry:vector(point) end
