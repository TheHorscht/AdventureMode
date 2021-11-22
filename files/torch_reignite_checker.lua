dofile_once("mods/AdventureMode/files/util.lua")

local entity_id = GetUpdatedEntityID()
local x, y = EntityGetTransform(entity_id)

function reignite()
  if not get_var_store_bool(entity_id, "is_on", true) then
    set_var_store_bool(entity_id, "is_on", true)
    local sprite_child = get_child_with_name(entity_id, "sprite")
    local burn_child = get_child_with_name(entity_id, "burn")
    local light_component = EntityGetFirstComponentIncludingDisabled(sprite_child, "LightComponent")
    local sprite_component = EntityGetFirstComponentIncludingDisabled(sprite_child, "SpriteComponent")
    local sprite_component_world = EntityGetFirstComponentIncludingDisabled(entity_id, "SpriteComponent")
    local item_component = EntityGetFirstComponentIncludingDisabled(entity_id, "ItemComponent")
    local ui_info_component = EntityGetFirstComponentIncludingDisabled(entity_id, "UIInfoComponent")
    local ability_component = EntityGetFirstComponentIncludingDisabled(entity_id, "AbilityComponent")
    ComponentSetValue2(sprite_component, "rect_animation", "appear")
    ComponentSetValue2(sprite_component_world, "rect_animation", "default")
    ComponentSetValue2(sprite_component, "next_rect_animation", "default")
    ComponentSetValue2(item_component, "ui_sprite", "data/ui_gfx/gun_actions/torch.png")
    ComponentSetValue2(item_component, "item_name", "Torch")
    ComponentSetValue2(item_component, "ui_description", "Portable fire")
    ComponentSetValue2(ui_info_component, "name", "Torch")
    ComponentSetValue2(ability_component, "ui_name", "Torch")
    ComponentAddTag(light_component, "enabled_in_hand")
    ComponentAddTag(light_component, "enabled_in_world")
    for i, comp in ipairs(EntityGetComponentIncludingDisabled(sprite_child, "ParticleEmitterComponent") or {}) do
      ComponentAddTag(comp, "enabled_in_hand")
      ComponentAddTag(comp, "enabled_in_world")
    end
    for i, comp in ipairs(EntityGetComponentIncludingDisabled(burn_child, "AudioComponent") or {}) do
      ComponentAddTag(comp, "enabled_in_hand")
      ComponentAddTag(comp, "enabled_in_world")
    end
    for i, comp in ipairs(EntityGetComponentIncludingDisabled(burn_child, "AudioLoopComponent") or {}) do
      ComponentAddTag(comp, "enabled_in_hand")
      ComponentAddTag(comp, "enabled_in_world")
    end
  
    -- Check if it's in world or held
    if EntityGetParent(entity_id) ~= 0 then
      EntitySetComponentsWithTagEnabled(sprite_child, "fire", true)
      EntitySetComponentsWithTagEnabled(burn_child, "fire", true)
    end
  end
end

for i, ent in ipairs(EntityGetInRadius(x, y + 8, 10) or {}) do
  if EntityGetName(ent) == "brazier" then
    reignite()
    break
  end
end
