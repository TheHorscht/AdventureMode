dofile_once("data/scripts/lib/utilities.lua")

local entity_id = GetUpdatedEntityID()
local sprite_comps = EntityGetComponent(entity_id, "SpriteComponent") or {}

local number_of_times_ran = GetValueNumber("number_of_times_ran", 0)
SetValueNumber("number_of_times_ran", number_of_times_ran + 1)

if number_of_times_ran == 1140 then

	for i, comp in ipairs(sprite_comps) do
		
		local offset_x = ComponentGetValue2(comp, "offset_x")
		ComponentSetValue2(comp, "offset_x", offset_x - 1140)
		
	end
	
	SetValueNumber("number_of_times_ran", 0)

else

	for i, comp in ipairs(sprite_comps) do
		
		local offset_x = ComponentGetValue2(comp, "offset_x")
		ComponentSetValue2(comp, "offset_x", offset_x + 1)
		
	end

end