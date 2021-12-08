dofile( "data/scripts/lib/utilities.lua" )

local entity_id = GetUpdatedEntityID()
local x, y = EntityGetTransform( entity_id )

local entities = EntityGetInRadiusWithTag(x, y, 300, "mortal")

local quin_found_in_range = false

for i, entity in ipairs(entities) do

	if EntityGetName(entity) == "Alligator" then
	
		quin_found_in_range = true
		break
		
	end
	
end

if quin_found_in_range == false then

	local this_lua_component = GetUpdatedComponentID()
	local tag = "fish_attractor"

	EntityRemoveTag( entity_id, tag )
	EntityRemoveComponent(entity_id, this_lua_component)

end