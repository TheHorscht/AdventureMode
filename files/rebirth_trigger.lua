dofile_once("data/scripts/lib/utilities.lua")

function interacting(entity_who_interacted, entity_interacted, interactable_name)
	entity_id = GetUpdatedEntityID()
	lua_comp = EntityGetFirstComponentIncludingDisabled( entity_id, "LuaComponent" )
	
	EntitySetComponentIsEnabled( entity_id, lua_comp, true )
	
	this_comp = GetUpdatedComponentID()
	EntityRemoveComponent( entity_id, this_comp )
end
