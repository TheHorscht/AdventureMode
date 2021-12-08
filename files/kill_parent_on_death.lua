dofile_once("data/scripts/lib/utilities.lua")
function damage_received( damage, message, entity_thats_responsible, is_fatal  )

    if(is_fatal == true)then
		local entity_id = GetUpdatedEntityID()
		local parent_id = EntityGetParent( entity_id )

		if parent_id > 0 then

			local damage_model_component = EntityGetFirstComponentIncludingDisabled(parent_id, "DamageModelComponent")
			
			EntitySetComponentIsEnabled( parent_id, damage_model_component, true )
						
			ComponentSetValue2(damage_model_component, "hp", 0)
			ComponentSetValue2(damage_model_component, "air_needed", true)
			ComponentSetValue2(damage_model_component, "air_in_lungs", 0)
			
		end
	end
end