function collision_trigger(colliding_entity_id)
  local chase_in_progress = GlobalsGetValue("AdventureMode_rising_lava_in_progress", "0") == "1"
  local temple_skeleton_beaten = GlobalsGetValue("AdventureMode_rising_lava_beaten", "0") == "1"
  if not (chase_in_progress or temple_skeleton_beaten) then
	local entity_id = GetUpdatedEntityID()
	local x, y = EntityGetTransform( entity_id )
	GlobalsSetValue("rising_lava", "1")
	EntityLoad("mods/AdventureMode/files/rising_lava/lava_producer.xml", x -158, y + 80 )
  end
end
