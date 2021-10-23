function get_state()
  local entity_id = GetUpdatedEntityID()
  _state = _state or {}
  _state[entity_id] = _state[entity_id] or {}
  return _state[entity_id]
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
    if state.direction == 1 then
      GamePrint("Setting pressed to false")
      SetValueBool("pressed", false)
    else
      GamePrint("Setting pressed to true")
      SetValueBool("pressed", true)
    end
  end
end

function interacting(entity_who_interacted, entity_interacted, interactable_name)
  local state = get_state()
  if state.progress then
    return
  end
  GamePrint("interacting")
  state.progress = 0
  local pressed = GetValueBool("pressed", false)
  print("pressed: " .. type(pressed) .. " - " .. tostring(pressed))
  if pressed then
    state.direction = 1
  else
    state.direction = -1
  end
end
