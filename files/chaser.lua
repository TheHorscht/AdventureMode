dofile_once("data/scripts/lib/utilities.lua")

local function clamp(value, min, max)
	value = math.max(value, min)
	value = math.min(value, max)
	return value
end

local function smoothstep(edge0, edge1, t)
  t = clamp((t - edge0) / (edge1 - edge0), 0, 1)
  return t * t * (3 - 2 * t)
end

local function smootherstep(edge0, edge1, t)
  t = clamp((t - edge0) / (edge1 - edge0), 0.0, 1.0)
  return t * t * t * (t * (t * 6 - 15) + 10)
end

local function smooth_lerp(a, b, t)
  t = smoothstep(0, 1, t)
	return a * t + b * (1 - t)
end

local function smooth_vec_lerp(x1, y1, x2, y2, weight)
	local x = smooth_lerp(x1, x2, weight)
	local y = smooth_lerp(y1, y2, weight)
	return x,y
end


function get_direction( x1, y1, x2, y2 )
	local result = math.atan2( ( y2 - y1 ), ( x2 - x1 ) )
	return result
end

local entity_id = GetUpdatedEntityID()
local x, y = EntityGetTransform(entity_id)

local player = EntityGetWithTag("player_unit")[1]
if player then
  local px, py = EntityGetTransform(player)
  local dir = get_direction(x, y, px, py)
  local distance = get_distance(x, y, px, py)
  local distance_min = 10
  local distance_max = 80
  local chase_power = 100
  distance = clamp(distance, distance_min, distance_max)
  -- Normalize
  distance = (distance - distance_min) / distance_max
  local f = smootherstep(0, 1, distance) * 2
  local fx, fy = math.cos(dir) * f, math.sin(dir) * f
  -- local fx, fy = math.cos(dir) * distance * chase_power, math.sin(dir) * distance * chase_power
  EntitySetTransform(entity_id, x + fx, y + fy)
  -- local new_speed = math.sqrt((vx + fx) ^ 2 + (vy + fy) ^ 2)
  -- if new_speed < 50 then
  --   PhysicsApplyForce(entity_id, fx, fy)
  --   draw_arrow(x, y, px, py)
  --   -- draw_arrow(x, y, x + fx, y + fy)
  --   player_position_in_sight = true
  --   break
  -- end
end
