function set_controls_enabled(enabled)
  local player = EntityGetWithTag("player_unit")[1]
  if player then
    local controls_component = EntityGetFirstComponentIncludingDisabled(player, "ControlsComponent")
    ComponentSetValue2(controls_component, "enabled", enabled)
    for prop, val in pairs(ComponentGetMembers(controls_component) or {}) do
      if prop:sub(1, 11) == "mButtonDown" then
        ComponentSetValue2(controls_component, prop, false)
        print("Setting " .. prop .. " to false")
      end
    end
    -- ComponentSetValue2(controls_component, "enabled", enabled)
    -- ComponentSetValue2(controls_component, "enabled", enabled)
    -- ComponentSetValue2(controls_component, "enabled", enabled)
    -- ComponentSetValue2(controls_component, "enabled", enabled)
  end
end
