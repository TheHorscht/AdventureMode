local entity_id = GetUpdatedEntityID()
local x, y = EntityGetTransform(entity_id)

local hitbox_comp = EntityGetFirstComponentIncludingDisabled(entity_id, "HitboxComponent")
local aabb_min_x = ComponentGetValue2(hitbox_comp, "aabb_min_x")
local aabb_min_y = ComponentGetValue2(hitbox_comp, "aabb_min_y")
local aabb_max_x = ComponentGetValue2(hitbox_comp, "aabb_max_x")
local aabb_max_y = ComponentGetValue2(hitbox_comp, "aabb_max_y")

function init(entity_id)
  local particle_emitter_comp = EntityGetFirstComponentIncludingDisabled(entity_id, "ParticleEmitterComponent")
  ComponentSetValue2(particle_emitter_comp, "x_pos_offset_min", aabb_min_x)
  ComponentSetValue2(particle_emitter_comp, "y_pos_offset_min", aabb_min_y)
  ComponentSetValue2(particle_emitter_comp, "x_pos_offset_max", aabb_max_x)
  ComponentSetValue2(particle_emitter_comp, "y_pos_offset_max", aabb_max_y)
end

local player = EntityGetWithTag("player_unit")[1]
if player then
  local px, py = EntityGetTransform(player)
  if px > aabb_min_x + x and px < aabb_max_x + x and
     py > aabb_min_y + y and py < aabb_max_y + y then
    local character_data_comp = EntityGetFirstComponentIncludingDisabled(player, "CharacterDataComponent")
    local vx, vy = ComponentGetValue2(character_data_comp, "mVelocity")
    if vy > -45 then
      ComponentSetValue2(character_data_comp, "mVelocity", vx, vy - 10)
    end
  end
end
