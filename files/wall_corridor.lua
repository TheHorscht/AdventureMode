dofile_once("mods/AdventureMode/files/util.lua")

local entity_id = GetUpdatedEntityID()
local x, y = EntityGetTransform(entity_id)

local DOWN = 1
local UP = -1
local last_spike_x = 0
function make_spike(distance_to_previous_spike, direction, delay, pause_out, pause_in, filepath)
  local new_x = last_spike_x + distance_to_previous_spike
  last_spike_x = new_x
  return {
    x = new_x,
    direction = direction,
    delay = delay,
    pause_out = pause_out,
    pause_in = pause_in,
	filepath = filepath,
  }
end

spikes = spikes or {
  
  make_spike(0, UP, 60, 80, 80, "mods/AdventureMode/files/lua_wall.xml"),
  make_spike(0, DOWN, 215, 80, 80, "mods/AdventureMode/files/lua_wall.xml"),
  make_spike(12, UP, 215, 80, 80, "mods/AdventureMode/files/lua_wall.xml"),
  make_spike(0, DOWN, 60, 80, 80, "mods/AdventureMode/files/lua_wall.xml"),
  make_spike(12, UP, 35, 80, 80, "mods/AdventureMode/files/lua_wall.xml"),
  make_spike(0, DOWN, 190, 80, 80, "mods/AdventureMode/files/lua_wall.xml"),
  make_spike(12, UP, 190, 80, 80, "mods/AdventureMode/files/lua_wall.xml"),
  make_spike(0, DOWN, 35, 80, 80, "mods/AdventureMode/files/lua_wall.xml"),
  make_spike(12, UP, 10, 80, 80, "mods/AdventureMode/files/lua_wall.xml"),
  make_spike(0, DOWN, 165, 80, 80, "mods/AdventureMode/files/lua_wall.xml"),
  make_spike(12, UP, 165, 80, 80, "mods/AdventureMode/files/lua_wall.xml"),
  make_spike(0, DOWN, 10, 80, 80, "mods/AdventureMode/files/lua_wall.xml"),

  make_spike(54, DOWN, 0, 25, 25, "mods/AdventureMode/files/lua_wall_thick.xml"),
  make_spike(54, UP, 0, 25, 25, "mods/AdventureMode/files/lua_wall_thick.xml"),
  
  make_spike(34, UP, 0, 20, 20, "mods/AdventureMode/files/lua_wall.xml"),
  make_spike(12, DOWN, 100, 20, 20, "mods/AdventureMode/files/lua_wall.xml"),
  make_spike(12, UP, 0, 20, 20, "mods/AdventureMode/files/lua_wall.xml"),
  make_spike(12, DOWN, 100, 20, 20, "mods/AdventureMode/files/lua_wall.xml"),
}

if spikes[1].entity_id then
  for i, v in ipairs(spikes) do
    EntityKill(v.entity_id)
    v.entity_id = nil
  end
else
  for i, v in ipairs(spikes) do
    local spike = EntityLoad(v.filepath)
    v.entity_id = spike
    EntitySetTransform(spike, x + v.x, y - 50 - 150 * math.min(0, v.direction), v.direction == -1 and math.pi or 0)
    set_var_store_int(spike, "order", i)
    set_var_store_int(spike, "delay", v.delay)
    set_var_store_int(spike, "direction", v.direction)
    set_var_store_int(spike, "pause_out", v.pause_out)
    set_var_store_int(spike, "pause_in", v.pause_in)
    -- local area_damage_component = EntityAddComponent2(spike, "AreaDamageComponent", {
      -- death_cause="Squashed",
      -- damage_type="DAMAGE_MELEE",
      -- damage_per_frame=4,
      -- update_every_n_frame=2,
    -- })
    -- ComponentSetValue2(area_damage_component, "aabb_min", -5, 0 + math.min(0, v.direction) * 50)
    -- ComponentSetValue2(area_damage_component, "aabb_max", 5, 50 + math.min(0, v.direction) * 50)
  end
end

