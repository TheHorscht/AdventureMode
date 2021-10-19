function set_controls_enabled(enabled)
  local player = EntityGetWithTag("player_unit")[1]
  if player then
    local controls_component = EntityGetFirstComponentIncludingDisabled(player, "ControlsComponent")
    ComponentSetValue2(controls_component, "enabled", enabled)
    for prop, val in pairs(ComponentGetMembers(controls_component) or {}) do
      if prop:sub(1, 11) == "mButtonDown" then
        ComponentSetValue2(controls_component, prop, false)
      end
    end
  end
end

function entity_set_component_value(entity_id, component_name, property, value)
  local comp = EntityGetFirstComponentIncludingDisabled(entity_id, component_name)
  ComponentSetValue2(comp, property, value)
end

-- Returns true if an existing var store was updated or false if a new one was created
local function set_var_store(entity_id, name, value_type, value)
  local updated = false
  for i, comp in ipairs(EntityGetComponentIncludingDisabled(entity_id, "VariableStorageComponent") or {}) do
    if ComponentGetValue2(comp, "name") == name then
      ComponentSetValue2(comp, "value_" .. value_type, value)
      updated = true
    end
  end
  if not updated then
    EntityAddComponent2(entity_id, "VariableStorageComponent", {
      name = name,
      ["value_" .. value_type] = value
    })
  end
  return updated
end

function set_var_store_int(entity_id, name, value)
  set_var_store(entity_id, name, "int", value)
end

function set_var_store_bool(entity_id, name, value)
  set_var_store(entity_id, name, "bool", value)
end

function set_var_store_float(entity_id, name, value)
  set_var_store(entity_id, name, "float", value)
end

function set_var_store_string(entity_id, name, value)
  set_var_store(entity_id, name, "string", value)
end

local function get_var_store(entity_id, name, value_type)
  for i, comp in ipairs(EntityGetComponentIncludingDisabled(entity_id, "VariableStorageComponent") or {}) do
    if ComponentGetValue2(comp, "name") == name then
      local v = ComponentGetValue2(comp, "value_" .. value_type)
      return ComponentGetValue2(comp, "value_" .. value_type)
    end
  end
end

function get_var_store_int(entity_id, name)
  return get_var_store(entity_id, name, "int")
end

function get_var_store_bool(entity_id, name)
  return get_var_store(entity_id, name, "bool")
end

function get_var_store_float(entity_id, name)
  return get_var_store(entity_id, name, "float")
end

function get_var_store_string(entity_id, name)
  return get_var_store(entity_id, name, "string")
end
