dofile_once("data/scripts/lib/utilities.lua")
dofile_once("data/scripts/game_helpers.lua")

local entity_id = GetUpdatedEntityID()
local x, y = EntityGetTransform(entity_id)

function turn_all_torches_off_and_reset_plates()
  GlobalsSetValue("AdventureMode_torch_puzzle_last_order_pressed", "0")
  local pressure_plates = EntityGetWithTag("pressure_plate")
  for i, plate in ipairs(pressure_plates) do
    EntityAddComponent2(plate, "VariableStorageComponent", { name = "reset" })
  end
end

function down()
  local var_store_order = get_variable_storage_component(entity_id, "order")
  local order = ComponentGetValue2(var_store_order, "value_int")
  GlobalsSetValue("AdventureMode_puzzle_torch_active_" .. order, "1")
  local last_order_pressed = tonumber(GlobalsGetValue("AdventureMode_torch_puzzle_last_order_pressed", "0"))
  if (last_order_pressed + 1) ~= order then
    turn_all_torches_off_and_reset_plates()
  else
    GlobalsSetValue("AdventureMode_torch_puzzle_last_order_pressed", last_order_pressed + 1)
  end
end

function up()
  local var_store_order = get_variable_storage_component(entity_id, "order")
  local order = ComponentGetValue2(var_store_order, "value_int")
  GlobalsSetValue("AdventureMode_puzzle_torch_active_" .. order, "0")
end

local var_store_reset = get_variable_storage_component(entity_id, "reset")
if var_store_reset and not GetValueBool("has_entity_on_top", false) then
  if GetValueBool("pressed", false) then
    up()
  end
  EntityRemoveComponent(entity_id, var_store_reset)
  SetValueBool("pressed", false)
  play_animation(entity_id, "up")
end

local players = EntityGetWithTag("player_unit")
if #players > 0 then
  local player_x, player_y = EntityGetTransform(players[1])
  if player_x > x - 10 and player_y < y and player_y > y - 4 and player_x < x + 10 then
    -- Check if it just switched from off to on
    if not GetValueBool("has_entity_on_top", false) and not GetValueBool("pressed", false) then
      down()
      SetValueBool("pressed", true)
      play_animation(entity_id, "down")
    end
    SetValueInteger("depress_on_frame", -1)
    SetValueBool("has_entity_on_top", true)
  else
    if GetValueBool("has_entity_on_top", false) then
      -- up()
      -- SetValueBool("pressed", false)
      -- play_animation(entity_id, "up")
    end
    SetValueBool("has_entity_on_top", false)
  end
end
