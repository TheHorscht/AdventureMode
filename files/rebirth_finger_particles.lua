dofile_once("data/scripts/lib/utilities.lua")

local target = nil
local entity_id    = GetUpdatedEntityID()
local x, y = EntityGetTransform( entity_id )

local aim_on_portal = GlobalsGetValue("AdventureMode_aim_on_portal", "0") == "1"

local players = EntityGetWithTag("player_unit")
local portals = EntityGetWithTag("portal_tag")

if #players > 0 then
	if aim_on_portal then
		px, py = EntityGetTransform(portals[1])
	else
		px, py = EntityGetTransform(players[1])
	end
	local projectile = shoot_projectile( entity_id, "mods/AdventureMode/files/projectiles/green_lightning.xml", x, y, 0, 0)

	EntitySetTransform( projectile, px, py )

end