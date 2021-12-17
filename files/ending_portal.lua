function do_teleport(entity)
	dofile_once("mods/AdventureMode/lib/coroutines.lua")
  dofile_once("mods/AdventureMode/files/util.lua")
  dofile_once("mods/AdventureMode/files/camera.lua")
  dofile_once("data/scripts/lib/utilities.lua")
 
	-- So it doesn't apply the heatwarping shader effect
	GlobalsSetValue("AdventureMode_game_complete", "1")

  EntitySetTransform( entity, 270, -85 )
  
  local x, y, r = EntityGetTransform(entity)
  
  set_controls_enabled(false)
	GameSetCameraFree(true)
  
	EntityAddComponent2(entity, "LuaComponent", { 
		script_source_file="mods/AdventureMode/files/move_right.lua",
		execute_every_n_frame=1,
	})
	EntityAddComponent2(entity, "LuaComponent", { 
		script_source_file="mods/AdventureMode/files/roll_credits.lua",
		execute_every_n_frame=1
	})
	
	local world_state = GameGetWorldStateEntity()
	local lua_comps = EntityGetComponent(world_state, "LuaComponent")
	for i, lua_comp in ipairs(lua_comps) do

		local script_source_file = ComponentGetValue2(lua_comp, "script_source_file")

		if(script_source_file == "mods/AdventureMode/files/music_player.lua")then
			EntityRemoveComponent( world_state, lua_comp )
		end
	end

  BiomeMapLoad_KeepPlayer("data/biome_impl/biome_map_original.png", "data/biome/_pixel_scenes_original.xml")
end


function collision_trigger(entity)
	do_teleport(entity)
end
