local entity_id = GetUpdatedEntityID()
function get_state()
  _state = _state or {}
  _state[entity_id] = _state[entity_id] or {}
  return _state[entity_id]
end
local state = get_state()

local amount_of_slices = 64

if not GetValueBool("initialized", false) then
  state.sprite_entities = {}
  for i=1, amount_of_slices do
    local sub_entity = EntityCreateNew()
    local sprite_component = EntityAddComponent2(sub_entity, "SpriteComponent", {
      _tags="enabled_in_world,enabled_in_hand",
      image_file="mods/AdventureMode/files/cone_of_light.png",
      fog_of_war_hole=true,
      smooth_filtering=true,
      offset_x=12,
      offset_y=25,
    })
    EntityAddComponent2(sub_entity, "InheritTransformComponent", {
      only_position=true,
    })
    local rot = (i-1) * (math.pi * 2 / amount_of_slices)
    EntitySetTransform(sub_entity, 0, 0, rot)
    EntityAddChild(entity_id, sub_entity)
    table.insert(state.sprite_entities, sub_entity)
  end
  SetValueBool("initialized", true)
end

function get_distance( x1, y1, x2, y2 )
	local result = math.sqrt( ( x2 - x1 ) ^ 2 + ( y2 - y1 ) ^ 2 )
	return result
end

local max_length = 70
for i=1, amount_of_slices do
  local rot = (i-1) * (math.pi * 2 / amount_of_slices)
  local x, y = EntityGetTransform(entity_id)
  local did_hit, hit_x, hit_y = RaytraceSurfaces(x, y, x + math.cos(rot) * max_length, y + math.sin(rot) * max_length)
  local length = max_length
  if did_hit then
    length = get_distance(x, y, hit_x, hit_y)
  end
  local sx, sy = EntityGetTransform(state.sprite_entities[i])
  EntitySetTransform(state.sprite_entities[i], sx, sy, rot, length / max_length, length / max_length)
end
