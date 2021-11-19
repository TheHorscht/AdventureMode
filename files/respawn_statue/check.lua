local entity_id = GetUpdatedEntityID()
local x, y = EntityGetTransform(entity_id)
local respawn_x = tonumber(GlobalsGetValue("AdventureMode_respawn_x", "0"))
local respawn_y = tonumber(GlobalsGetValue("AdventureMode_respawn_y", "0"))

if respawn_x == x and respawn_y == y then
  for i, comp in ipairs(EntityGetComponentIncludingDisabled(entity_id, "ParticleEmitterComponent")) do
    EntitySetComponentIsEnabled(entity_id, comp, true)
  end
else
  for i, comp in ipairs(EntityGetComponentIncludingDisabled(entity_id, "ParticleEmitterComponent")) do
    EntitySetComponentIsEnabled(entity_id, comp, false)
  end
end
