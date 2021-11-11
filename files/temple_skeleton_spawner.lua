function collision_trigger(colliding_entity_id)
  local chase_in_progress = GlobalsGetValue("AdventureMode_temple_skeleton_chase_in_progress", "0") == "1"
  local temple_skeleton_beaten = GlobalsGetValue("AdventureMode_temple_skeleton_beaten", "0") == "1"
  if not (chase_in_progress or temple_skeleton_beaten) then
    local x = tonumber(GlobalsGetValue("AdventureMode_temple_skeleton_spawn_x", "0"))
    local y = tonumber(GlobalsGetValue("AdventureMode_temple_skeleton_spawn_y", "0"))
    if x ~= 0 then
      GlobalsSetValue("AdventureMode_temple_skeleton_chase_in_progress", "1")
      EntityLoad("mods/AdventureMode/files/temple_skeleton_portal.xml", x, y)
    end
  end
end
