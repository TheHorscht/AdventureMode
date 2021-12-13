dofile_once("data/scripts/biomes/temple_shared.lua" )

function collision_trigger()
	local entity_id    = GetUpdatedEntityID()
	local pos_x, pos_y = EntityGetTransform( entity_id )
	
	GameTriggerMusicEvent( "music/boss_arena/buildup", false, pos_x, pos_y )
end