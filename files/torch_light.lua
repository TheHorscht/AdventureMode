dofile_once("mods/AdventureMode/files/util.lua")

local entity_id = GetUpdatedEntityID()
function get_state()
  _state = _state or {}
  _state[entity_id] = _state[entity_id] or {}
  return _state[entity_id]
end
local state = get_state()

local amount_of_slices = 64

-- check for sprite child entity to make sure this doesn't rn on on_added, because when the entity respawns,
-- for instance in debug mode when de/respawning player, the child entities will get loaded AFTER on_added runs
if not get_child_with_name(entity_id, "sprite") then
  return
end

if not get_child_with_name(entity_id, "light_cones") then
  state.sprite_entities = {}
  local container_entity = EntityCreateNew("light_cones")
  EntityAddComponent2(container_entity, "InheritTransformComponent", {
    _tags="enabled_in_world,enabled_in_inventory,enabled_in_hand",
  })
  EntityAddChild(entity_id, container_entity)
  for i=1, amount_of_slices do
    local sub_entity = EntityCreateNew()
    local sprite_component = EntityAddComponent2(sub_entity, "SpriteComponent", {
      _tags="enabled_in_world,enabled_in_hand,fire",
      image_file="mods/AdventureMode/files/cone_of_light.png",
      fog_of_war_hole=true,
      smooth_filtering=true,
      offset_x=12,
      offset_y=25,
    })
    EntityAddComponent2(sub_entity, "InheritTransformComponent", {
      _tags="enabled_in_world,enabled_in_inventory,enabled_in_hand",
      only_position=true,
    })
    local rot = (i-1) * (math.pi * 2 / amount_of_slices)
    EntitySetTransform(sub_entity, 0, 0, rot)
    EntityAddChild(container_entity, sub_entity)
    table.insert(state.sprite_entities, sub_entity)
  end
end

if not state.sprite_entities then
  -- This needs to happen in case the entity gets unloaded and reloaded, in which case the state gets lost
  state.sprite_entities = {}
  local container_entity = get_child_with_name(entity_id, "light_cones")
  for i, sprite_entity in ipairs(EntityGetAllChildren(container_entity) or {}) do
    table.insert(state.sprite_entities, sprite_entity)
  end
end

function get_distance( x1, y1, x2, y2 )
	local result = math.sqrt( ( x2 - x1 ) ^ 2 + ( y2 - y1 ) ^ 2 )
	return result
end

local enabled = get_var_store_bool(entity_id, "is_on", true)
local max_length = 70
for i=1, amount_of_slices do
  local rot = (i-1) * (math.pi * 2 / amount_of_slices)
  local x, y = EntityGetTransform(entity_id)
  local did_hit, hit_x, hit_y = RaytraceSurfaces(x, y, x + math.cos(rot) * max_length, y + math.sin(rot) * max_length)
  local length = max_length
  if did_hit then
    length = get_distance(x, y, hit_x, hit_y) + 5
  end
  local sx, sy = EntityGetTransform(state.sprite_entities[i])
  EntitySetTransform(state.sprite_entities[i], sx, sy, rot, length / max_length, length / max_length)
  EntitySetComponentsWithTagEnabled(state.sprite_entities[i], "fire", enabled)
  local inherit_transform_component = EntityGetFirstComponentIncludingDisabled(state.sprite_entities[i], "InheritTransformComponent")
  EntitySetComponentIsEnabled(state.sprite_entities[i], inherit_transform_component, true)
end

local container_entity = get_child_with_name(entity_id, "light_cones")
EntitySetComponentsWithTagEnabled(container_entity, "enabled_in_world", true)

function enabled_changed(entity_id, is_enabled)
  if get_var_store_bool(entity_id, "is_on", true) then
    local burn_entity = get_child_with_name(entity_id, "burn")
    local inherit_transform_component = EntityGetFirstComponentIncludingDisabled(burn_entity, "InheritTransformComponent")
    local magic_convert_material_comp = EntityGetFirstComponentIncludingDisabled(burn_entity, "MagicConvertMaterialComponent")
    EntitySetComponentIsEnabled(burn_entity, magic_convert_material_comp, is_enabled)
    EntitySetComponentIsEnabled(burn_entity, inherit_transform_component, is_enabled)
    local container_entity = get_child_with_name(entity_id, "light_cones")
    for i, ent in ipairs(EntityGetAllChildren(container_entity) or {}) do
      EntitySetComponentsWithTagEnabled(ent, "fire", is_enabled)
    end
  end
end
