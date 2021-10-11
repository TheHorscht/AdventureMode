RegisterSpawnFunction(0xffc626dc, "spawn_cactus")
RegisterSpawnFunction(0xffbba86b, "spawn_door")

local i = 0
function spawn_cactus(x, y)
  i = (i % 4) + 1
  EntityLoad("mods/AdventureMode/files/props/cactus"..i..".xml", x, y)
end

function spawn_door(x, y)
  EntityLoad("mods/AdventureMode/files/door.xml", x, y + 1)
end
