local entity_id = GetUpdatedEntityID()
local x, y, rot = EntityGetTransform(entity_id)
EntitySetTransform(entity_id, x, y, rot + 0.15)