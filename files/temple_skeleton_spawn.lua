local entity_id = GetUpdatedEntityID()
local x, y = EntityGetTransform(entity_id)

EntityLoad("mods/AdventureMode/files/temple_skeleton/temple_skeleton.xml", x, y)
EntityKill(entity_id)
