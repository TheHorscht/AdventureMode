function collision_trigger(colliding_entity_id)
  GlobalsSetValue("AdventureMode_alligator_beaten", "1")
  
  local entity_id = GetUpdatedEntityID()
  local x, y = EntityGetTransform( entity_id )
  
  GlobalsSetValue("AdventureMode_respawn_x", x)
  GlobalsSetValue("AdventureMode_respawn_y", y)
  
  EntityLoad("data/entities/misc/loose_chunks_workshop.xml", x - 369, y + 127)

  EntityLoad("mods/AdventureMode/files/cutscene.xml", x, y)
end
