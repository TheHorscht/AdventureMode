local entity_id = GetUpdatedEntityID()
local x, y = EntityGetTransform(entity_id)

if GlobalsGetValue("AdventureMode_respawn_in_progress", "0") == "1" then

	GlobalsSetValue("AdventureMode_poison_challenge_in_progress", "0")
	
	EntityLoad("mods/AdventureMode/files/rising_lava/lava_remover.xml", x - 12, y + 332 )
	
	EntityKill(entity_id)
end

local number = GetValueNumber("number", 0)
SetValueNumber("number", number + 1)


local in_solid, hit_x, hit_y = RaytracePlatforms( x, y, x, y )

if number < 500  and not in_solid then
	EntitySetTransform( entity_id, x, y - 1 )
end