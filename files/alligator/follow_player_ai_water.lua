dofile( "data/scripts/lib/utilities.lua" )

local entity_id = GetUpdatedEntityID()

local x, y = EntityGetTransform( entity_id )

local player = get_players()[1]

if(player ~= nil)then

	local px, py = EntityGetTransform( player )

	--getting the direction to go to
	local dir = get_direction(x, y, px, py)
	local force = 30
	local force_x = math.cos(dir) * force
	local force_y = math.sin(dir) * force
	
	local cdc_id = EntityGetFirstComponentIncludingDisabled(entity_id, "CharacterDataComponent")
	local velocity_x, velocity_y = ComponentGetValue2(cdc_id, "mVelocity")

	local entity_in_water, hit_x, hit_y = RaytraceSurfacesAndLiquiform( x, y, x, y )
	local entity_in_solid, hit_x2, hit_y2 = RaytracePlatforms( x, y, x, y )
	local player_in_water, hit_x3, hit_y3 = RaytraceSurfacesAndLiquiform( px, py, px, py )
	local player_in_solid, hit_x4, hit_y4 = RaytracePlatforms( px, py, px, py )
	local path_not_clear, hit_x5, hit_y5 = RaytracePlatforms( x, y, px, py )

	if entity_in_water and not entity_in_solid and player_in_water and not player_in_solid and not path_not_clear then
		ComponentSetValueVector2(cdc_id, "mVelocity", velocity_x - force_x, velocity_y + force_y)
	end
end