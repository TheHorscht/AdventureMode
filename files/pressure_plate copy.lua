dofile_once("data/scripts/lib/utilities.lua")
dofile_once("data/scripts/game_helpers.lua")

local entity_id = GetUpdatedEntityID()
local x, y = EntityGetTransform(entity_id)

local pressed = GetValueBool("pressed", false)
local players = EntityGetWithTag("player_unit")
local did_hit = RaytracePlatforms(x - 10, y -2, x + 10, y - 2)
if did_hit then
  play_animation(entity_id, "down") 
  SetValueBool("pressed", true)
end

function down()
  local var_store_order = get_variable_storage_component(entity_id, "order")
  local order = ComponentGetValue2(var_store_order, "value_int")
  local torch = EntityGetWithName("puzzle_torch_" .. order)
  -- SetValueBool("something", true)
  EntityAddComponent2(torch, "LuaComponent", {
    script_source_file = "mods/AdventureMode/files/puzzle_torch_turn_on.lua",
    -- execute_on_added=true,
    execute_every_n_frame=1,
    remove_after_executed=true,
  })
  -- SetValueBool("something", true)
  -- torch = EntityGetAllChildren(torch)[1]
  -- local particle_emitter_components = EntityGetComponentIncludingDisabled(torch, "ParticleEmitterComponent")
  -- local light_component = EntityGetFirstComponentIncludingDisabled(torch, "LightComponent")
  -- EntitySetComponentIsEnabled(torch, light_component, true)
  -- local var_store_active = get_variable_storage_component(EntityGetParent(torch), "active")
  -- -- print("torch: " .. type(torch) .. " - " .. tostring(torch))
  -- -- print("var_store_active: " .. type(var_store_active) .. " - " .. tostring(var_store_active))
  -- ComponentSetValue2(var_store_active, "value_bool", true)
  -- for i, comp in ipairs(particle_emitter_components) do
  --   ComponentSetValue2(comp, "is_emitting", true)
  --   -- local x, y = EntityGetTransform(torch)
  --   -- GameCreateSpriteForXFrames("data/debug/circle_16.png", x, y, true, 8, 8, 60, true)
  --   -- EntitySetComponentIsEnabled(torch, comp, true)
  -- end
end

function up()
  local var_store = EntityGetFirstComponentIncludingDisabled(entity_id, "VariableStorageComponent")
  local order = ComponentGetValue2(var_store, "value_int")
  local torch = EntityGetWithName("puzzle_torch_" .. order)
  EntityAddComponent2(torch, "LuaComponent", {
    script_source_file = "mods/AdventureMode/files/puzzle_torch_turn_off.lua",
    execute_every_n_frame=1,
    remove_after_executed=true,
    -- execute_on_added=true,
    -- remove_after_executed=true,
  })
  -- torch = EntityGetAllChildren(torch)[1]
  -- local particle_emitter_components = EntityGetComponentIncludingDisabled(torch, "ParticleEmitterComponent")
  -- local light_component = EntityGetFirstComponentIncludingDisabled(torch, "LightComponent")
  -- EntitySetComponentIsEnabled(torch, light_component, false)
  -- local var_store_active = get_variable_storage_component(EntityGetParent(torch), "active")
  -- ComponentSetValue2(var_store_active, "value_bool", false)
  -- for i, comp in ipairs(particle_emitter_components) do
  --   ComponentSetValue2(comp, "is_emitting", false)
  --   -- EntitySetComponentIsEnabled(torch, comp, false)
  -- end
end

if GetValueInteger("depress_on_frame", GameGetFrameNum()) == GameGetFrameNum() then
  up()
  SetValueBool("pressed", false)
  play_animation(entity_id, "up")
end

if #players > 0 then
  local player_x, player_y = EntityGetTransform(players[1])
  if player_x > x - 10 and player_y < y and player_y > y - 4 and player_x < x + 10 then
    -- Check if it just switched from off to on
    if not GetValueBool("has_entity_on_top", false) then
      down()
      SetValueBool("pressed", true)
      play_animation(entity_id, "down")
    end
    SetValueInteger("depress_on_frame", -1)
    SetValueBool("has_entity_on_top", true)
  else
    if GetValueBool("has_entity_on_top", false) then
      local var_store_order = get_variable_storage_component(entity_id, "order")
      local order = ComponentGetValue2(var_store_order, "value_int")
      SetValueInteger("depress_on_frame", GameGetFrameNum() + 180 - order * 30)
    end
    SetValueBool("has_entity_on_top", false)
  end
end
