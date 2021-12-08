function collision_trigger(colliding_entity_id)
  local skeleton = EntityGetWithName("Ancient Resurrection")
  if skeleton > 0 then
    EntityInflictDamage(skeleton, 666 / 25, "DAMAGE_HEALING", "", "NORMAL", 0, 0)
  end
  GlobalsSetValue("AdventureMode_portal_unlocked_01", "1")
  GlobalsSetValue("AdventureMode_temple_skeleton_beaten", "1")
end