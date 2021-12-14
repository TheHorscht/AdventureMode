dofile( "data/scripts/lib/utilities.lua" )

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
	
	EntityKill(entity_id)
	
end