dofile( "data/scripts/lib/utilities.lua" )

local entity_id = GetUpdatedEntityID()

local velocity_component = EntityGetFirstComponentIncludingDisabled(entity_id, "VelocityComponent")

local x, y, rot = EntityGetTransform( entity_id )

local corner_in_water, hit_x, hit_y = RaytraceSurfacesAndLiquiform( x, y, x, y )
local corner_in_solid, hit_x2, hit_y2 = RaytracePlatforms( x, y, x, y )

if corner_in_water and not corner_in_solid then
	ComponentSetValue2(velocity_component, "mVelocity", 0, -20)
end