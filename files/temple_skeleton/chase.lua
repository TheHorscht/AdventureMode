dofile_once("data/scripts/lib/utilities.lua")

function get_direction( x1, y1, x2, y2 )
	local result = math.atan2( ( y2 - y1 ), ( x2 - x1 ) )
	return result
end

local entity_id = GetUpdatedEntityID()
local x, y = EntityGetTransform(entity_id)

player_positions = player_positions or {}
own_positions = own_positions or {}

PhysicsApplyForce(entity_id, 0, -18)

local player = EntityGetWithTag("player_unit")[1]
if player then
  local px, py = EntityGetTransform(player)
  -- Track player position every 30 frames
  if GameGetFrameNum() % 30 == 0 then
    local found_normal, normal_x, normal_y, approximate_distance_from_surface = GetSurfaceNormal(px, py, 20, 16)
    local nx, ny = px, py
    if found_normal then
      nx = nx - normal_x * 20
      ny = ny - normal_y * 20
    end
    table.insert(player_positions, { x = nx, y = ny })
    if #player_positions > 30 then
      table.remove(player_positions, 1)
    end
    -- For backtracking in case we lost the player
    local found_normal, normal_x, normal_y, approximate_distance_from_surface = GetSurfaceNormal(x, y, 20, 16)
    local nx, ny = x, y
    if found_normal then
      nx = nx - normal_x * 20
      ny = ny - normal_y * 20
    end
    table.insert(own_positions, { x = nx, y = ny })
    -- GameCreateSpriteForXFrames("data/debug/circle_16.png", nx, ny, true, 0, 0, 120)
    if #own_positions > 30 then
      table.remove(own_positions, 1)
    end
  end
  for i, v in ipairs(player_positions) do
    GameCreateSpriteForXFrames("mods/AdventureMode/files/dot_5x5.png", v.x, v.y, true, 0, 0, 1)
  end
  local physics_body_component = EntityGetFirstComponentIncludingDisabled(entity_id, "PhysicsBodyComponent")
  local vx, vy = PhysicsGetComponentVelocity(entity_id, physics_body_component)
  local current_speed = math.sqrt(vx ^ 2 + vy ^ 2)
  local player_position_in_sight = false
  -- Step through player positions backwards and find the last position that is not obstructed
  for i=#player_positions, 1, -1 do
    local px, py = player_positions[i].x, player_positions[i].y
    local did_hit, hit_x, hit_y = RaytraceSurfaces(x, y, px, py)
    if not did_hit then
      local dir = get_direction(x, y, px, py)
      local distance = get_distance(x, y, px, py)
      local distance_min = 50
      local distance_max = 300
      local chase_power = 100
      distance = clamp(distance, distance_min, distance_max)
      -- Normalize
      distance = (distance - distance_min) / distance_max
      local fx, fy = math.cos(dir) * distance * chase_power, math.sin(dir) * distance * chase_power
      local new_speed = math.sqrt((vx + fx) ^ 2 + (vy + fy) ^ 2)
      if new_speed < 50 then
        PhysicsApplyForce(entity_id, fx, fy)
        draw_arrow(x, y, px, py)
        -- draw_arrow(x, y, x + fx, y + fy)
        player_position_in_sight = true
        break
      end
    end
  end
  if not player_position_in_sight then
    -- do return end
    -- Backtrack
    GamePrint("Backtracking")
    for i=#own_positions, 1, -1 do
      local px, py = own_positions[i].x, own_positions[i].y
      local did_hit, hit_x, hit_y = RaytraceSurfaces(x, y, px, py)
      if not did_hit then
        local dir = get_direction(x, y, px, py)
        local distance = get_distance(x, y, px, py)
        local distance_min = 50
        local distance_max = 300
        local chase_power = 100
        distance = clamp(distance, distance_min, distance_max)
        -- Normalize
        distance = (distance - distance_min) / distance_max
        local fx, fy = math.cos(dir) * distance * chase_power, math.sin(dir) * distance * chase_power
        local new_speed = math.sqrt((vx + fx) ^ 2 + (vy + fy) ^ 2)
        if new_speed < 50 then
          PhysicsApplyForce(entity_id, fx, fy)
          draw_arrow(x, y, px, py)
          -- draw_arrow(x, y, x + fx, y + fy)
        end
        break
      end
    end
  else
    GamePrint("NOT Backtracking")
  end
  -- PhysicsApplyForce(entity_id, math.cos(dir) * distance * chase_power, math.sin(dir) * distance * chase_power)
  -- local did_hit, hit_x, hit_y = RaytraceSurfaces(x, y, px, py)
  -- if not did_hit then
  --   local dir = get_direction(x, y, px, py)
  --   local distance = get_distance(x, y, px, py)
  --   local distance_min = 50
  --   local distance_max = 300
  --   local chase_power = 100
  --   distance = clamp(distance, distance_min, distance_max)
  --   -- local found_normal ,normal_x ,normal_y ,approximate_distance_from_surface = GetSurfaceNormal(pos_x, pos_y, ray_length, ray_count)
  --   -- Normalize
  --   distance = (distance - distance_min) / distance_max
  --   -- PhysicsApplyForce(entity_id, math.cos(dir) * distance * chase_power, math.sin(dir) * distance * chase_power)
  --   PhysicsApplyForce(entity_id, math.cos(dir) * distance * chase_power, math.sin(dir) * distance * chase_power)
  -- end
end






function draw_arrow(x1, y1, x2, y2)
  if EntityGetWithName("arrow") == 0 then
    -- local arrow = EntityGetWithName("arrow") > 0 and EntityGetWithName("arrow") or EntityCreateNew("arrow")
    local arrow = EntityCreateNew("arrow")
    EntitySetTransform(arrow, x1, y1, 0, 1, 0.1)
    EntityAddComponent2(arrow, "SpriteComponent", {
      image_file="mods/AdventureMode/files/box_10x10.png",
      offset_x=0,
      offset_y=5,
      alpha=1.0,
      z_index=-99,
      smooth_filtering=true,
    })
  end
  local arrow = EntityGetWithName("arrow")
  local dir = get_direction(x1, y1, x2, y2)
  local distance = get_distance(x1, y1, x2, y2)
  EntitySetTransform(arrow, x1, y1, dir, distance / 10, 0.2)
  do return end
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