local dialog_system = dofile_once("mods/AdventureMode/lib/DialogSystem/dialog_system.lua")

-- Make NPC stop walking while player is close
local entity_id = GetUpdatedEntityID()
local x, y = EntityGetTransform(entity_id)

local animal_ai_component = EntityGetFirstComponentIncludingDisabled(entity_id, "AnimalAIComponent")
local character_data_component = EntityGetFirstComponentIncludingDisabled(entity_id, "CharacterDataComponent")
local home_x, home_y = ComponentGetValue2(animal_ai_component, "mHomePosition")

if home_x > x then
	ComponentSetValue2(character_data_component, "mVelocity", 35, 0)
	ComponentSetValue2(character_data_component, "is_on_ground", true)
elseif home_x < x then
	ComponentSetValue2(character_data_component, "mVelocity", -35, 0)
	ComponentSetValue2(character_data_component, "is_on_ground", true)
end