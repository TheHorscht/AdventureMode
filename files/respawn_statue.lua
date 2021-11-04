function collision_trigger(colliding_entity_id)
  local entity_id = GetUpdatedEntityID()
  local x, y = EntityGetTransform(entity_id)
  
  local respawn_x = tonumber(GlobalsGetValue("AdventureMode_respawn_x", "0"))
  local respawn_y = tonumber(GlobalsGetValue("AdventureMode_respawn_y", "0"))

  if respawn_x ~= x and respawn_y ~= y then
    GlobalsSetValue("AdventureMode_respawn_x", x)
    GlobalsSetValue("AdventureMode_respawn_y", y)
    EntityLoad("mods/AdventureMode/files/respawn_point_set_effect.xml", x, y - 10)
  end
end
