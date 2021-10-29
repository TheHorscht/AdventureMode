dofile_once("data/scripts/lib/utilities.lua")
dofile_once("mods/AdventureMode/files/util.lua")

local entity_id = GetUpdatedEntityID()
local x, y, rot, scale_x = EntityGetTransform(entity_id)

if GameGetFrameNum() % 80 == 0 then
  shoot_projectile(entity_id, "mods/AdventureMode/files/projectiles/trap_slimeball.xml", x + (scale_x < 0 and -11 or 15), y, 100 * scale_x, 0, false)
end
