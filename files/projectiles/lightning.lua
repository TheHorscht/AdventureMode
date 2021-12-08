dofile_once( "data/scripts/lib/utilities.lua" )
local entity_id = GetUpdatedEntityID()

local x, y = EntityGetTransform( entity_id )
local projectile_component = EntityGetFirstComponentIncludingDisabled(entity_id, "ProjectileComponent")
local mWhoShot = ComponentGetValue2(projectile_component, "mWhoShot")
local ox, oy = EntityGetTransform( entity_id )
 
local did_hit, hit_x, hit_y = RaytraceSurfaces(x, y, ox, oy)

if did_hit then

	EntityKill(entity_id)

end