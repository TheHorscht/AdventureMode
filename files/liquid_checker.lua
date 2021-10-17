function get_distance( x1, y1, x2, y2 )
	local result = math.sqrt( ( x2 - x1 ) ^ 2 + ( y2 - y1 ) ^ 2 )
	return result
end

function material_area_checker_success(x, y)
  local door = EntityGetWithName("door2")
  local lua_component = EntityGetFirstComponentIncludingDisabled(door, "LuaComponent")
  EntitySetComponentIsEnabled(door, lua_component, true)
end

local entity_id = GetUpdatedEntityID()
local x, y = EntityGetTransform(entity_id)
local potion = EntityGetInRadiusWithTag(x, y, 500, "potion")
local players = EntityGetWithTag("player_unit")
local distance_to_player = 9999999
if #players > 0 then
  local px, py = EntityGetTransform(players[1])
  distance_to_player = get_distance(x, y, px, py)
end
if #potion == 0 and distance_to_player < 100 then
  local door = EntityGetWithName("door2")
  local lua_component = EntityGetFirstComponentIncludingDisabled(door, "LuaComponent")
  EntitySetComponentIsEnabled(door, lua_component, true)
  EntityKill(entity_id)
end
