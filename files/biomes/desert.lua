dofile_once("mods/AdventureMode/files/util.lua")

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
RegisterSpawnFunction(0xffea238a, "spawn_golem_sleeping")
for i=1, 10 do
  RegisterSpawnFunction(0xff427800 + i, "spawn_lever_puzzle_lever_" .. string.format("%.2d", i))
  RegisterSpawnFunction(0xfffaff90 + i, "spawn_lever_puzzle_statue_" .. string.format("%.2d", i))
end
RegisterSpawnFunction(0xff74b722, "spawn_lever_puzzle_reward")
RegisterSpawnFunction(0xffe32626, "spawn_brazier")
RegisterSpawnFunction(0xffc4001e, "spawn_wall_trap_shooting_left")
RegisterSpawnFunction(0xffe41c3a, "spawn_wall_trap_shooting_right")
RegisterSpawnFunction(0xffbba3a7, "spawn_spike_ground")
RegisterSpawnFunction(0xfff6bbc4, "spawn_spike_ceiling")
RegisterSpawnFunction(0xffe33750, "spawn_temple_skeleton_spawner")
RegisterSpawnFunction(0xffe33751, "spawn_temple_skeleton")
RegisterSpawnFunction(0xffe33752, "spawn_temple_skeleton_kill_trigger")
RegisterSpawnFunction(0xffff7bef, "spawn_respawn_statue")
RegisterSpawnFunction(0xff11c7e8, "spawn_respawn_point_save_trigger")

RegisterSpawnFunction(0xff517700, "spawn_leverdoor_puzzle_lever_01")
RegisterSpawnFunction(0xff517701, "spawn_leverdoor_puzzle_lever_02")
RegisterSpawnFunction(0xff517702, "spawn_leverdoor_puzzle_lever_03")
RegisterSpawnFunction(0xff517703, "spawn_leverdoor_puzzle_lever_04")
RegisterSpawnFunction(0xff517704, "spawn_leverdoor_puzzle_lever_05")
RegisterSpawnFunction(0xff517705, "spawn_leverdoor_puzzle_lever_06")

RegisterSpawnFunction(0xffcd0000, "spawn_leverdoor_puzzle_door_01")
RegisterSpawnFunction(0xffcd0001, "spawn_leverdoor_puzzle_door_02")
RegisterSpawnFunction(0xffcd0002, "spawn_leverdoor_puzzle_door_03")
RegisterSpawnFunction(0xffcd0003, "spawn_leverdoor_puzzle_door_04")
RegisterSpawnFunction(0xffcd0004, "spawn_leverdoor_puzzle_door_05")
RegisterSpawnFunction(0xffcd0005, "spawn_leverdoor_puzzle_door_06")
RegisterSpawnFunction(0xffcd0006, "spawn_leverdoor_puzzle_door_07")
RegisterSpawnFunction(0xffcd0007, "spawn_leverdoor_puzzle_door_08")
RegisterSpawnFunction(0xffcd0008, "spawn_leverdoor_puzzle_door_09")
RegisterSpawnFunction(0xffcd0009, "spawn_leverdoor_puzzle_door_10")
RegisterSpawnFunction(0xffcd0010, "spawn_leverdoor_puzzle_door_11")
RegisterSpawnFunction(0xffcd0011, "spawn_leverdoor_puzzle_door_12")
RegisterSpawnFunction(0xffcd0012, "spawn_leverdoor_puzzle_door_13")
RegisterSpawnFunction(0xffcd0013, "spawn_leverdoor_puzzle_door_14")
RegisterSpawnFunction(0xffcd0014, "spawn_leverdoor_puzzle_door_15")
RegisterSpawnFunction(0xffcd0015, "spawn_leverdoor_puzzle_door_16")

RegisterSpawnFunction(0xffc10908, "spawn_hand_holding_gem")
RegisterSpawnFunction(0xffc10909, "spawn_gem")
RegisterSpawnFunction(0xff50f7f7, "spawn_tractor_beam_150")

RegisterSpawnFunction(0xff39e161, "spawn_warp_portal_01")
RegisterSpawnFunction(0xff39e261, "spawn_warp_portal_01_target")
RegisterSpawnFunction(0xff39e162, "spawn_warp_portal_02")
RegisterSpawnFunction(0xff39e262, "spawn_warp_portal_02_target")
RegisterSpawnFunction(0xff39e163, "spawn_warp_portal_03")
RegisterSpawnFunction(0xff39e164, "spawn_warp_portal_04")
RegisterSpawnFunction(0xff39e165, "spawn_warp_portal_05")
RegisterSpawnFunction(0xff39e166, "spawn_warp_portal_06")

RegisterSpawnFunction(0xff304901, "spawn_portal_activator_02")


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

function spawn_golem_sleeping(x, y)
  EntityLoad("mods/AdventureMode/files/golem/sleeping.xml", x, y)
end

local lever_puzzle_solution = dofile_once("mods/AdventureMode/files/lever_puzzle/solution.lua")
for i=1,10 do
  local num_string = string.format("%.2d", i)
  _G["spawn_lever_puzzle_statue_" .. num_string] = function(x, y)
    local direction = lever_puzzle_solution[i] == 1 and "right" or "left"
    print("Spawning \"mods/AdventureMode/files/lever_puzzle/statue_pointing_" .. direction .. ".xml\"")
    EntityLoad("mods/AdventureMode/files/lever_puzzle/statue_pointing_" .. direction .. ".xml", x, y)
  end
  _G["spawn_lever_puzzle_lever_" .. num_string] = function(x, y)
    EntityLoad("mods/AdventureMode/files/lever_puzzle/lever_" .. num_string .. ".xml", x, y)
  end
end

function spawn_lever_puzzle_reward(x, y)
  EntityLoad("mods/AdventureMode/files/lever_puzzle/reward.xml", x, y)
end

function spawn_brazier(x, y)
  EntityLoad("mods/AdventureMode/files/brazier.xml", x, y - 12)
end

function spawn_wall_trap_shooting_left(x, y)
  local shooter = EntityLoad("mods/AdventureMode/files/wall_trap_shooter.xml", x + 1, y)
  EntityAddComponent2(shooter, "PixelSceneComponent", {
    pixel_scene="mods/AdventureMode/files/spitter_face_left.png",
    pixel_scene_visual="mods/AdventureMode/files/spitter_face_left_visual.png",
    offset_x=-11,
    offset_y=-14,
  })
  EntitySetTransform(shooter, x + 1, y, 0, -1)
end

function spawn_wall_trap_shooting_right(x, y)
  local shooter = EntityLoad("mods/AdventureMode/files/wall_trap_shooter.xml", x, y)
  EntityAddComponent2(shooter, "PixelSceneComponent", {
    pixel_scene="mods/AdventureMode/files/spitter_face_right.png",
    pixel_scene_visual="mods/AdventureMode/files/spitter_face_right_visual.png",
    offset_x=0,
    offset_y=-14,
  })
end

function spawn_spike_ground(x, y)
  EntityLoad("mods/AdventureMode/files/spike.xml", x, y + 1)
end

function spawn_spike_ceiling(x, y)
  EntityLoad("mods/AdventureMode/files/spike_ceil.xml", x, y)
end

function spawn_temple_skeleton_spawner(x, y)
  -- EntityLoad("mods/AdventureMode/files/chaser.xml", x, y)
  EntityLoad("mods/AdventureMode/files/temple_skeleton_spawner.xml", x, y)
end

function spawn_temple_skeleton(x, y)
  -- EntityLoad("mods/AdventureMode/files/chaser.xml", x, y)
  GlobalsSetValue("AdventureMode_temple_skeleton_spawn_x", x)
  GlobalsSetValue("AdventureMode_temple_skeleton_spawn_y", y)
end

function spawn_temple_skeleton_kill_trigger(x, y)
  EntityLoad("mods/AdventureMode/files/temple_skeleton_kill_trigger.xml", x, y)
end

function spawn_respawn_point_save_trigger(x, y)
  EntityLoad("mods/AdventureMode/files/save_trigger_area.xml", x, y - 20)
end

function spawn_respawn_statue(x, y)
  EntityLoad("mods/AdventureMode/files/respawn_statue/statue.xml", x, y)
end

function spawn_leverdoor_puzzle_lever_01(x, y)
  EntityLoad("mods/AdventureMode/files/door_lever_labyrinth/lever_01.xml", x, y)
end

function spawn_leverdoor_puzzle_lever_02(x, y)
  EntityLoad("mods/AdventureMode/files/door_lever_labyrinth/lever_02.xml", x, y)
end

function spawn_leverdoor_puzzle_lever_03(x, y)
  EntityLoad("mods/AdventureMode/files/door_lever_labyrinth/lever_03.xml", x, y)
end

function spawn_leverdoor_puzzle_lever_04(x, y)
  EntityLoad("mods/AdventureMode/files/door_lever_labyrinth/lever_04.xml", x, y)
end

function spawn_leverdoor_puzzle_lever_05(x, y)
  EntityLoad("mods/AdventureMode/files/door_lever_labyrinth/lever_05.xml", x, y)
end

function spawn_leverdoor_puzzle_lever_06(x, y)
  EntityLoad("mods/AdventureMode/files/door_lever_labyrinth/lever_06.xml", x, y)
end

function spawn_leverdoor_puzzle_door_01(x, y)
  -- EntityLoad("mods/AdventureMode/files/door_lever_labyrinth/laserdoor_01.xml", x, y)
end

function spawn_leverdoor_puzzle_door_02(x, y)
  EntityLoad("mods/AdventureMode/files/door_lever_labyrinth/laserdoor_02.xml", x, y)
end

function spawn_leverdoor_puzzle_door_03(x, y)
  EntityLoad("mods/AdventureMode/files/door_lever_labyrinth/laserdoor_03.xml", x, y)
end

function spawn_leverdoor_puzzle_door_04(x, y)
  EntityLoad("mods/AdventureMode/files/door_lever_labyrinth/laserdoor_04.xml", x, y)
end

function spawn_leverdoor_puzzle_door_05(x, y)
  EntityLoad("mods/AdventureMode/files/door_lever_labyrinth/laserdoor_05.xml", x, y)
end

function spawn_leverdoor_puzzle_door_06(x, y)
  EntityLoad("mods/AdventureMode/files/door_lever_labyrinth/laserdoor_06.xml", x, y)
end

function spawn_leverdoor_puzzle_door_07(x, y)
  EntityLoad("mods/AdventureMode/files/door_lever_labyrinth/laserdoor_07.xml", x, y)
end

function spawn_leverdoor_puzzle_door_08(x, y)
  EntityLoad("mods/AdventureMode/files/door_lever_labyrinth/laserdoor_08.xml", x, y)
end

function spawn_leverdoor_puzzle_door_09(x, y)
  EntityLoad("mods/AdventureMode/files/door_lever_labyrinth/laserdoor_09.xml", x, y)
end

function spawn_leverdoor_puzzle_door_10(x, y)
  EntityLoad("mods/AdventureMode/files/door_lever_labyrinth/laserdoor_10.xml", x, y)
end

function spawn_leverdoor_puzzle_door_11(x, y)
  EntityLoad("mods/AdventureMode/files/door_lever_labyrinth/laserdoor_11.xml", x, y)
end

function spawn_leverdoor_puzzle_door_12(x, y)
  EntityLoad("mods/AdventureMode/files/door_lever_labyrinth/laserdoor_12.xml", x, y)
end

function spawn_leverdoor_puzzle_door_13(x, y)
  EntityLoad("mods/AdventureMode/files/door_lever_labyrinth/laserdoor_13.xml", x, y)
end

function spawn_leverdoor_puzzle_door_14(x, y)
  EntityLoad("mods/AdventureMode/files/door_lever_labyrinth/laserdoor_14.xml", x, y)
end

function spawn_leverdoor_puzzle_door_15(x, y)
  EntityLoad("mods/AdventureMode/files/door_lever_labyrinth/laserdoor_15.xml", x, y)
end

function spawn_leverdoor_puzzle_door_16(x, y)
  EntityLoad("mods/AdventureMode/files/door_lever_labyrinth/laserdoor_16.xml", x, y)
end

function spawn_tractor_beam_150(x, y)
  EntityLoad("mods/AdventureMode/files/tractor_beam_150.xml", x, y)
end

function spawn_warp_portal_01(x, y)
  EntityLoad("mods/AdventureMode/files/warp_portals/01_spawner.xml", x, y)
end

function spawn_warp_portal_01_target(x, y)
  EntityLoad("mods/AdventureMode/files/warp_portals/01_target_spawner.xml", x, y)
end

function spawn_warp_portal_02(x, y)
  EntityLoad("mods/AdventureMode/files/warp_portals/02_spawner.xml", x, y)
end

function spawn_warp_portal_02_target(x, y)
  EntityLoad("mods/AdventureMode/files/warp_portals/02_target_spawner.xml", x, y)
end

function spawn_portal_activator_02(x, y)
  EntityLoad("mods/AdventureMode/files/warp_portals/02_activation_trigger.xml", x, y)
end

function spawn_warp_portal_03(x, y)
  -- EntityLoad("mods/AdventureMode/files/warp_portal_03.xml", x, y)
end

function spawn_warp_portal_04(x, y)
  -- EntityLoad("mods/AdventureMode/files/warp_portal_04.xml", x, y)
end

function spawn_warp_portal_05(x, y)
  -- EntityLoad("mods/AdventureMode/files/warp_portal_05.xml", x, y)
end

function spawn_warp_portal_06(x, y)
  -- EntityLoad("mods/AdventureMode/files/warp_portal_06.xml", x, y)
end

function spawn_hand_holding_gem(x, y)
  EntityLoad("mods/AdventureMode/files/slab_gem_hand.xml", x + 60, y)
  EntityLoad("mods/AdventureMode/files/hand_holding_gem.xml", x, y)
end

function spawn_gem(x, y)
  EntityLoad("mods/AdventureMode/files/gem.xml", x, y)
end

-- Regex to comment out function body:
-- (function spawn_leverdoor_puzzle_lever_0\d\(x, y\))([\s\S\n\r]*?)(end)
-- $1--[[$2]]$3
-- (function spawn_leverdoor_puzzle_lever_0\d\(x, y\))(--\[\[)([\s\S\n\r]*?)(\]\])(end)
-- $1$3$5
