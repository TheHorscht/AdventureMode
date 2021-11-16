local lever_puzzle_solutions = {
  { 1, 1, 1, 0, 1, 0, 1, 1, 0 ,0 },
  { 0, 1, 0, 0, 0, 0, 1, 0, 1 ,1 },
  { 1, 0, 1, 0, 1, 0, 1, 0, 1 ,0 },
  { 0, 1, 1, 0, 1, 1, 1, 1, 0 ,1 },
  { 1, 1, 0, 1, 0, 1, 1, 0, 0 ,0 },
  { 0, 0, 0, 1, 1, 1, 0, 1, 0 ,1 },
}
local world_seed = tonumber(StatsGetValue("world_seed"))
math.randomseed(world_seed + 100)

return lever_puzzle_solutions[math.random(1, #lever_puzzle_solutions)]
