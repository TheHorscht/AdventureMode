local entity_id = GetUpdatedEntityID()
local x, y = EntityGetTransform(entity_id)

if GlobalsGetValue("AdventureMode_red_gem_picked", "0") == "1" then
  EntityRemoveComponent(entity_id, GetUpdatedComponentID())
end

local function get_distance2( x1, y1, x2, y2 )
	-- Distance squared. More performant but does not return accurate distance in actual pixels. Good for comparing relative distances.
	return ( x2 - x1 ) ^ 2 + ( y2 - y1 ) ^ 2
end

local function vec_rotate(x, y, angle)
	local ca = math.cos(angle)
	local sa = math.sin(angle)
	local px = ca * x - sa * y
	local py = sa * x + ca * y
	return px,py
end

local function vec_dot(x1, y1, x2, y2)
	return x1 * x2 + y1 * y2
end

local function get_direction( x1, y1, x2, y2 )
	local result = math.atan2( ( y2 - y1 ), ( x2 - x1 ) )
	return result
end

local time_to_wait = 300

local player = EntityGetWithTag("player_unit")[1]
if player then
  local controls_comp = EntityGetFirstComponentIncludingDisabled(player, "ControlsComponent")
  if not ComponentGetValue2(controls_comp, "enabled") then
    last_frame_looked_away = GameGetFrameNum()
  end
  local check_keys = {
    "mButtonFrameLeft",
    "mButtonFrameRight",
    "mButtonFrameUp",
    "mButtonFrameDown",
    "mButtonFrameJump",
    "mButtonFrameFly",
  }
  -- Check if no key was pressed the last 5 seconds
  local no_key_pressed = true
  for i, key in ipairs(check_keys) do
    local frame_key = ComponentGetValue2(controls_comp, key)
    if frame_key + time_to_wait > GameGetFrameNum() then
      no_key_pressed = false
      break
    end
  end
  -- Check if player is looking(aiming) at the gem
  last_frame_looked_away = (last_frame_looked_away or GameGetFrameNum())
  local gem = EntityGetWithName("red_gem_in_statue_hand")
  if gem > 0 then
    local gx, gy = EntityGetTransform(gem)
    local px, py = EntityGetTransform(player)
    local max_distance = 170
    local dist2 = get_distance2(gx, gy, px, py)
    if dist2 > max_distance * max_distance then
      return
    end
    local aim_x, aim_y = ComponentGetValue2(controls_comp, "mAimingVector")
    local angle_to_gem = get_direction(px, py, gx, gy)
    local angle_aiming_at = get_direction(0, 0, aim_x, aim_y)
    if math.abs(angle_aiming_at - angle_to_gem) > 0.15 then
      last_frame_looked_away = GameGetFrameNum()
    end
  end

  if no_key_pressed and last_frame_looked_away + time_to_wait < GameGetFrameNum() then
    local character_data_comp = EntityGetFirstComponentIncludingDisabled(player, "CharacterDataComponent")
    local vx, vy = ComponentGetValue2(character_data_comp, "mVelocity")
    ComponentSetValue2(character_data_comp, "mVelocity", vx, -13)
  end
end
