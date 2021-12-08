dofile_once("mods/AdventureMode/lib/coroutines.lua")
dofile_once("mods/AdventureMode/files/util.lua")
dofile_once("mods/AdventureMode/files/camera.lua")
dofile_once("data/scripts/lib/utilities.lua")

local function get_player_position()
  local players = EntityGetWithTag("player_unit")
  if #players > 0 then
    return EntityGetTransform(players[1])
  end
end

async(function() 
  -- set_camera_manual(true)
  set_controls_enabled(false)
  local entity_id = GetUpdatedEntityID()
  local x, y = EntityGetTransform(entity_id)
  local px, py = get_player_position()
  local players = EntityGetWithTag("player_unit")
  
  local interactable_component = EntityGetFirstComponentIncludingDisabled(entity_id, "InteractableComponent")
  EntitySetComponentIsEnabled( entity_id, interactable_component, false )
  
  local sprite_components = EntityGetComponent(players[1], "SpriteComponent") or {}
	
	for i, sprite_component in ipairs(sprite_components) do

		if ComponentGetValue2(sprite_component, "image_file") == "data/enemies_gfx/player.xml" or ComponentGetValue2(sprite_component, "image_file") == "data/enemies_gfx/player_arm_no_item.xml" then
			ComponentRemoveTag( sprite_component, "character" )
			ComponentSetValue2(sprite_component, "rect_animation", "outro_lie_down")
			ComponentSetValue2(sprite_component, "next_rect_animation", "intro_sleep")
			
		end
		
	end
	
  wait(160)
  
  local particles = EntityLoad("mods/AdventureMode/files/rebirth_particles.xml", px, py)
  
  wait(100)
  
  local fingers = EntityGetWithTag("rebirth_finger")
  
  for i, finger in ipairs(fingers or {}) do
	EntitySetComponentsWithTagEnabled( finger, "particles", true )
  end
  
  wait(120)
  
	for i, sprite_component in ipairs(sprite_components) do

		if ComponentGetValue2(sprite_component, "image_file") == "data/enemies_gfx/player.xml" then
			ComponentSetValue2(sprite_component, "image_file", "data/enemies_gfx/player_purple.xml")
			ComponentSetValue2(sprite_component, "rect_animation", "intro_sleep")
			ComponentSetValue2(sprite_component, "next_rect_animation", "stand")			
		end
		
		if ComponentGetValue2(sprite_component, "image_file") == "data/enemies_gfx/player_arm_no_item.xml" then
			ComponentSetValue2(sprite_component, "image_file", "data/enemies_gfx/player_arm_no_item_purple.xml")
			ComponentSetValue2(sprite_component, "rect_animation", "intro_sleep")
			ComponentSetValue2(sprite_component, "next_rect_animation", "stand")			
		end
		
	end

	local player_arm = EntityGetWithName("arm_r")
	
	local player_arm_sprite_component = EntityGetFirstComponent( player_arm, "SpriteComponent" )
	ComponentSetValue2(player_arm_sprite_component, "image_file", "data/enemies_gfx/player_arm_purple.xml")
	
	local cape = EntityGetWithName("cape")
	
	edit_component( cape, "VerletPhysicsComponent", function(comp,vars) 
		vars.cloth_color = 0xFF7F5476
		vars.cloth_color_edge = 0xFF9B6F9A
	end)
  
  wait(120)
  
  for i, finger in ipairs(fingers or {}) do
	EntitySetComponentsWithTagEnabled( finger, "particles", false )
  end
  
  EntityKill(particles)
  
  GamePlaySound( "data/audio/Desktop/misc.bank", "misc/beam_from_sky_hit", x, y )
  
  wait(40)
  
  local sprite_components = EntityGetComponent(players[1], "SpriteComponent") or {}
  
	for i, sprite_component in ipairs(sprite_components) do

		if ComponentGetValue2(sprite_component, "image_file") == "data/enemies_gfx/player_purple.xml" or ComponentGetValue2(sprite_component, "image_file") == "data/enemies_gfx/player_arm_no_item_purple.xml" then

			ComponentSetValue2(sprite_component, "rect_animation", "intro_stand_up")
			ComponentSetValue2(sprite_component, "next_rect_animation", "stand")
			
		end
		
	end
	
  wait(180)
	
  set_controls_enabled(true)
  
	for i, sprite_component in ipairs(sprite_components) do

		if ComponentGetValue2(sprite_component, "image_file") == "data/enemies_gfx/player_purple.xml" or ComponentGetValue2(sprite_component, "image_file") == "data/enemies_gfx/player_arm_no_item_purple.xml" then

			ComponentAddTag( sprite_component, "character" )
			
			if ComponentGetValue2(sprite_component, "image_file") == "data/enemies_gfx/player_arm_no_item_purple.xml" then
				local sprite_arm = EntityGetFirstComponentIncludingDisabled(players[1], "SpriteComponent", "right_arm_root")
				EntityRemoveComponent(players[1], sprite_arm)
				
				EntityAddComponent2(players[1], "SpriteComponent", {
				  _tags="right_arm_root,character",
				  image_file="data/enemies_gfx/player_arm_no_item_purple.xml",
				  z_index=0.59
				})
			end
		end
		
	end
	
  wait(90)
  
  GlobalsSetValue("AdventureMode_aim_on_portal", "1")
  
  for i, finger in ipairs(fingers or {}) do
	EntitySetComponentsWithTagEnabled( finger, "particles", true )
  end
  
  EntityLoad("mods/AdventureMode/files/ending_portal.xml", x - 1, y - 92)
  
  wait(60)
  
  for i, finger in ipairs(fingers or {}) do
	EntitySetComponentsWithTagEnabled( finger, "particles", false )
  end
  
  EntityKill(entity_id)
end)

