dofile( "data/scripts/lib/utilities.lua" )
dofile( "data/scripts/game_helpers.lua" )

local entity_id = GetUpdatedEntityID()
local x, y = EntityGetTransform( entity_id )

local player = EntityGetInRadiusWithTag(x, y, 300, "player_unit")

local player_id = player[1]

if #player > 0 then

local tag = "fish_attractor"
				
	if not EntityHasTag(player_id, tag) then
			
		EntityAddTag( player_id, tag )
		
		EntityAddComponent(player_id, "LuaComponent", {
			script_source_file="mods/AdventureMode/files/alligator/alligator_temple_attractor_checker.lua",
			execute_every_n_frame=20,
			execute_on_added=0,
		}) 
				
	end
end