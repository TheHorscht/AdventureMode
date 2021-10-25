local solution = { 0, 1, 0, 0, 1, 0, 1, 1, 1, 0 }
-- local solution = { 0, 0, 0, 0, 0, 0, 0, 0, 0, 1 }
local is_solved = true
local amount = 10
for i=1, amount do
  local lever_state = tonumber(GlobalsGetValue("AdventureMode_lever_puzzle_lever_" .. i, "0"))
  is_solved = is_solved and (solution[i] == lever_state)
end
if is_solved then
  local lever_puzzle_reward_entity = EntityGetWithName("lever_puzzle_reward")
  local lua_component = EntityGetFirstComponentIncludingDisabled(lever_puzzle_reward_entity, "LuaComponent")
  EntitySetComponentIsEnabled(lever_puzzle_reward_entity, lua_component, true)
end

local entity_id = GetUpdatedEntityID()
EntitySetComponentIsEnabled(entity_id, GetUpdatedComponentID(), false)
