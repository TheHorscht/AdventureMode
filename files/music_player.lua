-- local previous_musio = "music/wandcave/01"

-- local entity_id = GetUpdatedEntityID()
-- local variable_storage_components = EntityGetComponent(entity_id, "VariableStorageComponent")

-- for k, v in pairs(variable_storage_components)do
	-- local name = ComponentGlobalsGetValue2(v, "name")

	-- if(name == "current_music")then
		-- variable_storage_component = v
		-- current_music = ComponentGlobalsGetValue2(v, "value_string") 
		
		-- previous_music = GlobalsGetValueNumber("previous_music", current_music)
		-- GlobalsSetValueNumber("previous_music", current_music)
	-- end
-- end

local x, y = GameGetCameraPos()

local previous_x = GlobalsGetValue("previous_x", 0)
local previous_y = GlobalsGetValue("previous_y", 0)

GlobalsSetValue("previous_x", x)
GlobalsSetValue("previous_y", y)

local previous_biome = BiomeMapGetName( previous_x, previous_y )
local current_biome = BiomeMapGetName( x, y )

function is_inside_biome(bx, by)
	if ( x > bx and x < bx + 512 ) and ( y > by and y < by + 512 ) then
		return true
	end
end

function is_inside_spear_biome(bx, by)
	if ( x > bx and x < bx + 512 ) and ( y > by and y < by + 175 ) then
		return true
	end
end

function is_inside_biome_water(bx, by)
	if ( x > bx and x < bx + 512 ) and ( y > by and y < by + 599 ) then
		return true
	end
end

function is_inside_biome_rising_lava(bx, by)
	if ( x > bx and x < bx + 512 ) and ( y > by and y < by + 612 ) then
		return true
	end
end

function is_inside_biome_statues(bx, by)
	if ( x > bx and x < bx + 512 ) and ( y > by and y < by + 412 ) then
		return true
	end
end

no_music = false

if current_biome == "_EMPTY_" then

	if is_inside_biome_statues(2560, -1436) == true or is_inside_biome(3072, -1536) == true or is_inside_biome(3584, -1623) == true then
		--statue corridor, golem room and gem room
		current_music = "music/lavalake/enter"
		
	elseif is_inside_spear_biome(1536, -1024) == true or is_inside_spear_biome(1024, -1024) == true then
		--Spike spear room
		current_music = "music/coalmine/03"
		
	-- elseif is_inside_biome(2560, -1536) == true then
		-- --Statue Corridor
		-- current_music = "ambience/temple"
		
	elseif is_inside_biome(4096, -1074) == true or is_inside_biome(3584, -1024) == true or is_inside_biome_water(3584, -1111) == true then
		--Lever Labyrinth
		current_music = "music/excavationsite/01"
		
	elseif is_inside_biome(4608, -1024) == true or is_inside_biome(3072, -1024) == true then
		--no music in maze room and gunpowder room please
		current_music = "no_please"
		
	elseif is_inside_biome(5632, -1024) == true or is_inside_biome(5120, -1024) == true then
		--spikes and walls room
		current_music = "music/crypt/01"
		
	elseif is_inside_biome(5632, -512) == true or is_inside_biome(6144, -512) == true then
		--stairs and tesla room
		current_music = "music/vault/01"
		
	elseif is_inside_biome(3584, -512) == true or is_inside_biome(4096, -512) == true or is_inside_biome(4608, -512) == true or is_inside_biome(3584, 0) == true or is_inside_biome(4608, 0) == true or is_inside_biome(3584, 512) == true or is_inside_biome(4608, 512) == true then
		--Alligator area
		current_music = "music/rainforest/03"
		
	elseif is_inside_biome(6144, -1024) == true or is_inside_biome(6656, -1024) == true or is_inside_biome(7168, -1024) == true then
		--gas cave
		current_music = "music/smokecave/03"
		
	elseif is_inside_biome_rising_lava(2560, -2048) == true or is_inside_biome_rising_lava(2048, -2048) == true or is_inside_biome_rising_lava(3072, -2048) == true then
		--rising lava and smoke area
		current_music = "music/coalmine/_02_used_in_credits"
		
	else

		current_music = "music/wandcave/01"

	end
	
else

	current_music = "music/wandcave/01"

end
previous_music = GlobalsGetValue("previous_music", 0)
GlobalsSetValue("previous_music", current_music)

if ( current_biome ~= previous_biome or current_music ~= previous_music ) then
	GameTriggerMusicFadeOutAndDequeueAll()
end

if current_music ~= "no_please" then
	GameTriggerMusicEvent( current_music, false, 0, 0 )
end