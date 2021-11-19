dofile_once("mods/AdventureMode/files/util.lua")

local entity_id = GetUpdatedEntityID()
local x, y = EntityGetTransform(entity_id)

local check_global_variable = get_var_store_string(entity_id, "check_global_variable")
local spawn_entity = get_var_store_string(entity_id, "spawn_entity")

if not check_global_variable then
  error("'check_global_variable' not set!")
end

if not spawn_entity then
  error("'spawn_entity' not set!")
end

if GlobalsGetValue(check_global_variable, "0") == "1" then
  EntityLoad(spawn_entity, x, y)
  EntityKill(entity_id)
end
