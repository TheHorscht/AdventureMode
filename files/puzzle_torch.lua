dofile_once("mods/AdventureMode/files/util.lua")

local entity_id = GetUpdatedEntityID()
local x, y = EntityGetTransform(entity_id)
local order = get_var_store_int(entity_id, "order")

for i, comp in ipairs(EntityGetComponentIncludingDisabled(entity_id, "ParticleEmitterComponent") or {}) do
  if GlobalsGetValue("AdventureMode_puzzle_torch_active_" .. order, "0") == "1" then
    ComponentSetValue2(comp, "is_emitting", true)
  else
    ComponentSetValue2(comp, "is_emitting", false)
  end
end
