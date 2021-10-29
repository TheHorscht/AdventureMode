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

function entity_set_component_is_enabled(entity_id, component_name, enabled)
  local comp = EntityGetFirstComponentIncludingDisabled(entity_id, component_name)
  EntitySetComponentIsEnabled(entity_id, comp, enabled)
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

function visualize_aabb(entity_id, component_type)
  local component = EntityGetFirstComponentIncludingDisabled(entity_id, component_type)
  local aabb = {}
  local a, b, c, d
  if component_type == "MaterialAreaCheckerComponent" then
    a, b, c, d = ComponentGetValue2(component, "area_aabb")
  elseif component_type == "AreaDamageComponent" then
    a, b = ComponentGetValue2(component, "aabb_min")
    c, d = ComponentGetValue2(component, "aabb_max")
  end
  aabb.min_x = a
  aabb.min_y = b
  aabb.max_x = c
  aabb.max_y = d
  local width = aabb.max_x - aabb.min_x
  local height = aabb.max_y - aabb.min_y
  local scale_x = width / 10
  local scale_y = height / 10
  local ent = EntityCreateNew()
  -- local x, y, rot = EntityGetTransform(entity_id)
  -- EntitySetTransform(ent, x, y, rot)
  EntityAddComponent2(ent, "InheritTransformComponent", {
    rotate_based_on_x_scale=true
  })
  EntityAddChild(entity_id, ent)
  EntityAddComponent2(ent, "SpriteComponent", {
    image_file="mods/AdventureMode/files/box_10x10.png",
    special_scale_x=scale_x,
    special_scale_y=scale_y,
    offset_x=-aabb.min_x / scale_x,
    offset_y=-aabb.min_y / scale_y,
    has_special_scale=true,
    alpha=0.5,
    z_index=-99,
    smooth_filtering=true,
  })
end
