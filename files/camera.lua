-- dofile_once("data/scripts/lib/utilities.lua")

local function clamp(value, min, max)
	value = math.max(value, min)
	value = math.min(value, max)
	return value
end

local function smoothstep(edge0, edge1, t)
  t = clamp((t - edge0) / (edge1 - edge0), 0, 1)
  return t * t * (3 - 2 * t)
end

local function smootherstep(edge0, edge1, t)
  t = clamp((t - edge0) / (edge1 - edge0), 0.0, 1.0)
  return t * t * t * (t * (t * 6 - 15) + 10)
end

local function smooth_lerp(a, b, t)
  t = smoothstep(0, 1, t)
	return a * t + b * (1 - t)
end

local function smooth_vec_lerp(x1, y1, x2, y2, weight)
	local x = smooth_lerp(x1, x2, weight)
	local y = smooth_lerp(y1, y2, weight)
	return x,y
end

function set_camera_manual(is_manual)
  local player = EntityGetWithTag("player_unit")[1]
  local platform_shooter_player_component = EntityGetFirstComponentIncludingDisabled(player, "PlatformShooterPlayerComponent")
  ComponentSetValue2(platform_shooter_player_component, "center_camera_on_this_entity", not is_manual)
end

function camera_get_position(x, y)
  local player = EntityGetWithTag("player_unit")[1]
  local platform_shooter_player_component = EntityGetFirstComponentIncludingDisabled(player, "PlatformShooterPlayerComponent")
  return ComponentGetValue2(platform_shooter_player_component, "mDesiredCameraPos")
end

function camera_set_position(x, y)
  local player = EntityGetWithTag("player_unit")[1]
  local platform_shooter_player_component = EntityGetFirstComponentIncludingDisabled(player, "PlatformShooterPlayerComponent")
  ComponentSetValue2(platform_shooter_player_component, "mDesiredCameraPos", x, y)
end

function camera_tracking_shot(start_x, start_y, end_x, end_y, speed)
  if not coroutine.running() then
    error("Needs to be called from within an async function", 2)
  end
  local player = EntityGetWithTag("player_unit")[1]
  local platform_shooter_player_component = EntityGetFirstComponentIncludingDisabled(player, "PlatformShooterPlayerComponent")
  -- ComponentSetValue2(platform_shooter_player_component, "center_camera_on_this_entity", false)
  local start_x, start_y = ComponentGetValue2(platform_shooter_player_component, "mDesiredCameraPos")
  local cx, cy = start_x, start_y
  local t = 0
  ComponentSetValue2(platform_shooter_player_component, "mDesiredCameraPos", cx, cy)
  wait(0)
  while true do
    t = t + speed
    if t >= 1 then
      t = 1
    end
    cx, cy = smooth_vec_lerp(end_x, end_y, start_x, start_y, t)
    ComponentSetValue2(platform_shooter_player_component, "mDesiredCameraPos", cx, cy)
    ComponentSetValue2(platform_shooter_player_component, "mSmoothedCameraPosition", cx, cy)
    if t >= 1 then
      break
    end
    wait(0)
  end
  -- ComponentSetValue2(platform_shooter_player_component, "center_camera_on_this_entity", true)
  camera_coroutine = nil
end
