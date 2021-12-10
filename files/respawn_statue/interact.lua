
function interacting(entity_who_interacted, entity_interacted, interactable_name)
  local entity_id = GetUpdatedEntityID()
  local x, y = EntityGetTransform(entity_id)
  
  GamePlaySound("data/audio/Desktop/event_cues.bank", "event_cues/orb/create", x, y)
  EntityLoad("mods/AdventureMode/files/respawn_statue/respawn_point_set_effect.xml", x, y - 60)
  GamePrint("Progress saved, respawn point set")
  GlobalsSetValue("AdventureMode_respawn_x", x)
  GlobalsSetValue("AdventureMode_respawn_y", y)
  for i, comp in ipairs(EntityGetComponentIncludingDisabled(entity_id, "ParticleEmitterComponent")) do
    EntitySetComponentIsEnabled(entity_id, comp, true)
  end
  local damage_model_comp = EntityGetFirstComponentIncludingDisabled(entity_who_interacted, "DamageModelComponent")
  local max_hp = ComponentGetValue2(damage_model_comp, "max_hp")
  ComponentSetValue2(damage_model_comp, "hp", max_hp)
end
