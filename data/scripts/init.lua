dofile_once("mods/AdventureMode/lib/coroutines.lua")

function OnWorldPreUpdate()
	wake_up_waiting_threads(1)
end

function OnPlayerDied( player_entity )
	GameDestroyInventoryItems( player_entity )
	-- async(function()
	-- 	wait(60)
	-- 	GamePrint("DED")
	-- 	BiomeMapLoad_KeepPlayer("data/biome_impl/biome_map.png")
	-- end)
	-- GameTriggerGameOver()
end
