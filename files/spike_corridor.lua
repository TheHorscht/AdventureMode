local entity_id = GetUpdatedEntityID()
local x, y = EntityGetTransform(entity_id)

-- local spikes = {
--   { direction = 1,}
-- }
local directions = {
  1, 1, 1, -1, -1, -1
}
for i=1, #directions do
  local spike = EntityLoad("mods/AdventureMode/files/spike_ceiling.xml")--, x + (i-1) * 10, y - 50)
  EntityAddComponent2(spike, "VariableStorageComponent", {
    name = "order",
    value_int = i
  })
  EntitySetTransform(spike, x + (i-1) * 10, y - 50 - 150 * math.min(0, directions[i]), directions[i] == -1 and math.pi or 0)
  EntityAddComponent2(spike, "VariableStorageComponent", {
    name = "direction",
    value_int = directions[i]
  })
  local area_damage_component = EntityAddComponent2(spike, "AreaDamageComponent", {
    death_cause="Stabbed",
    damage_type="DAMAGE_MELEE",
    damage_per_frame=0.001,
    update_every_n_frame=2,
  })
  ComponentSetValue2(area_damage_component, "aabb_min", -5, 0 + math.min(0, directions[i]) * 50)
  ComponentSetValue2(area_damage_component, "aabb_max", 5, 50 + math.min(0, directions[i]) * 50)
end
