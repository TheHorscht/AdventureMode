if GlobalsGetValue("AdventureMode_respawn_in_progress", "0") == "1" then
	local entity_id = GetUpdatedEntityID()

	local damage_model_component = EntityGetFirstComponentIncludingDisabled(entity_id, "DamageModelComponent")
	local max_hp = ComponentGetValue2(damage_model_component, "max_hp")

	ComponentSetValue2(damage_model_component, "hp", max_hp)
end