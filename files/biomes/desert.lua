RegisterSpawnFunction(0xffc626dc, "spawn_cactus")
RegisterSpawnFunction(0xffbba86b, "spawn_door")
RegisterSpawnFunction(0xffbba86c, "spawn_door2")
RegisterSpawnFunction(0xffbba86d, "spawn_door3")
RegisterSpawnFunction(0xffa03232, "spawn_heart_fullhp")
RegisterSpawnFunction(0xff7f56cf, "spawn_liquid_checker")
RegisterSpawnFunction(0xffffff1b, "spawn_pickup_jetpack")
RegisterSpawnFunction(0xff32d6e7, "spawn_electricity_trap")
RegisterSpawnFunction(0xff37aab6, "spawn_pressure_plate")
RegisterSpawnFunction(0xff37aab7, "spawn_puzzle_torch")
RegisterSpawnFunction(0xff784249, "spawn_flamethrower_turret")
RegisterSpawnFunction(0xffec2b42, "spawn_chain_torch")
RegisterSpawnFunction(0xffd1b400, "spawn_slab_01")
RegisterSpawnFunction(0xffd1b499, "spawn_pile_of_bones")
RegisterSpawnFunction(0xffbbbbc2, "spawn_spike_corridor")
RegisterSpawnFunction(0xffaaaa01, "spawn_spike_corridor_skeleton_01")
RegisterSpawnFunction(0xffaaaa02, "spawn_spike_corridor_skeleton_02")
RegisterSpawnFunction(0xffaaaa03, "spawn_maze_skeleton_01")
RegisterSpawnFunction(0xffea238a, "spawn_golem")
RegisterSpawnFunction(0xff0aff90, "spawn_statue_pointing_right")
RegisterSpawnFunction(0xfffaff90, "spawn_statue_pointing_left")
RegisterSpawnFunction(0xff427800, "spawn_lever_puzzle")
RegisterSpawnFunction(0xff74b722, "spawn_lever_puzzle_reward")
RegisterSpawnFunction(0xffe33750, "spawn_temple_skeleton_spawner")
RegisterSpawnFunction(0xffe33751, "spawn_temple_skeleton")
RegisterSpawnFunction(0xffe33752, "spawn_temple_skeleton_kill_trigger")

local function shuffle(tbl)
  for i = #tbl, 2, -1 do
    local j = math.random(i)
    tbl[i], tbl[j] = tbl[j], tbl[i]
  end
  return tbl
end

local i = 0
function spawn_cactus(x, y)
  i = (i % 4) + 1
  EntityLoad("mods/AdventureMode/files/props/cactus"..i..".xml", x, y)
end

function spawn_door(x, y)
  EntityLoad("mods/AdventureMode/files/door.xml", x, y)
end

function spawn_door2(x, y)
  EntityLoad("mods/AdventureMode/files/door2.xml", x, y)
end

function spawn_door3(x, y)
  EntityLoad("mods/AdventureMode/files/door3.xml", x, y)
end

function spawn_heart_fullhp(x, y)
  EntityLoad("data/entities/items/pickup/heart_fullhp.xml", x, y)
end

function spawn_liquid_checker(x, y)
  EntityLoad("mods/AdventureMode/files/liquid_checker.xml", x, y)
  -- EntityLoad("mods/AdventureMode/files/platform.xml", x + 70, y - 10)
  -- EntityLoad("mods/AdventureMode/files/platform.xml", x + 70, y - 20)
  -- EntityLoad("mods/AdventureMode/files/platform.xml", x + 70, y - 30)
  -- EntityLoad("mods/AdventureMode/files/platform.xml", x + 70, y - 40)
  -- EntityLoad("mods/AdventureMode/files/platform.xml", x + 70, y - 50)
  -- EntityLoad("mods/AdventureMode/files/platform.xml", x + 70, y - 60)
end

function spawn_pickup_jetpack(x, y)
  EntityLoad("mods/AdventureMode/files/pickups/jetpack.xml", x, y - 10)
end

function spawn_electricity_trap(x, y)
  EntityLoad("data/entities/props/physics/trap_electricity_enabled.xml", x, y)
end

local pressure_plates_spawned = 0
function spawn_pressure_plate(x, y)
  pressure_plates_spawned = pressure_plates_spawned + 1
  EntityLoad("mods/AdventureMode/files/pressure_plate.xml", x, y)
  if pressure_plates_spawned == 5 then
    local pressure_plates = EntityGetWithTag("pressure_plate")
    local indices = {
      { 2, 5, 1, 3, 4 },
      { 2, 5, 3, 4, 1 },
      { 5, 2, 4, 3, 1 },
      { 1, 3, 2, 4, 5 },
      { 1, 4, 2, 5, 3 },
      { 3, 1, 2, 5, 4 },
    }
    math.randomseed(StatsGetValue("world_seed"))
    for i, v in ipairs(indices[math.random(#indices)]) do
      EntityAddComponent2(pressure_plates[v], "VariableStorageComponent", {
        name="order",
        value_int=i
      })
    end
  end
end

function spawn_puzzle_torch(x, y)
  local puzzle_torches_spawned = tonumber(GlobalsGetValue("AdventureMode_puzzle_torches_spawned", "0"))
  if puzzle_torches_spawned == 0 then
    EntityLoad("mods/AdventureMode/files/puzzle_torch_spawner.xml", x, y)
  end
  puzzle_torches_spawned = puzzle_torches_spawned + 1
  GlobalsSetValue("AdventureMode_puzzle_torches_spawned", puzzle_torches_spawned)
  GlobalsSetValue("AdventureMode_puzzle_torch_pos_x_" .. puzzle_torches_spawned, x)
  GlobalsSetValue("AdventureMode_puzzle_torch_pos_y_" .. puzzle_torches_spawned, y)
end

function spawn_flamethrower_turret(x, y)
  EntityLoad("mods/AdventureMode/files/flamethrower.xml", x, y)
end

function spawn_chain_torch(x, y)
  EntityLoad("data/entities/props/physics/chain_torch.xml", x, y)
  -- data/entities/props/physics_chain_torch.xml
end

function spawn_slab_01(x, y)
  EntityLoad("mods/AdventureMode/files/slab.xml", x, y)
end

function spawn_pile_of_bones(x, y)
  EntityLoad("mods/AdventureMode/files/skeletons/pile_of_bones.xml", x, y)
end

function spawn_spike_corridor(x, y)
  EntityLoad("mods/AdventureMode/files/spike_corridor.xml", x, y)
end

function spawn_spike_corridor_skeleton_01(x, y)
  EntityLoad("mods/AdventureMode/files/skeletons/spike_corridor_01.xml", x, y)
end

function spawn_spike_corridor_skeleton_02(x, y)
  EntityLoad("mods/AdventureMode/files/skeletons/spike_corridor_02.xml", x, y)
end

function spawn_maze_skeleton_01(x, y)
  EntityLoad("mods/AdventureMode/files/skeletons/maze_01.xml", x, y)
end

function spawn_golem(x, y)
  EntityLoad("mods/AdventureMode/files/golem.xml", x, y)
end

function spawn_statue_pointing_right(x, y)
  EntityLoad("mods/AdventureMode/files/statue_pointing_right.xml", x, y)
end

function spawn_statue_pointing_left(x, y)
  EntityLoad("mods/AdventureMode/files/statue_pointing_left.xml", x, y)
end

function spawn_lever_puzzle(x, y)
  EntityLoad("mods/AdventureMode/files/lever_puzzle.xml", x, y)
end

function spawn_lever_puzzle_reward(x, y)
  EntityLoad("mods/AdventureMode/files/lever_puzzle_reward.xml", x, y)
end

function spawn_temple_skeleton_spawner(x, y)
  -- EntityLoad("mods/AdventureMode/files/chaser.xml", x, y)
  EntityLoad("mods/AdventureMode/files/temple_skeleton_spawner.xml", x, y)
end

function spawn_temple_skeleton(x, y)
  -- EntityLoad("mods/AdventureMode/files/chaser.xml", x, y)
  GlobalsSetValue("AdventureMode_temple_skeleton_spawn_x", x)
  GlobalsSetValue("AdventureMode_temple_skeleton_spawn_y", y)
  -- EntityLoad("mods/AdventureMode/files/temple_skeleton/temple_skeleton.xml", x, y)
end

function spawn_temple_skeleton_kill_trigger(x, y)
  -- EntityLoad("mods/AdventureMode/files/chaser.xml", x, y)
  EntityLoad("mods/AdventureMode/files/temple_skeleton_kill_trigger.xml", x, y)
end
