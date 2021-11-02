dofile_once("mods/AdventureMode/files/util.lua")

function enabled_changed(entity_id, is_enabled)
  local is_on = get_var_store_bool(entity_id, "is_on", true)
  if is_on then
    local sprite_child = get_child_with_name(entity_id, "sprite")
    local sprite_comp = EntityGetFirstComponentIncludingDisabled(sprite_child, "SpriteComponent")
    local light_component = EntityGetFirstComponentIncludingDisabled(sprite_child, "LightComponent")
    local inherit_transform_component = EntityGetFirstComponentIncludingDisabled(sprite_child, "InheritTransformComponent")
    EntitySetComponentsWithTagEnabled(sprite_child, "fire", is_enabled)
    EntitySetComponentIsEnabled(sprite_child, sprite_comp, is_enabled)
    EntitySetComponentIsEnabled(sprite_child, inherit_transform_component, true)
  end
end
