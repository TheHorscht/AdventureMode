function collision_trigger(colliding_entity_id)
  local chase_in_progress = GlobalsGetValue("AdventureMode_alligator_chase_in_progress", "0") == "1"
  local temple_skeleton_beaten = GlobalsGetValue("AdventureMode_alligator_beaten", "0") == "1"
  if not (chase_in_progress or temple_skeleton_beaten) then
    -- local x = tonumber(GlobalsGetValue("AdventureMode_alligator_spawn_x", "0"))
    -- local y = tonumber(GlobalsGetValue("AdventureMode_alligator_spawn_y", "0"))
	
    -- local x2 = tonumber(GlobalsGetValue("AdventureMode_alligator_spawn_x2", "0"))
    -- local y2 = tonumber(GlobalsGetValue("AdventureMode_alligator_spawn_y2", "0"))
    -- if x ~= 0  and x2 ~= nil then
      -- GlobalsSetValue("AdventureMode_alligator_chase_in_progress", "1")
      -- EntityLoad("mods/AdventureMode/files/alligator/alligator_temple_small.xml", x - 42, y + 228)
	  -- EntityLoad("mods/AdventureMode/files/alligator/alligator_temple_small.xml", x2, y2)
    -- end
	
	local entity_id = GetUpdatedEntityID()
	local x, y = EntityGetTransform( entity_id )
	GlobalsSetValue("AdventureMode_alligator_chase_in_progress", "1")
	EntityLoad("mods/AdventureMode/files/alligator/alligator_temple_small.xml", x - 42, y + 228)
	EntityLoad("mods/AdventureMode/files/alligator/alligator_temple_small.xml", x + 228, y + 361)
	EntityLoad("mods/AdventureMode/files/alligator/alligator_temple_small.xml", x + 534, y + 205)
	EntityLoad("mods/AdventureMode/files/alligator/alligator_temple_small.xml", x + 1086, y + 143)
	EntityLoad("mods/AdventureMode/files/alligator/alligator_temple.xml", x + 740, y + 687)
	EntityLoad("mods/AdventureMode/files/alligator/alligator_temple_small.xml", x + 740, y + 737)
	EntityLoad("mods/AdventureMode/files/alligator/alligator_temple_small.xml", x + 740, y + 637)
	EntityLoad("mods/AdventureMode/files/alligator/alligator_temple_small.xml", x + 790, y + 687)
	EntityLoad("mods/AdventureMode/files/alligator/alligator_temple_small.xml", x + 690, y + 687)
	EntityLoad("mods/AdventureMode/files/alligator/alligator_temple_small.xml", x + 1020, y + 1034)
  end
end
