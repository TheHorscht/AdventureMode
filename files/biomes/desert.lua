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
RegisterSpawnFunction(0xffd1b900, "spawn_slab_02")
RegisterSpawnFunction(0xff885454, "spawn_sign")
RegisterSpawnFunction(0xffd1b499, "spawn_pile_of_bones")
RegisterSpawnFunction(0xffbbbbc2, "spawn_spike_corridor")
RegisterSpawnFunction(0xffaaaa01, "spawn_spike_corridor_skeleton_01")
RegisterSpawnFunction(0xffaaaa02, "spawn_spike_corridor_skeleton_02")
RegisterSpawnFunction(0xffaaaa03, "spawn_maze_skeleton_01")
RegisterSpawnFunction(0xff18bbbb, "spawn_gas_cave_skeleton_01")
RegisterSpawnFunction(0xff5518bb, "spawn_gas_cave_skeleton_02")
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
RegisterSpawnFunction(0xffdbcb91, "spawn_levitation_refresh_pickup")

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
RegisterSpawnFunction(0xff08bb4d, "spawn_warp_portal_03_target")
RegisterSpawnFunction(0xff39e164, "spawn_warp_portal_04")
RegisterSpawnFunction(0xff39e165, "spawn_warp_portal_05")
RegisterSpawnFunction(0xff39e166, "spawn_warp_portal_06")

RegisterSpawnFunction(0xff304901, "spawn_portal_activator_02")
RegisterSpawnFunction(0xff426f78, "spawn_portal_activator_03")

RegisterSpawnFunction(0xffbb1748, "spawn_wall_corridor")

RegisterSpawnFunction(0xff881cb3, "floating_box_spawner")
RegisterSpawnFunction(0xffff9301, "spawn_pickup_jetpack2")

RegisterSpawnFunction(0xffbb2323, "spawn_music_trigger_spike")

RegisterSpawnFunction(0xff155fb3, "spawn_wand_statue")

RegisterSpawnFunction(0xff5011aa, "spawn_wand")
RegisterSpawnFunction(0xffc37114, "spawn_bullet")
RegisterSpawnFunction(0xff11a4c3, "spawn_arrow")
RegisterSpawnFunction(0xff4b11c3, "spawn_arrow_bullet")
RegisterSpawnFunction(0xffd90ee6, "spawn_bullet_heavy")

RegisterSpawnFunction(0xff23aa27, "spawn_tesla_coil")

RegisterSpawnFunction(0xff92991d, "spawn_zombies")
RegisterSpawnFunction(0xff1a1299, "spawn_monks")
RegisterSpawnFunction(0xff2bc311, "spawn_wand_boost")
RegisterSpawnFunction(0xffa26d18, "spawn_phantoms")
RegisterSpawnFunction(0xff78bb19, "spawn_alchemists")

RegisterSpawnFunction(0xff07e6b1, "spawn_breathless_perk")

RegisterSpawnFunction(0xff200bc3, "spawn_rising_lava_trigger")
RegisterSpawnFunction(0xffc31717, "spawn_rocket")

RegisterSpawnFunction(0xff22a6b3, "alligator_spawner")
RegisterSpawnFunction(0xff52881c, "spawn_alligator1")
RegisterSpawnFunction(0xff202d91, "spawn_alligator2")

RegisterSpawnFunction(0xffc30e0e, "spawn_alligator_chase_stop_trigger")

RegisterSpawnFunction(0xff9d20b3, "spawn_rebirth_door")
RegisterSpawnFunction(0xff10b315, "spawn_creep_skull")

RegisterSpawnFunction(0xffc1cc15, "spawn_rebirth_trigger")
RegisterSpawnFunction(0xff21bb33, "spawn_rebirth_finger")

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
  if GlobalsGetValue("AdventureMode_DEBUG_starting_position", "1") == "1" then
    EntityLoad("mods/AdventureMode/files/door.xml", x, y)
  end
end

function spawn_door2(x, y)
  if GlobalsGetValue("AdventureMode_DEBUG_starting_position", "1") == "1" then
    EntityLoad("mods/AdventureMode/files/door2.xml", x, y)
  end
end

function spawn_door3(x, y)
  if GlobalsGetValue("AdventureMode_DEBUG_starting_position", "1") == "1" then
    EntityLoad("mods/AdventureMode/files/door3.xml", x, y)
  end
end

for i=1, 15 do
  local num_string = string.format("%.2d", i)
  RegisterSpawnFunction(0xff426870 + i, "spawn_vanishing_block_" .. num_string)
  _G["spawn_vanishing_block_" .. num_string] = function(x, y)
    EntityLoad("mods/AdventureMode/files/vanishing_block_" .. num_string .. ".xml", x, y)
  end
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
  EntityLoad("mods/AdventureMode/files/slabs/slab.xml", x, y)
end

function spawn_slab_02(x, y)
  EntityLoad("mods/AdventureMode/files/slabs/slab_2.xml", x, y)
end

function spawn_sign(x, y)
  EntityLoad("mods/AdventureMode/files/sign.xml", x, y)
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

function spawn_gas_cave_skeleton_01(x, y)
  EntityLoad("mods/AdventureMode/files/skeletons/gas_cave.xml", x, y)
end

function spawn_gas_cave_skeleton_02(x, y)
  EntityLoad("mods/AdventureMode/files/skeletons/gas_cave_02.xml", x, y)
end

function spawn_golem_sleeping(x, y)
  EntityLoad("mods/AdventureMode/files/golem/sleeping.xml", x, y)
end

local lever_puzzle_solution = dofile_once("mods/AdventureMode/files/lever_puzzle/solution.lua")
for i=1,10 do
  local num_string = string.format("%.2d", i)
  _G["spawn_lever_puzzle_statue_" .. num_string] = function(x, y)
    local direction = lever_puzzle_solution[i] == 1 and "right" or "left"
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
  EntityLoad("mods/AdventureMode/files/spike.xml", x + 1, y + 1)
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

local function load_and_offset_door(file, x, y)
  local door = EntityLoad(file, x, y)
  local orientation = get_var_store_string(door, "orientation")
  if orientation == "h" then
    EntitySetTransform(door, x + 1, y)
  elseif orientation == "v" then
    EntitySetTransform(door, x, y + 1)
  end
end

function spawn_leverdoor_puzzle_door_01(x, y)
  load_and_offset_door("mods/AdventureMode/files/door_lever_labyrinth/laserdoor_01.xml", x, y)
end

function spawn_leverdoor_puzzle_door_02(x, y)
  load_and_offset_door("mods/AdventureMode/files/door_lever_labyrinth/laserdoor_02.xml", x, y)
end

function spawn_leverdoor_puzzle_door_03(x, y)
  load_and_offset_door("mods/AdventureMode/files/door_lever_labyrinth/laserdoor_03.xml", x, y)
end

function spawn_leverdoor_puzzle_door_04(x, y)
  load_and_offset_door("mods/AdventureMode/files/door_lever_labyrinth/laserdoor_04.xml", x, y)
end

function spawn_leverdoor_puzzle_door_05(x, y)
  load_and_offset_door("mods/AdventureMode/files/door_lever_labyrinth/laserdoor_05.xml", x, y)
end

function spawn_leverdoor_puzzle_door_06(x, y)
  load_and_offset_door("mods/AdventureMode/files/door_lever_labyrinth/laserdoor_06.xml", x, y)
end

function spawn_leverdoor_puzzle_door_07(x, y)
  load_and_offset_door("mods/AdventureMode/files/door_lever_labyrinth/laserdoor_07.xml", x, y)
end

function spawn_leverdoor_puzzle_door_08(x, y)
  load_and_offset_door("mods/AdventureMode/files/door_lever_labyrinth/laserdoor_08.xml", x, y)
end

function spawn_leverdoor_puzzle_door_09(x, y)
  load_and_offset_door("mods/AdventureMode/files/door_lever_labyrinth/laserdoor_09.xml", x, y)
end

function spawn_leverdoor_puzzle_door_10(x, y)
  load_and_offset_door("mods/AdventureMode/files/door_lever_labyrinth/laserdoor_10.xml", x, y)
end

function spawn_leverdoor_puzzle_door_11(x, y)
  load_and_offset_door("mods/AdventureMode/files/door_lever_labyrinth/laserdoor_11.xml", x, y)
end

function spawn_leverdoor_puzzle_door_12(x, y)
  load_and_offset_door("mods/AdventureMode/files/door_lever_labyrinth/laserdoor_12.xml", x, y)
end

function spawn_leverdoor_puzzle_door_13(x, y)
  load_and_offset_door("mods/AdventureMode/files/door_lever_labyrinth/laserdoor_13.xml", x, y)
end

function spawn_leverdoor_puzzle_door_14(x, y)
  load_and_offset_door("mods/AdventureMode/files/door_lever_labyrinth/laserdoor_14.xml", x, y)
end

function spawn_leverdoor_puzzle_door_15(x, y)
  load_and_offset_door("mods/AdventureMode/files/door_lever_labyrinth/laserdoor_15.xml", x, y)
end

function spawn_leverdoor_puzzle_door_16(x, y)
  load_and_offset_door("mods/AdventureMode/files/door_lever_labyrinth/laserdoor_16.xml", x, y)
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

function spawn_portal_activator_03(x, y)
  EntityLoad("mods/AdventureMode/files/warp_portals/03_activation_trigger.xml", x, y)
end

function spawn_warp_portal_03(x, y)
  EntityLoad("mods/AdventureMode/files/warp_portals/03_spawner.xml", x, y)
end

function spawn_warp_portal_03_target(x, y)
  EntityLoad("mods/AdventureMode/files/warp_portals/03_target_spawner.xml", x, y)
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
  EntityLoad("mods/AdventureMode/files/slabs/slab_gem_hand.xml", x + 60, y)
  EntityLoad("mods/AdventureMode/files/hand_holding_gem.xml", x, y)
end

function spawn_gem(x, y)
  EntityLoad("mods/AdventureMode/files/gem.xml", x, y)
end

function spawn_levitation_refresh_pickup(x, y)
  EntityLoad("mods/AdventureMode/files/levitation_refresh_pickup.xml", x, y)
end

function spawn_wall_corridor(x, y)
  EntityLoad("mods/AdventureMode/files/wall_corridor.xml", x, y)
end

function floating_box_spawner(x, y)
  EntityLoad("mods/AdventureMode/files/floating_box_spawner.xml", x, y)
end

function spawn_pickup_jetpack2(x, y)
  EntityLoad("mods/AdventureMode/files/pickups/jetpack2.xml", x, y - 10)
end

function spawn_wand_statue(x, y)
  EntityLoad("mods/AdventureMode/files/wand_statue.xml", x, y - 10)
  EntityLoad("mods/AdventureMode/files/pickups/wand_basic.xml", x + 3, y - 60)
end

function spawn_bullet(x, y)
  CreateItemActionEntity( "LIGHT_BULLET", x, y )
end

function shop_spell( x, y, card_id, cost, is_lava_stopper, is_stealable )
	-- this makes the shop items deterministic
	SetRandomSeed( x, y )

	local biomes =
	{
		[1] = 0,
		[2] = 0,
		[3] = 0,
		[4] = 1,
		[5] = 1,
		[6] = 1,
		[7] = 2,
		[8] = 2,
		[9] = 2,
		[10] = 2,
		[11] = 2,
		[12] = 2,
		[13] = 3,
		[14] = 3,
		[15] = 3,
		[16] = 3,
		[17] = 4,
		[18] = 4,
		[19] = 4,
		[20] = 4,
		[21] = 5,
		[22] = 5,
		[23] = 5,
		[24] = 5,
		[25] = 6,
		[26] = 6,
		[27] = 6,
		[28] = 6,
		[29] = 6,
		[30] = 6,
		[31] = 6,
		[32] = 6,
		[33] = 6,
	}


	local biomepixel = math.floor(y / 512)
	local biomeid = biomes[biomepixel] or 0
	
	if (biomepixel > 35) then
		biomeid = 7
	end

	if( is_stealable == nil ) then
		is_stealable = false
	end

	local item = ""
	local cardcost = cost

	-- Note( Petri ): Testing how much squaring the biomeid for prices affects things

	item = card_id

	local eid = CreateItemActionEntity( item, x, y )

	-- local x, y = EntityGetTransform( entity_id )
	-- SetRandomSeed( x, y )
	
	local offsetx = 6
	local text = tostring(cardcost)
	local textwidth = 0
	
	for i=1,#text do
		local l = string.sub( text, i, i )
		
		if ( l ~= "1" ) then
			textwidth = textwidth + 6
		else
			textwidth = textwidth + 3
		end
	end
	
	offsetx = textwidth * 0.5 - 0.5

	EntityAddComponent( eid, "SpriteComponent", { 
		_tags="shop_cost,enabled_in_world",
		image_file="data/fonts/font_pixel_white.xml", 
		is_text_sprite="1", 
		offset_x=tostring(offsetx), 
		offset_y="25", 
		update_transform="1" ,
		update_transform_rotation="0",
		text=tostring(cardcost),
		z_index="-1",
		} )

	local stealable_value = "0"
	
	EntityAddComponent( eid, "ItemCostComponent", { 
		_tags="shop_cost,enabled_in_world", 
		cost=cardcost,
		stealable=stealable_value
		} )
		
	EntityAddComponent( eid, "LuaComponent", { 
		script_item_picked_up="data/scripts/items/shop_effect.lua",
		} )
	if is_lava_stopper == 1 then
		EntityAddComponent( eid, "LuaComponent", { 
			script_item_picked_up="mods/AdventureMode/files/rising_lava/rocket_pickup.lua",
		} )
	end
end

function spawn_arrow(x, y)
  shop_spell( x, y, "BULLET", 60 )
end

function spawn_arrow_bullet(x, y)
  shop_spell( x, y, "DISC_BULLET", 90 )
end

function spawn_bullet_heavy(x, y)
  shop_spell( x, y, "CHAIN_BOLT", 150 )
end

function spawn_tesla_coil(x, y)
  EntityLoad("mods/AdventureMode/files/tesla_coil.xml", x, y - 10)
end

function spawn_zombies(x, y)
	for i=1,6 do
	  EntityLoad("mods/AdventureMode/files/zombie.xml", x, y)
	end
end

function spawn_monks(x, y)
  for i=1,3 do
    EntityLoad("mods/AdventureMode/files/monk.xml", x, y)
  end
end

function spawn_wand_boost(x, y)
  EntityLoad("mods/AdventureMode/files/pickups/wand_boost.xml", x, y - 10)
end

function spawn_phantoms(x, y)
  for i=1,3 do
    EntityLoad("mods/AdventureMode/files/phantom_a.xml", x, y)
  end
  for i=1,2 do
    EntityLoad("mods/AdventureMode/files/phantom_b.xml", x, y)
  end
end

function spawn_alchemists(x, y)
  for i=1,3 do
    EntityLoad("mods/AdventureMode/files/failed_alchemist.xml", x, y)
  end
  for i=1,2 do
    EntityLoad("mods/AdventureMode/files/failed_alchemist_b.xml", x, y)
  end
  EntityLoad("mods/AdventureMode/files/enlightened_alchemist.xml", x, y)
  for i=1,6 do
    EntityLoad("mods/AdventureMode/files/skullrat.xml", x, y)
  end
end

function spawn_breathless_perk(x, y)
  dofile_once("data/scripts/perks/perk.lua")
  perk_spawn( x, y, "BREATH_UNDERWATER" )	
end

function spawn_rising_lava_trigger(x, y)
  EntityLoad("mods/AdventureMode/files/rising_lava/rising_lava_trigger.xml", x, y)
end

function spawn_rocket(x, y)
  shop_spell( x, y, "ROCKET", 500, 1 )
end

function alligator_spawner(x, y)
  EntityLoad("mods/AdventureMode/files/alligator_spawner.xml", x, y)
end

function spawn_alligator1(x, y)
  -- EntityLoad("mods/AdventureMode/files/chaser.xml", x, y)
  GlobalsSetValue("AdventureMode_alligator_spawn_x", x)
  GlobalsSetValue("AdventureMode_alligator_spawn_y", y)
end

function spawn_alligator2(x, y)
  -- EntityLoad("mods/AdventureMode/files/chaser.xml", x, y)
  GlobalsSetValue("AdventureMode_alligator_spawn_x2", x)
  GlobalsSetValue("AdventureMode_alligator_spawn_y2", y)
end

function spawn_alligator_chase_stop_trigger(x, y)
  EntityLoad("mods/AdventureMode/files/alligator_chase_stop_trigger.xml", x, y)
end

function spawn_rebirth_door(x, y)
  EntityLoad("mods/AdventureMode/files/rebirth_door.xml", x, y)
end

function spawn_creep_skull(x, y)
  EntityLoad("mods/AdventureMode/files/creep_skull/creep_skull.xml", x, y)
end

function spawn_rebirth_trigger(x, y)
  EntityLoad("mods/AdventureMode/files/rebirth_trigger.xml", x, y)
end

function spawn_rebirth_finger(x, y)
  EntityLoad("mods/AdventureMode/files/rebirth_finger.xml", x, y)
end

function spawn_music_trigger_spike( x, y )
	EntityLoad( "mods/AdventureMode/files/music_trigger_spikes.xml", x, y )
end

-- Regex to comment out function body:
-- (function spawn_leverdoor_puzzle_lever_0\d\(x, y\))([\s\S\n\r]*?)(end)
-- $1--[[$2]]$3
-- (function spawn_leverdoor_puzzle_lever_0\d\(x, y\))(--\[\[)([\s\S\n\r]*?)(\]\])(end)
