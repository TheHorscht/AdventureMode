dofile_once("mods/AdventureMode/files/util.lua")

function material_area_checker_success(x, y)
  local entity_id = GetUpdatedEntityID()
  -- print("Setting var store to false")

  local sprite_child = get_child_with_name(entity_id, "sprite")
  local light_component = EntityGetFirstComponentIncludingDisabled(sprite_child, "LightComponent")
  local sprite_component = EntityGetFirstComponentIncludingDisabled(sprite_child, "SpriteComponent")
  local sprite_component_world = EntityGetFirstComponentIncludingDisabled(entity_id, "SpriteComponent")
  local item_component = EntityGetFirstComponentIncludingDisabled(entity_id, "ItemComponent")
  if get_var_store_bool(entity_id, "is_on", true) then
    set_var_store_bool(entity_id, "is_on", false)
    ComponentSetValue2(sprite_component, "rect_animation", "disappear")
    ComponentSetValue2(sprite_component_world, "rect_animation", "out")
    ComponentSetValue2(sprite_component, "next_rect_animation", "out")
    ComponentSetValue2(item_component, "ui_sprite", "mods/AdventureMode/files/torch_off_ui_gfx.png")
    GameCreateParticle("smoke", x, y, 20, 0, -20, false, false)
  end
  ComponentRemoveTag(light_component, "enabled_in_hand")
  ComponentRemoveTag(light_component, "enabled_in_world")
  for i, comp in ipairs(EntityGetComponentIncludingDisabled(sprite_child, "ParticleEmitterComponent") or {}) do
    ComponentRemoveTag(comp, "enabled_in_hand")
    ComponentRemoveTag(comp, "enabled_in_world")
  end

  EntitySetComponentsWithTagEnabled(sprite_child, "fire", false)
  -- EntitySetComponentIsEnabled(sprite_child, sprite_comp, not is_enabled)
  -- EntitySetComponentIsEnabled(sprite_child, inherit_transform_component, true)
end
