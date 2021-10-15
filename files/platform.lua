local entity_id = GetUpdatedEntityID()
local x, y = EntityGetTransform(entity_id)
local angle = GetValueNumber("angle", 0)
SetValueNumber("angle", angle + 0.03)
local vx = math.cos(angle) * 1

local players = EntityGetWithTag("player_unit")
if #players > 0 then
  local player = players[1]
  local px, py = EntityGetTransform(player)
  local character_data_component = EntityGetFirstComponentIncludingDisabled(player, "CharacterDataComponent")
  local pvx, pvy = ComponentGetValue2(character_data_component, "mVelocity")
  local vvy = (pvy/30)
  if pvy >= 0 and py < (y-1) and py + vvy >= (y-1) and    px >= x and px <= x + 10 then
    ComponentSetValue2(character_data_component, "is_on_ground", true)
    -- EntitySetTransform(player, px * vx * 3, y - 2)
    EntitySetTransform(player, px + vx * 3, y - 2)
    ComponentSetValue2(character_data_component, "mVelocity", pvx, 0)
    -- local sprite_component = EntityGetFirstComponentIncludingDisabled(player, "SpriteComponent")
    -- local sprite_animator_component = EntityGetFirstComponentIncludingDisabled(player, "SpriteAnimatorComponent")
    -- ComponentSetValue2(sprite_component, "rect_animation", "stand")
    -- EntitySetComponentIsEnabled(player, sprite_animator_component, false)
  end
end

EntitySetTransform(entity_id, x + vx, y)
