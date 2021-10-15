function set_controls_enabled(enabled)
  local player = EntityGetWithTag("player_unit")[1]
  if player then
    local controls_component = EntityGetFirstComponentIncludingDisabled(player, "ControlsComponent")
    ComponentSetValue2(controls_component, "enabled", enabled)
    for prop, val in pairs(ComponentGetMembers(controls_component) or {}) do
      if prop:sub(1, 11) == "mButtonDown" then
        ComponentSetValue2(controls_component, prop, false)
      end
    end
    -- ComponentSetValue2(controls_component, "enabled", enabled)
    -- ComponentSetValue2(controls_component, "enabled", enabled)
    -- ComponentSetValue2(controls_component, "enabled", enabled)
    -- ComponentSetValue2(controls_component, "enabled", enabled)
  end
end

function entity_set_component_value(entity_id, component_name, property, value)
  local comp = EntityGetFirstComponentIncludingDisabled(entity_id, component_name)
  ComponentSetValue2(comp, property, value)
end
