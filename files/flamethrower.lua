dofile_once("data/scripts/lib/utilities.lua")
dofile_once("mods/AdventureMode/lib/coroutines.lua")

local entity_id = GetUpdatedEntityID()
local x, y, r = EntityGetTransform(entity_id)
local phase = GetValueNumber("phase", 0)
SetValueNumber("phase", math.fmod(phase + 0.02, math.pi*2))
r = math.pi/2 + math.sin(phase) * (math.pi/2 - 0.2)
EntitySetTransform(entity_id, x, y, r)

local dir_x = math.cos(r)
local dir_y = math.sin(r)
shoot_projectile(entity_id, "mods/AdventureMode/files/projectiles/flame_beam.xml", x + dir_x * 7, y + dir_y * 7, dir_x * 300, dir_y * 300, true)

-- if GameGetFrameNum() % 100 == 0 then --and math.abs(dir - actual_dir) < 0.5 then
--   async(function()
--     for i=1, 50 do          
--       local x, y, r = EntityGetTransform(entity_id)
--       if x then
--         local dir_x = math.cos(r)
--         local dir_y = math.sin(r)
--         shoot_projectile(entity_id, "mods/AdventureMode/files/projectiles/flame_beam.xml", x + dir_x * 7, y + dir_y * 7, dir_x * 200, dir_y * 200, true)
--         wait(0)
--       end
--     end
--   end)
-- end
