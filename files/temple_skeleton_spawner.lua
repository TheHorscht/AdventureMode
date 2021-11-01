function collision_trigger(colliding_entity_id)
  local skeleton = EntityGetWithName("Ancient Resurrection")
  if skeleton == 0 then
    print("SPAWNINGNNNNN SKELETONG")
    local x = tonumber(GlobalsGetValue("AdventureMode_temple_skeleton_spawn_x", "0"))
    local y = tonumber(GlobalsGetValue("AdventureMode_temple_skeleton_spawn_y", "0"))
    if x ~= 0 then
      print("SPAWNINGNNNNN SKELETONG2")
      EntityLoad("mods/AdventureMode/files/temple_skeleton_portal.xml", x, y)
    end
  end
  -- EntityInflictDamage(skeleton, 666 / 25, "DAMAGE_HEALING", "", "NORMAL", 0, 0)
end
