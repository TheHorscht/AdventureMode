function death( damage_type_bit_field, damage_message, entity_thats_responsible, drop_items )

local doors = EntityGetWithTag("door_rebirth")

	if #doors > 0 then
		door = doors[1]
		
		lua_comp = EntityGetFirstComponentIncludingDisabled( door, "LuaComponent" )
		
		EntitySetComponentIsEnabled( door, lua_comp, true )
	end

end