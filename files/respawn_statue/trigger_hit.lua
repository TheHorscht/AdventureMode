function collision_trigger(colliding_entity_id)
  local entity_id = GetUpdatedEntityID()
  local x, y = EntityGetTransform(entity_id)
  
  local respawn_x = tonumber(GlobalsGetValue("AdventureMode_respawn_x", "0"))
  local respawn_y = tonumber(GlobalsGetValue("AdventureMode_respawn_y", "0"))

  if respawn_x ~= x and respawn_y ~= y then
    GamePlaySound("data/audio/Desktop/event_cues.bank", "event_cues/orb/create", x, y)
    GlobalsSetValue("AdventureMode_respawn_x", x)
    GlobalsSetValue("AdventureMode_respawn_y", y)
    local parent = EntityGetParent(entity_id)
    for i, comp in ipairs(EntityGetComponentIncludingDisabled(parent, "ParticleEmitterComponent")) do
      EntitySetComponentIsEnabled(parent, comp, true)
    end
  end
end
