function collision_trigger(colliding_entity_id)
  local skeleton = EntityGetWithName("Ancient Resurrection")
  EntityInflictDamage(skeleton, 666 / 25, "DAMAGE_HEALING", "", "NORMAL", 0, 0)
  local entity_id = GetUpdatedEntityID()
  local x, y = EntityGetTransform(entity_id)
  EntityLoad("mods/AdventureMode/files/temple_skeleton_teleport_back.xml", x + 70, y)
  GlobalsSetValue("AdventureMode_temple_skeleton_beaten", "1")
end
