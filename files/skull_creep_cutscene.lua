dofile_once("mods/AdventureMode/lib/coroutines.lua")
dofile_once("mods/AdventureMode/files/util.lua")
dofile_once("mods/AdventureMode/files/camera.lua")

local function get_player_position()
  local players = EntityGetWithTag("player_unit")
  if #players > 0 then
    return EntityGetTransform(players[1])
  end
end

async(function() 
  set_camera_manual(true)
  set_controls_enabled(false)
  local x, y = GameGetCameraPos()
  local entity_id = GetUpdatedEntityID()
  local door_x, door_y = EntityGetTransform(entity_id)
  
  local skulls = EntityGetWithTag("skull_creep")
  if #skulls > 0 then
	  skull = skulls[1]

	  local sx, sy = EntityGetTransform(skull)
	  
		local animal_ai_component = EntityGetFirstComponentIncludingDisabled(skull, "AnimalAIComponent")
		local physics_body_component = EntityGetFirstComponentIncludingDisabled(skull, "PhysicsBodyComponent")
		local physics_ai_component = EntityGetFirstComponentIncludingDisabled(skull, "PhysicsAIComponent")
	  
	  camera_tracking_shot(x, y, sx, sy, 0.01)
	
	  -- Clear pixel scene
	  -- LoadPixelScene("mods/AdventureMode/files/temple_door_remover.png", "", door_x, door_y, "", true)
	  -- Open door
	  GamePlaySound("data/audio/Desktop/animals.bank", "animals/boss_centipede/dying", sx, sy)

	  for i = 1, 10 do
		GameScreenshake(50, x, y)
		wait(0)
	  end
	  
	  EntitySetComponentIsEnabled( skull, physics_ai_component, true )
	  EntitySetComponentIsEnabled( skull, physics_body_component, true )
	  
	  wait(40)
	  
	  EntityLoad("mods/AdventureMode/files/water_drain.xml", x - 272, y + 202)
	  EntitySetComponentIsEnabled( skull, animal_ai_component, true )
	  set_controls_enabled(true)
	  local x, y = get_player_position()
	  camera_tracking_shot(sx, sy, x, y, 0.01)
	  set_camera_manual(false)
	  EntityKill(entity_id)
	  -- camera_tracking_shot(x, y, door_x, door_y, 0.01)
	  -- camera_tracking_shot(x, y, 400, -630, 0.0025)
  end
end)

