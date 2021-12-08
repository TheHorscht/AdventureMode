dofile_once("data/scripts/lib/utilities.lua")

local entity_id = GetUpdatedEntityID()
local x, y = EntityGetTransform(entity_id)

local players = EntityGetWithTag("player_unit")

local character_data_component = EntityGetFirstComponentIncludingDisabled(players[1], "CharacterDataComponent")
local vel_x, vel_y = ComponentGetValue2( character_data_component, "mVelocity" )
if #players > 0 then
  
    local player_x, player_y = EntityGetTransform(players[1])
	
	local old_player_x = GetValueNumber("old_player_x", player_x)
	local old_player_y = GetValueNumber("old_player_y", player_y)
	SetValueNumber("old_player_x", player_x)
	SetValueNumber("old_player_y", player_y)

    new_x = player_x
    new_y = player_y
	
	local variable_storage = EntityGetComponent(entity_id, "VariableStorageComponent")
	
	for k, v in pairs(variable_storage)do
		local name = ComponentGetValue2(v, "name")

		if(name == "top_edge")then
			top_edge = ComponentGetValue2(v, "value_string")
		elseif(name == "bottom_edge")then
			bottom_edge = ComponentGetValue2(v, "value_string")      
		elseif(name == "left_edge")then
			left_edge = ComponentGetValue2(v, "value_string")      
		elseif(name == "right_edge")then
			right_edge = ComponentGetValue2(v, "value_string")  
		end
	end
	
	local old_top_edge = GetValueNumber("old_top_edge", y)
	local old_bottom_edge = GetValueNumber("old_bottom_edge", y)
	SetValueNumber("old_top_edge", y + top_edge)
	SetValueNumber("old_bottom_edge", y + bottom_edge)
	
	local old_left_edge = GetValueNumber("old_left_edge", x)
	local old_right_edge = GetValueNumber("old_right_edge", x)
	SetValueNumber("old_left_edge", x + left_edge)
	SetValueNumber("old_right_edge", x + right_edge)
		
	if ( old_player_y < y + top_edge or old_player_y > y + bottom_edge ) or ( old_top_edge > player_y ) or ( old_bottom_edge < player_y ) then

		if ( player_y > y + top_edge and player_y < y ) and ( player_x > x + left_edge and player_x < x + right_edge ) then

			new_y = y + top_edge - 1
			ComponentSetValue2(character_data_component, "is_on_ground", true)
			ComponentSetValue2(character_data_component, "mVelocity", vel_x, 0)
			
		elseif ( player_y < y + bottom_edge and player_y > y ) and ( player_x > x + left_edge and player_x < x + right_edge ) then

			new_y = y + bottom_edge + 2
			ComponentSetValue2(character_data_component, "mVelocity", vel_x, 0)
		end
		
	-- elseif ( old_player_x < x + left_edge or old_player_x > x + right_edge ) or ( old_left_edge > player_x ) or ( old_right_edge < player_x ) then
	else
		
		if ( player_x > x + left_edge and player_x < x ) and ( player_y > y + top_edge and player_y < y + bottom_edge ) then
		
			new_x = x + left_edge - 1
		
		elseif ( player_x < x + right_edge and player_x > x ) and ( player_y > y + top_edge and player_y < y + bottom_edge ) then
		
			new_x = x + right_edge + 1

		end
	
	end

    if ( new_x ~= player_x ) or ( new_y ~= player_y ) then
	
        EntitySetTransform(players[1], new_x, new_y)
		
		--Inflict damage if squashing player:
		function kill_player()
		
			EntityInflictDamage(players[1], 999, "DAMAGE_PHYSICS_HIT", "", "NORMAL", 0, 0)
			
			-- local damage_model_component = EntityGetFirstComponent(players[1], "DamageModelComponent")

			-- ComponentSetValue2(damage_model_component, "hp", 0)
			-- ComponentSetValue2(damage_model_component, "air_needed", true)
			-- ComponentSetValue2(damage_model_component, "air_in_lungs", 0)
			
		end
		
		local ingrown_factor = 1
		
		local player_left_width = ComponentGetValue2( character_data_component, "collision_aabb_min_x" )
		local player_right_width = ComponentGetValue2( character_data_component, "collision_aabb_max_x" )
		local player_upper_height = ComponentGetValue2( character_data_component, "collision_aabb_min_y" ) - 1
		local player_lower_height = ComponentGetValue2( character_data_component, "collision_aabb_max_y" )
		
		local check_left_edge, hit_x1, hit_y1 = RaytracePlatforms(player_x + player_left_width, player_y + player_upper_height + 1, player_x + player_left_width, player_y + player_lower_height - 1)
		local check_right_edge, hit_x2, hit_y2 = RaytracePlatforms(player_x + player_right_width, player_y + player_upper_height + 1, player_x + player_right_width, player_y + player_lower_height -1 )
		local check_upper_edge, hit_x3, hit_y3 = RaytracePlatforms(player_x + player_left_width + 1, player_y + player_upper_height, player_x + player_right_width - 1, player_y + player_upper_height )
		local check_bottom_edge, hit_x4, hit_y4 = RaytracePlatforms(player_x + player_left_width + 1, player_y + player_lower_height, player_x + player_right_width - 1, player_y + player_lower_height )

		--if ( ( old_player_x < x + left_edge or old_player_x > x + right_edge ) or ( old_left_edge > player_x ) or ( old_right_edge < player_x ) ) and ( check_left_edge or check_right_edge) then
		if ( ( old_player_x < x + left_edge or old_player_x > x + right_edge ) or ( old_left_edge > player_x ) or ( old_right_edge < player_x ) ) and ( check_left_edge or check_right_edge) then
			
			kill_player()
			
		elseif ( ( old_player_y < y + top_edge ) or ( old_top_edge > player_y ) ) and check_upper_edge then 
		-- elseif ( ( old_player_y < y + top_edge or old_player_y > y + bottom_edge ) or ( old_top_edge > player_y ) or ( old_bottom_edge < player_y ) ) and ( check_upper_edge or check_bottom_edge) then 
			GamePrint("Squished Top")
			kill_player()
			
		elseif ( ( old_player_y > y + bottom_edge ) or ( old_bottom_edge < player_y ) ) and check_bottom_edge then 
			
			GamePrint("Squished Bottom")
			kill_player()
			
		end
		
    end
    
end