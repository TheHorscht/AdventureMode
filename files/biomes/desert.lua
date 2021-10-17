RegisterSpawnFunction(0xffc626dc, "spawn_cactus")
RegisterSpawnFunction(0xffbba86b, "spawn_door")
RegisterSpawnFunction(0xffbba86c, "spawn_door2")
RegisterSpawnFunction(0xffbba86d, "spawn_door3")
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
      -- EntityAddComponent2(pressure_plates[v], "SpriteComponent", {
      --   image_file="data/fonts/font_pixel_white.xml",
      --   is_text_sprite=true,
      --   offset_x=7,
      --   offset_y=15,
      --   update_transform=true,
      --   update_transform_rotation=false,
      --   text=i,
      --   z_index=-1,
      -- })
    end
  end
end

local puzzle_torches_spawned = 0
function spawn_puzzle_torch(x, y)
  if puzzle_torches_spawned == 0 then
    EntityLoad("mods/AdventureMode/files/puzzle_torch_checker.xml", x, y)
  end
  puzzle_torches_spawned = puzzle_torches_spawned + 1
  EntityLoad("mods/AdventureMode/files/puzzle_torch.xml", x, y)
  if puzzle_torches_spawned == 5 then
    local torches = EntityGetWithTag("puzzle_torch")
    table.sort(torches, function(a, b)
      local xa = EntityGetTransform(a)
      local xb = EntityGetTransform(b)
      return xa < xb
    end)
    for i, v in ipairs(torches) do
      EntitySetName(v, "puzzle_torch_" .. i)
    end
  end
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
  EntityLoad("mods/AdventureMode/files/pile_of_bones.xml", x, y)
end

function spawn_spike_corridor(x, y)
  EntityLoad("mods/AdventureMode/files/spike_corridor.xml", x, y)
end
