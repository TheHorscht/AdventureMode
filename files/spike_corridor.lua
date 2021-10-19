dofile_once("mods/AdventureMode/files/util.lua")

local entity_id = GetUpdatedEntityID()
local x, y = EntityGetTransform(entity_id)

local DOWN = 1
local UP = -1
local last_spike_x = 0
function make_spike(distance_to_previous_spike, direction, delay, pause_out, pause_in)
  local new_x = last_spike_x + distance_to_previous_spike
  last_spike_x = new_x
  return {
    x = new_x,
    direction = direction,
    delay = delay,
    pause_out = pause_out,
    pause_in = pause_in,
  }
end

local spikes = {
  make_spike(0, DOWN, 0, 80, 80),
  make_spike(10, DOWN, 10, 80, 80),
  make_spike(10, DOWN, 20, 80, 80),
  make_spike(10, UP, 60, 80, 80),
  make_spike(10, UP, 70, 80, 80),
  make_spike(10, UP, 80, 80, 80),

  make_spike(25, DOWN, 0, 30, 30),
  make_spike(10, UP, 0, 30, 30),

  make_spike(25, DOWN, 0, 60, 0),
  make_spike(10, UP, 20, 60, 0),
  make_spike(10, DOWN, 40, 60, 0),
  make_spike(10, UP, 60, 60, 0),
  make_spike(10, DOWN, 80, 60, 0),
  make_spike(10, UP, 0, 60, 0),
  make_spike(10, DOWN, 20, 60, 0),
  make_spike(10, UP, 40, 60, 0),
  
  make_spike(25, UP, 0, 60, 0),
  make_spike(10, UP, 10, 60, 0),
  make_spike(10, UP, 20, 60, 0),
  make_spike(10, UP, 30, 60, 0),
  make_spike(10, UP, 40, 60, 0),
  make_spike(10, DOWN, 50, 60, 0),
  make_spike(10, DOWN, 60, 60, 0),
  make_spike(10, DOWN, 70, 60, 0),
  make_spike(10, DOWN, 80, 60, 0),
  make_spike(10, DOWN, 90, 60, 0),
  

}
print("== Corridor script runs ==")

if shit then
  print("== Corridor script: OnRemoved ==")
  EntityKill(shit)
  shit = nil
else
  print("== Corridor script: OnAdded ==")
  shit = EntityLoad("mods/AdventureMode/files/async_test.xml", x, y)
end
-- local a = EntityLoad("mods/AdventureMode/files/async_test.xml", x, y)
-- EntityAddComponent2(a, "SpriteComponent", {
--   image_file="data/debug/circle_16.png",
--   offset_x = 8,
--   offset_y = 8,
-- })
-- EntityLoad("mods/AdventureMode/files/async_test.xml", x, y)
do return end

for i, v in ipairs(spikes) do
  local spike = EntityLoad("mods/AdventureMode/files/spike_ceiling.xml")--, x + (i-1) * 10, y - 50)
  EntitySetTransform(spike, x + v.x, y - 50 - 150 * math.min(0, v.direction), v.direction == -1 and math.pi or 0)
  set_var_store_int(spike, "order", i)
  set_var_store_int(spike, "delay", v.delay)
  set_var_store_int(spike, "direction", v.direction)
  set_var_store_int(spike, "pause_out", v.pause_out)
  set_var_store_int(spike, "pause_in", v.pause_in)
  local area_damage_component = EntityAddComponent2(spike, "AreaDamageComponent", {
    death_cause="Stabbed",
    damage_type="DAMAGE_MELEE",
    damage_per_frame=0.001,
    update_every_n_frame=2,
  })
  ComponentSetValue2(area_damage_component, "aabb_min", -5, 0 + math.min(0, v.direction) * 50)
  ComponentSetValue2(area_damage_component, "aabb_max", 5, 50 + math.min(0, v.direction) * 50)
end
