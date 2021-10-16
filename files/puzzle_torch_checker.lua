dofile_once("data/scripts/lib/utilities.lua")

local entity_id = GetUpdatedEntityID()
local x, y = EntityGetTransform(entity_id)
local torches = EntityGetInRadiusWithTag(x, y, 200, "puzzle_torch")
local active_count = 0
for i, torch in ipairs(torches) do
  local var_store = get_variable_storage_component(torch, "active")
  local active = false
  if var_store and ComponentGetValue2(var_store, "value_bool") then
    active_count = active_count + 1
  end
end
if active_count == 5 then
  local door = EntityGetWithName("door3")
  local lua_component = EntityGetFirstComponentIncludingDisabled(door, "LuaComponent")
  EntitySetComponentIsEnabled(door, lua_component, true)
  EntityKill(entity_id)
end
