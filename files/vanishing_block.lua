dofile_once("mods/AdventureMode/files/util.lua")

local entity_id = GetUpdatedEntityID()
local x, y = EntityGetTransform(entity_id)
local physics_body_comp = EntityGetFirstComponentIncludingDisabled(entity_id, "PhysicsBodyComponent")
local cycle = get_var_store_int(entity_id, "cycle", 120)
local timing = get_var_store_int(entity_id, "timing", 0)

if GameGetFrameNum() % cycle == timing then
  EntitySetComponentIsEnabled(entity_id, physics_body_comp, not ComponentGetIsEnabled(physics_body_comp))
end
