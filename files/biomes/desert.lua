RegisterSpawnFunction(0xffc626dc, "spawn_cactus")
RegisterSpawnFunction(0xffbba86b, "spawn_door")
RegisterSpawnFunction(0xffbba86c, "spawn_door2")
RegisterSpawnFunction(0xff7f56cf, "spawn_liquid_checker")
RegisterSpawnFunction(0xffffff1b, "spawn_pickup_jetpack")
RegisterSpawnFunction(0xff32d6e7, "spawn_electricity_trap")
RegisterSpawnFunction(0xff37aab6, "spawn_pressure_plate")
RegisterSpawnFunction(0xff784249, "spawn_flamethrower_turret")
RegisterSpawnFunction(0xffec2b42, "spawn_chain_torch")

local i = 0
function spawn_cactus(x, y)
  i = (i % 4) + 1
  EntityLoad("mods/AdventureMode/files/props/cactus"..i..".xml", x, y)
end

function spawn_door(x, y)
  -- EntityLoad("mods/AdventureMode/files/door.xml", x, y + 1)
end

function spawn_door2(x, y)
  EntityLoad("mods/AdventureMode/files/door2.xml", x, y)
end

function spawn_liquid_checker(x, y)
  EntityLoad("mods/AdventureMode/files/liquid_checker.xml", x, y)
  EntityLoad("mods/AdventureMode/files/platform.xml", x + 70, y - 10)
  EntityLoad("mods/AdventureMode/files/platform.xml", x + 70, y - 20)
  EntityLoad("mods/AdventureMode/files/platform.xml", x + 70, y - 30)
  EntityLoad("mods/AdventureMode/files/platform.xml", x + 70, y - 40)
  EntityLoad("mods/AdventureMode/files/platform.xml", x + 70, y - 50)
  EntityLoad("mods/AdventureMode/files/platform.xml", x + 70, y - 60)
end

function spawn_pickup_jetpack(x, y)
  EntityLoad("mods/AdventureMode/files/pickups/jetpack.xml", x, y - 10)
end

function spawn_electricity_trap(x, y)
  EntityLoad("data/entities/props/physics/trap_electricity_enabled.xml", x, y)
end

function spawn_pressure_plate(x, y)
  EntityLoad("mods/AdventureMode/files/pressure_plate.xml", x, y)
end

function spawn_flamethrower_turret(x, y)
  EntityLoad("mods/AdventureMode/files/flamethrower.xml", x, y)
end

function spawn_chain_torch(x, y)
  EntityLoad("data/entities/props/physics/chain_torch.xml", x, y)
  -- data/entities/props/physics_chain_torch.xml
end

