dofile_once("mods/AdventureMode/files/util.lua")

function on_open( entity_item )
	local x, y = EntityGetTransform( entity_item )
  EntityLoad("data/entities/particles/image_emitters/chest_effect.xml", x, y)
  local item_to_drop = get_var_store_string(entity_item, "item_to_drop")
  if item_to_drop then
    EntityLoad(item_to_drop, x, y)
  end
end

function item_pickup( entity_item, entity_who_picked, name )
	GamePrintImportant( "$log_chest", "" )

	on_open( entity_item )
	
	EntityKill( entity_item )
end

function physics_body_modified( is_destroyed )
	local entity_item = GetUpdatedEntityID()
	
	on_open( entity_item )

	edit_component( entity_item, "ItemComponent", function(comp,vars)
		EntitySetComponentIsEnabled( entity_item, comp, false )
	end)
	
	EntityKill( entity_item )
end
