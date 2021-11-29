function lever_changed()
  local solution = dofile_once("mods/AdventureMode/files/lever_puzzle/solution.lua")
  -- local solution = { 0, 0, 0, 0, 0, 0, 0, 0, 0, 1 }
  local is_solved = true
  for i=1, 10 do
    local lever_state = tonumber(GlobalsGetValue("AdventureMode_lever_puzzle_lever_" .. i, "0"))
    is_solved = is_solved and (solution[i] == lever_state)
  end
  if is_solved then
    local lever_puzzle_reward_entity = EntityGetWithName("lever_puzzle_reward")
    if lever_puzzle_reward_entity > 0 then
      local lua_component = EntityGetFirstComponentIncludingDisabled(lever_puzzle_reward_entity, "LuaComponent")
      EntitySetComponentIsEnabled(lever_puzzle_reward_entity, lua_component, true)
    end
  end
end
