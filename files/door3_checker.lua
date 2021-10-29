local entity_id = GetUpdatedEntityID()
local x, y = EntityGetTransform(entity_id)

for i=1, 5 do
  if GlobalsGetValue("AdventureMode_puzzle_torch_active_" .. i, "0") == "0" then
    return
  end
end

for i, comp in ipairs(EntityGetComponentIncludingDisabled(entity_id, "LuaComponent") or {}) do
  EntitySetComponentIsEnabled(entity_id, comp, true)
end

EntityRemoveComponent(entity_id, GetUpdatedComponentID())
