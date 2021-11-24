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

function get_var_store_int(entity_id, name, default)
  return get_var_store(entity_id, name, "int") or default
end

function get_var_store_bool(entity_id, name, default)
  if get_var_store(entity_id, name, "bool") == nil then
    return default
  else
    return get_var_store(entity_id, name, "bool")
  end
end

function get_var_store_float(entity_id, name, default)
  return get_var_store(entity_id, name, "float") or default
end

function get_var_store_string(entity_id, name, default)
  return get_var_store(entity_id, name, "string") or default
end

function get_child_with_name(entity_id, name)
  for i, child in ipairs(EntityGetAllChildren(entity_id) or {}) do
    if EntityGetName(child) == name then
      return child
    end
  end
end

function visualize_aabb(entity_id, component_type)
  local component_type
  local types = {
    "MaterialAreaCheckerComponent",
    "AreaDamageComponent",
    "CollisionTriggerComponent",
    "HitboxComponent",
    "CharacterDataComponent",
  }
  local component
  for i, t in ipairs(types) do
    component = EntityGetFirstComponent(entity_id, t)
    if component then
      component_type = t
      break
    end
  end
  local aabb = {}
  local a, b, c, d
  if component_type == "MaterialAreaCheckerComponent" then
    a, b, c, d = ComponentGetValue2(component, "area_aabb")
  elseif component_type == "AreaDamageComponent" then
    a, b = ComponentGetValue2(component, "aabb_min")
    c, d = ComponentGetValue2(component, "aabb_max")
  elseif component_type == "CollisionTriggerComponent" then
    local width = ComponentGetValue2(component, "width")
    local height = ComponentGetValue2(component, "height")
    a, b = -width / 2, -height / 2
    c, d = width / 2, height / 2
  elseif component_type == "HitboxComponent" then
    a = ComponentGetValue2(component, "aabb_min_x")
    b = ComponentGetValue2(component, "aabb_min_y")
    c = ComponentGetValue2(component, "aabb_max_x")
    d = ComponentGetValue2(component, "aabb_max_y")
  elseif component_type == "CharacterDataComponent" then
    a = ComponentGetValue2(component, "collision_aabb_min_x")
    b = ComponentGetValue2(component, "collision_aabb_min_y")
    c = ComponentGetValue2(component, "collision_aabb_max_x")
    d = ComponentGetValue2(component, "collision_aabb_max_y")
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

function get_state(entity_id)
  _state = _state or {}
  _state[entity_id] = _state[entity_id] or {}
  return _state[entity_id]
end

function get_active_item()
	local player = EntityGetWithTag("player_unit")[1]
	local inv = EntityGetFirstComponentIncludingDisabled(player, "Inventory2Component")
	return ComponentGetValue2(inv, "mActiveItem")   
end

-- Doesn't work well, causes screen blackness effect and makes player immune to damage for a minute or so after teleporting...
function safe_teleport(entity, target_x, target_y)
  local ent = EntityCreateNew()
  local teleport_component = EntityAddComponent2(ent, "TeleportComponent", {
    target_x_is_absolute_position=true,
    target_y_is_absolute_position=true,
    load_collapse_entity=false,
  })
  ComponentSetValue2(teleport_component, "target", target_x, target_y)
  EntityAddComponent2(ent, "HitboxComponent", {
    aabb_min_x=-8,
    aabb_min_y=-8,
    aabb_max_x=8,
    aabb_max_y=8,
  })
  EntityAddComponent2(ent, "LifetimeComponent", {
    lifetime=5
  })
  local x, y = EntityGetTransform(entity)
  EntitySetTransform(ent, x, y)
  -- EntitySetTransform(entity, target_x, target_y)
end

function split_string(inputstr, sep)
  sep = sep or "%s"
  local t= {}
  for str in string.gmatch(inputstr, "([^"..sep.."]+)") do
    table.insert(t, str)
  end
  return t
end
