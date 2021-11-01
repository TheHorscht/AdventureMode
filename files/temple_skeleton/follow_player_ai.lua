dofile( "data/scripts/lib/utilities.lua" )

local entity_id = GetUpdatedEntityID()
local x, y = EntityGetTransform(entity_id)


function draw_arrow(x1, y1, x2, y2)
  if EntityGetWithName("arrow") == 0 then
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
  local function get_direction( x1, y1, x2, y2 )
    local result = math.atan2( ( y2 - y1 ), ( x2 - x1 ) )
    return result
  end
  local arrow = EntityGetWithName("arrow")
  local dir = get_direction(x1, y1, x2, y2)
  local distance = get_distance(x1, y1, x2, y2)
  EntitySetTransform(arrow, x1, y1, dir, distance / 10, 0.2)
end

player_positions = player_positions or {}
own_positions = own_positions or {}

local player = EntityGetWithTag("player_unit")[1]
if player then
  local px, py = EntityGetTransform( player )
  local mx, my = DEBUG_GetMouseWorld()
  -- draw_arrow(px, py, mx, my)
  local target_x, target_y = px, py
  local behind_much = 0

  -- Track player position every 30 frames
  if GameGetFrameNum() % 15 == 0 then
    local found_normal, normal_x, normal_y, approximate_distance_from_surface = GetSurfaceNormal(px, py, 20, 16)
    local nx, ny = px, py
    if found_normal then
      nx = nx - normal_x * 20
      ny = ny - normal_y * 20
    end
    table.insert(player_positions, { x = nx, y = ny })
    if #player_positions > 60 then
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
    if #own_positions > 60 then
      table.remove(own_positions, 1)
    end
  end
  -- for i, v in ipairs(player_positions) do
  --   GameCreateSpriteForXFrames("mods/AdventureMode/files/dot_5x5.png", v.x, v.y, true, 0, 0, 1)
  -- end

  local cdc_id = EntityGetFirstComponentIncludingDisabled(entity_id, "CharacterDataComponent")
  local vx, vy = ComponentGetValue2(cdc_id, "mVelocity")
  local player_position_in_sight = false
  -- Step through player positions backwards and find the last position that is not obstructed
  for i=#player_positions, 1, -1 do
    -- print("Player Poooooooos")
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
      -- if new_speed < 50 then
        target_x, target_y = px, py
        player_position_in_sight = true
        behind_much = #player_positions - i
        break
      -- end
    end
  end
  if not player_position_in_sight then
    -- Backtrack for when he went too far ahead or something idk
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
        -- if new_speed < 50 then
          target_x, target_y = px, py
          break
        -- end
      end
    end
  end

  -- print("SHID")

  --getting the direction to go to
  local dir = get_direction(x, y, target_x, target_y)
  local distance = get_distance(x, y, px, py)
  local add_to = behind_much / math.max(1, #player_positions)
  distance = (clamp(distance, 20, 200) - 20) / 180 -- Normalize it
  local force = 2 + add_to * 10 + distance * 2
  local force_x = math.cos(dir) * force
  local force_y = math.sin(dir) * force

  
  -- draw_arrow(x, y, target_x, target_y)

  ComponentSetValue2(cdc_id, "mVelocity", vx - force_x, vy + force_y)
  -- ComponentSetValueVector2(cdc_id, "mVelocity", velocity_x - force_x, velocity_y + force_y)

end

