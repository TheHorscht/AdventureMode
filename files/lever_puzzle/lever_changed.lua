function lever_changed()
  local world_seed = tonumber(StatsGetValue("world_seed"))
  math.randomseed(world_seed)
  local amount = 10
  if not solution then
    solution = {}
    for i=1, amount do
      table.insert(solution, math.random(0, 1))
    end
  end
  -- local solution = { 0, 1, 0, 0, 1, 0, 1, 1, 1, 0 }
  -- local solution = { 0, 0, 0, 0, 0, 0, 0, 0, 0, 1 }
  local is_solved = true
  for i=1, amount do
    local lever_state = tonumber(GlobalsGetValue("AdventureMode_lever_puzzle_lever_" .. i, "0"))
    is_solved = is_solved and (solution[i] == lever_state)
  end
  if is_solved then
    local lever_puzzle_reward_entity = EntityGetWithName("lever_puzzle_reward")
    local lua_component = EntityGetFirstComponentIncludingDisabled(lever_puzzle_reward_entity, "LuaComponent")
    EntitySetComponentIsEnabled(lever_puzzle_reward_entity, lua_component, true)
  end
end
