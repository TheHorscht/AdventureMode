dofile_once("data/scripts/lib/utilities.lua")

local entity_id    = GetUpdatedEntityID()
local pos_x, pos_y = EntityGetTransform( entity_id )

pos_y = pos_y - 45

local time  = GameGetFrameNum() / 60.0
local angle = time

multipler = 800

for i=1, 4 do
    local vel_x = math.cos(angle + math.pi / 2 * i)
    local vel_y = -math.sin(angle + math.pi / 2 * i)
    
    -- shoot_projectile( entity_id, "mods/AdventureMode/files/projectiles/lightning.xml", pos_x, pos_y, vel_x * 90 * multipler, vel_y * 90 * multipler )
	shoot_projectile( entity_id, "mods/AdventureMode/files/projectiles/lightning_damage.xml", pos_x, pos_y, vel_x * multipler, vel_y * multipler)
end

