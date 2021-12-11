function collision_trigger(entity)

  dofile_once("mods/AdventureMode/lib/coroutines.lua")
  dofile_once("mods/AdventureMode/files/util.lua")
  dofile_once("mods/AdventureMode/files/camera.lua")
  dofile_once("data/scripts/lib/utilities.lua")

  EntitySetTransform( entity, 270, -85 )
  
  local x, y, r = EntityGetTransform(entity)
  
  set_controls_enabled(false)
	
	GameSetCameraFree( "true" )
	GameSetCameraPos( 270, -85 )
  
	GameAddFlagRun( "ending_game_completed" )
	GameOnCompleted()
  
	GlobalsSetValue("AdventureMode_game_complete", "1")

	EntityAddComponent( entity, "LuaComponent", 
	{ 
		script_source_file="mods/AdventureMode/files/move_right.lua",
		execute_every_n_frame = "1"
	} )
	EntityAddComponent( entity, "LuaComponent", 
	{ 
		script_source_file="mods/AdventureMode/files/kill_player_on_timer.lua",
		execute_every_n_frame = "450"
	} )
	
	local world_state = GameGetWorldStateEntity()
	local lua_comps = EntityGetComponent(world_state, "LuaComponent")
	for i, lua_comp in ipairs(lua_comps) do

		local script_source_file = ComponentGetValue2(lua_comp, "script_source_file")

		if(script_source_file == "mods/AdventureMode/files/music_player.lua")then
			EntityRemoveComponent( world_state, lua_comp )
		end
	end
	
	GameTriggerMusicFadeOutAndDequeueAll()

  BiomeMapLoad_KeepPlayer("data/biome_impl/biome_map_original.png", "data/biome/_pixel_scenes_original.xml")
  EntityKill(entity)
end
