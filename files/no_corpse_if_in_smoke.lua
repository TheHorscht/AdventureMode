dofile_once("data/scripts/lib/utilities.lua")
dofile_once("mods/AdventureMode/files/util.lua")
-- function material_area_checker_success(x, y)

	-- local entity_id = GetUpdatedEntityID()
	-- local x, y = EntityGetTransform( entity_id )

	-- -- local in_water, hit_x, hit_y = RaytraceSurfacesAndLiquiform( x, y, x, y )
	-- -- local in_solid, hit_x, hit_y = RaytracePlatforms( x, y, x, y )
	-- -- local in_any_material, hit_x, hit_y = Raytrace( x, y, x, y )

	-- -- if not in_water and not in_solid and in_any_material then

		-- local damage_model_component = EntityGetFirstComponentIncludingDisabled(entity_id, "DamageModelComponent")
		-- ComponentSetValue2(damage_model_component, "create_ragdoll", false)
		
	-- -- end

-- end

function material_area_checker_failed(x, y)
	local entity_id = GetUpdatedEntityID()
	local x, y = EntityGetTransform( entity_id )

	local corpse = EntityLoad("mods/AdventureMode/files/player_corpse.xml", x, y)
	local vel_comp = EntityGetFirstComponentIncludingDisabled(corpse, "VelocityComponent")
	local vx = get_var_store_float(entity_id, "vel_x")
	local vy = get_var_store_float(entity_id, "vel_y")
	local scale_x = get_var_store_int(entity_id, "scale_x")
	EntitySetTransform(corpse, x, y, 0, scale_x)
	-- Why do I need to do this like this? WTF? Doesn't need correction in the previous version when done directly in the lethal damage watcher.
	ComponentSetValue2(vel_comp, "mVelocity", vx * 1.2, vy - 7)
	
	EntityKill(entity_id)
end
