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
  -- Do door animation
  set_camera_manual(true)
  set_controls_enabled(false)
  local x, y = GameGetCameraPos()
  local entity_id = GetUpdatedEntityID()
  local door_x, door_y = EntityGetTransform(entity_id)
  camera_tracking_shot(x, y, door_x + 20, door_y + 40, 0.01)
  -- Clear pixel scene
  -- Open door
  GamePlaySound("mods/AdventureMode/files/audio/AdventureMode.bank", "rumble/start", door_x, door_y)
  local particle_emitter_component = EntityGetFirstComponentIncludingDisabled(entity_id, "SpriteParticleEmitterComponent")
  local sprite_component = EntityGetFirstComponentIncludingDisabled(entity_id, "SpriteComponent")
  EntitySetComponentIsEnabled(entity_id, sprite_component, true)
  EntitySetComponentIsEnabled(entity_id, particle_emitter_component, true)
  for i = 1, 10 do
    GameScreenshake(50, x, y)
    wait(0)
  end
  wait(15)
  EntitySetComponentIsEnabled(entity_id, particle_emitter_component, false)
  wait(40)
  GamePlaySound("mods/AdventureMode/files/audio/AdventureMode.bank", "rumble/loop", door_x, door_y)
  EntitySetComponentIsEnabled(entity_id, particle_emitter_component, true)
  LoadPixelScene("mods/AdventureMode/files/temple_door_remover.png", "", door_x, door_y, "", true)
  for i=1, 80 do
    ComponentSetValue2(sprite_component, "offset_y", i)
    GameScreenshake(10, x, y)
    wait(2)
  end
  -- ComponentSetValue2(sprite_component, "offset_y", 1)
  EntitySetComponentIsEnabled(entity_id, particle_emitter_component, false)
  GameScreenshake(50, x, y)
  GamePlaySound("mods/AdventureMode/files/audio/AdventureMode.bank", "rumble/stop", door_x, door_y)
  --   <SpriteParticleEmitterComponent
--   _enabled="0"
--   sprite_file="data/particles/jetpack_smoke.xml"
--   delay="0"
--   additive="1"
--   randomize_position.min_x="0"
--   randomize_position.max_x="40"
--   randomize_velocity.min_x="-10"
--   randomize_velocity.max_x="10"
--   randomize_velocity.min_y="20"
--   randomize_velocity.max_y="40"
--   count_min="1"
--   count_max="2"
--   emission_interval_min_frames="1"
--   emission_interval_max_frames="2"
--   is_emitting="1" 
--   render_back="0"
-- ></SpriteParticleEmitterComponent>

  -- EntityConvertToMaterial(entity_id, "templebrick_static")
  EntityRemoveComponent(entity_id, sprite_component)
  -- LoadPixelScene( materials_filename:string, colors_filename:string, x:number, y:number, background_file:string, skip_biome_checks:bool = false, skip_edge_textures:bool = false, color_to_material_table:{string-string} = {}, background_z_index:int = 50 )
  wait(60)
  local x, y = get_player_position()
  camera_tracking_shot(door_x + 20, door_y + 40, x, y, 0.01)
  set_camera_manual(false)
  set_controls_enabled(true)
  EntityKill(entity_id)
  -- camera_tracking_shot(x, y, door_x, door_y, 0.01)
  -- camera_tracking_shot(x, y, 400, -630, 0.0025)
end)
