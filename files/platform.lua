local entity_id = GetUpdatedEntityID()
local x, y = EntityGetTransform(entity_id)

local players = EntityGetWithTag("player_unit")
if #players > 0 then
  local player = players[1]
  local px, py = EntityGetTransform(player)
  local character_data_component = EntityGetFirstComponentIncludingDisabled(player, "CharacterDataComponent")
  local controls_component = EntityGetFirstComponentIncludingDisabled(player, "ControlsComponent")
  local pvx, pvy = ComponentGetValue2(character_data_component, "mVelocity")
  local mButtonDownDown = ComponentGetValue2(controls_component, "mButtonDownDown")
  local hitbox_component = EntityGetFirstComponentIncludingDisabled(entity_id, "HitboxComponent")
  local aabb_min_x = ComponentGetValue2(hitbox_component, "aabb_min_x")
  local aabb_max_x = ComponentGetValue2(hitbox_component, "aabb_max_x")
  local vvy = (pvy/30)
  -- if not mButtonDownDown and pvy >= 0 and py < (y-1) and py + vvy >= (y-1) and    px >= x and px <= x + 10 then
  if not mButtonDownDown and pvy >= 0 and py < (y-1) and py + vvy >= (y-1) and    px >= (x+aabb_min_x) and px <= (x+aabb_max_x) then
    ComponentSetValue2(character_data_component, "is_on_ground", true)
    EntitySetTransform(player, px, y - 2)
    ComponentSetValue2(character_data_component, "mVelocity", pvx, 0)
  end
end
