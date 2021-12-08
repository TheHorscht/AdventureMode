dofile_once("mods/AdventureMode/files/util.lua")
dofile_once("data/scripts/gun/procedural/gun_action_utils.lua")

function item_pickup(entity_item, entity_pickupper, item_name)
	GamePrintImportant(item_name, "You gained a" .. item_name)
	
	-- local wands = find_all_wands_held( entity_who_picked )
	local wands = EntityGetWithTag("wand")

	for i,wand in ipairs(wands) do
	
		local ability_comp = EntityGetFirstComponentIncludingDisabled( wand, "AbilityComponent" )
		if( ability_comp ~= nil ) then
			local reload_time = tonumber( ComponentObjectGetValue( ability_comp, "gun_config", "reload_time" ) )
			local cast_delay = tonumber( ComponentObjectGetValue( ability_comp, "gunaction_config", "fire_rate_wait" ) )
			local mana_max = ComponentGetValue2( ability_comp, "mana_max" ) * 2
			local mana_charge_speed = ComponentGetValue2( ability_comp, "mana_charge_speed" ) * 2
			
			reload_time = reload_time * 0.5
			cast_delay = cast_delay * 0.5
			
			ComponentObjectSetValue( ability_comp, "gun_config", "reload_time", tostring(reload_time) )
			ComponentObjectSetValue( ability_comp, "gunaction_config", "fire_rate_wait", tostring(cast_delay) )
			ComponentSetValue2( ability_comp, "mana_max", mana_max )
			ComponentSetValue2( ability_comp, "mana_charge_speed", mana_charge_speed )
		end
	end 
	
	EntityKill(entity_item)
end
