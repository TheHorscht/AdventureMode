dofile_once("mods/AdventureMode/lib/coroutines.lua")
dofile_once("mods/AdventureMode/files/util.lua")
dofile_once("mods/AdventureMode/files/camera.lua")

set_controls_enabled(false)
sequence(function()

  local world_state = GameGetWorldStateEntity()
  EntityAddComponent(world_state, "LuaComponent", {
	  script_source_file="mods/AdventureMode/files/music_player.lua",
  	  execute_every_n_frame=1,
  	  execute_on_added=1
  })
  
  set_camera_manual(true)
  camera_set_position(400, -800)
  -- camera_tracking_shot(400, -800, 400, -580, 0.0025)
  EntityLoad("mods/AdventureMode/files/intro_logo/aloittaa.xml", 400, -850)
  GameCreateSpriteForXFrames("mods/AdventureMode/files/intro_logo/version_info.png", 550, -850, true, 0, 0, 500, false)
  camera_tracking_shot(400, -800, 400, -800, 0.01)
  wait(180)
  camera_tracking_shot(400, -800, 400, -630, 0.0025)
  wait(250)
  -- camera_tracking_shot(400, -580, 600, -580, 0.002)
  camera_tracking_shot(400, -630, 570, -630, 0.002)
  camera_tracking_shot(570, -630, 570, -580, 0.007)
end,
function()
  local player = EntityGetWithTag("player_unit")[1]
  local x, y = EntityGetTransform(player)
  local camel = EntityLoad("mods/AdventureMode/files/camel.xml", x - 30, y)
  local character_data_component = EntityGetFirstComponentIncludingDisabled(player, "CharacterDataComponent")
  local character_data_component_camel = EntityGetFirstComponentIncludingDisabled(camel, "CharacterDataComponent")
  local controls_component = EntityGetFirstComponentIncludingDisabled(player, "ControlsComponent")
  local platform_shooter_player_component = EntityGetFirstComponentIncludingDisabled(player, "PlatformShooterPlayerComponent")
  local wand_angle = 15
  local vx, vy = math.cos(math.rad(wand_angle)), math.sin(math.rad(wand_angle))
  -- ComponentSetValue2(platform_shooter_player_component, "camera_max_distance_from_character", vx, vy)
  -- ComponentSetValue2(platform_shooter_player_component, "center_camera_on_this_entity", vx, vy)    <-- set this to false
  -- ComponentSetValue2(platform_shooter_player_component, "move_camera_with_aim", vx, vy)
  -- ComponentSetValue2(platform_shooter_player_component, "mSmoothedCameraPosition", vx, vy)
  -- ComponentSetValue2(platform_shooter_player_component, "mSmoothedAimingVector", vx, vy)
  -- ComponentSetValue2(platform_shooter_player_component, "mCameraDistanceLerped", vx, vy)
  ComponentSetValue2(platform_shooter_player_component, "mItemTemporarilyHidden", 7)
  -- ComponentSetValue2(platform_shooter_player_component, "mDesiredCameraPos", vx, vy)          <---- this ocntrols camera pos
  ComponentSetValue2(controls_component, "mAimingVector", vx, vy)
  ComponentSetValue2(controls_component, "mAimingVectorNormalized", vx, vy)
  ComponentSetValue2(controls_component, "mAimingVectorNonZeroLatest", vx, vy)
  ComponentSetValue2(controls_component, "mMousePosition", 5000, 0)
  ComponentSetValue2(controls_component, "mMousePositionRaw", 5000, 0)
  ComponentSetValue2(controls_component, "mMousePositionRawPrev", 5000, 0)
  ComponentSetValue2(controls_component, "mFlyingTargetY", -9999)
  -- ComponentSetValue2(character_data_component, "effect_hit_ground", false)
  wait(400)
  for i=1, 800 do
    ComponentSetValue2(character_data_component, "mVelocity", 35, 0)
    ComponentSetValue2(character_data_component, "is_on_ground", true)

    ComponentSetValue2(character_data_component_camel, "mVelocity", 35 - 15 * (i/800), 0)
    ComponentSetValue2(character_data_component_camel, "is_on_ground", true)
    wait(0)
  end
  -- Camel keeps walking but slows down more
  for i=1, 160 do
    ComponentSetValue2(character_data_component_camel, "mVelocity", 20 - 15 * (i/160), 0)
    ComponentSetValue2(character_data_component_camel, "is_on_ground", true)
    wait(0)
  end

  local damage_model_component_camel = EntityGetFirstComponentIncludingDisabled(camel, "DamageModelComponent")
  ComponentSetValue2(damage_model_component_camel, "air_in_lungs", -1)
  ComponentSetValue2(damage_model_component_camel, "air_in_lungs_max", 0)
  local camel_x, camel_y = EntityGetTransform(camel)
  GamePlaySound("mods/AdventureMode/files/audio/AdventureMode.bank", "camel_death", camel_x, camel_y)
  wait(100)
  -- The Noita turns around to look at the dead camel
  ComponentSetValue2(controls_component, "mAimingVector", -1, vy)
  ComponentSetValue2(controls_component, "mAimingVectorNormalized", -5000, vy)
  ComponentSetValue2(controls_component, "mAimingVectorNonZeroLatest", -5000, vy)
  ComponentSetValue2(controls_component, "mMousePosition", -5000, 0)
  wait(120)
  -- And turns back to the temple
  ComponentSetValue2(controls_component, "mAimingVector", 1, vy)
  ComponentSetValue2(controls_component, "mAimingVectorNormalized", 5000, vy)
  ComponentSetValue2(controls_component, "mAimingVectorNonZeroLatest", 5000, vy)
  ComponentSetValue2(controls_component, "mMousePosition", 5000, 0)
  wait(120)
end
).onDone(function()
  set_camera_manual(false)
  set_controls_enabled(true)
	-- local world_state = GameGetWorldStateEntity()
    -- local variable_storage = EntityGetComponent(world_state, "VariableStorageComponent")
	-- for k, v in pairs(variable_storage)do
		-- local name = ComponentGetValue2(v, "name")

		-- if(name == "current_music")then
			-- current_music = ComponentSetValue2(v, "value_string", "	music/smokecave_not_yet_used/02") 
		-- end
	-- end
end)
