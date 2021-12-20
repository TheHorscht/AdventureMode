dofile_once("mods/AdventureMode/files/util.lua")

function get_state()
  local entity_id = GetUpdatedEntityID()
  _state = _state or {}
  _state[entity_id] = _state[entity_id] or {}
  return _state[entity_id]
end

if not GetValueBool("initialized", false) then
  local entity_id = GetUpdatedEntityID()
  local lever_pressed = false
  -- Intitialize to an already existing state, if global variable was set already
  local global_variable = get_var_store_string(entity_id, "global_variable")
  if global_variable then
    lever_pressed = GlobalsGetValue(global_variable, "0") == "1"
  end
  local handle_entity = EntityGetAllChildren(entity_id)[1]
  local hx, hy, hrot = EntityGetTransform(handle_entity)
  EntitySetTransform(handle_entity, hx, hy, math.rad(-45) + math.rad(90) * (lever_pressed and 1 or 0))
  SetValueBool("pressed", lever_pressed)
  SetValueBool("initialized", true)
end

local function activate(entity_id)
  local global_variable = get_var_store_string(entity_id, "global_variable")
  local toggle_global_variables = get_var_store_string(entity_id, "toggle_global_variables")
  local global_script_and_function = get_var_store_string(entity_id, "global_function")
  local global_script, global_function
  if global_script_and_function then
    global_script, global_function = unpack(split_string(global_script_and_function, ";"))
  end
  -- It's pressed on the right and unpressed on the left position
  local state = get_state()
  local new_state = state.direction == 1
  local lua_component = EntityGetFirstComponentIncludingDisabled(entity_id, "LuaComponent", "enable_on_lever_changed")
  if lua_component then
    EntitySetComponentIsEnabled(entity_id, lua_component, true)
  end
  SetValueBool("pressed", new_state)
  if global_variable then
    GlobalsSetValue(global_variable, new_state and "1" or "0")
  end
  if global_script then
    SetTimeOut(0, global_script, global_function)
  end
end

local state = get_state()
local speed = 0.05
if state.progress then
  local entity_id = GetUpdatedEntityID()
  local handle_entity = EntityGetAllChildren(entity_id)[1]
  local hx, hy, hrot = EntityGetTransform(handle_entity)
  state.progress = math.min(1, state.progress + speed)
  if state.direction == 1 then
    hrot = math.rad(-45) + math.rad(90) * state.progress
  else
    hrot = math.rad(45) - math.rad(90) * state.progress
  end
  EntitySetTransform(handle_entity, hx, hy, hrot)
  if state.progress == 1 then
    state.progress = nil
    if not state.instant_activation then
      activate(entity_id)
    end
  end
end

function interacting(entity_who_interacted, entity_interacted, interactable_name)

  local x, y = EntityGetTransform( entity_who_interacted )

  GlobalsSetValue("AdventureMode_respawn_x", x)
  GlobalsSetValue("AdventureMode_respawn_y", y)
  
  local state = get_state()
  if state.progress then
    return
  end
  state.progress = 0
  local pressed = GetValueBool("pressed", false)
  if pressed then
    state.direction = -1
  else
    state.direction = 1
  end
  -- on_lever_start
  local instant_activation = get_var_store_bool(entity_interacted, "instant_activation")
  state.instant_activation = instant_activation
  if instant_activation then
    activate(entity_interacted)
  end
end
