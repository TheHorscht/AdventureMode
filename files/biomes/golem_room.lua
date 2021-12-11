dofile_once("mods/AdventureMode/files/util.lua")

-- RegisterSpawnFunction( 0xffff5a0f, "spawn_music_trigger" )
RegisterSpawnFunction(0xffea238a, "spawn_golem_sleeping")

function spawn_music_trigger( x, y )
	EntityLoad( "data/entities/buildings/music_trigger_lavalake.xml", x, y )
end

 -- Funny golem lad

function spawn_golem_sleeping(x, y)
  EntityLoad("mods/AdventureMode/files/golem/sleeping.xml", x, y)
end
