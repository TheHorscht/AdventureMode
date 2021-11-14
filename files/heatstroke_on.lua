local entity_id = GetUpdatedEntityID()
local x, y = EntityGetTransform(entity_id)

local owner = EntityGetRootEntity(entity_id)
EntityInflictDamage(owner, 100 / 25, "DAMAGE_FIRE", "Heatstroke", "NORMAL", 0, 0)
