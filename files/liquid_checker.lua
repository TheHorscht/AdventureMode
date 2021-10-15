function material_area_checker_success(x, y)
  local door = EntityGetWithName("door2")
  local lua_component = EntityGetFirstComponentIncludingDisabled(door, "LuaComponent")
  EntitySetComponentIsEnabled(door, lua_component, true)
end

local entity_id = GetUpdatedEntityID()
local x, y = EntityGetTransform(entity_id)
local potion = EntityGetInRadiusWithTag(x, y, 500, "potion")
local players = EntityGetWithTag("player_unit")
if #potion == 0 and #players > 0 then
  local door = EntityGetWithName("door2")
  local lua_component = EntityGetFirstComponentIncludingDisabled(door, "LuaComponent")
  EntitySetComponentIsEnabled(door, lua_component, true)
  EntityKill(entity_id)
end
