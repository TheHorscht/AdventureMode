dofile_once("mods/AdventureMode/files/util.lua")

local entity_id = GetUpdatedEntityID()
local x, y = EntityGetTransform(entity_id)
local padding = 25
local amount = 10

levers = levers or {}

if #levers > 0 then
  for i, lever_entity_id in ipairs(levers) do
    EntityKill(lever_entity_id)
  end
  levers = {}
else
  for i=1, amount do
    local lever = EntityLoad("mods/AdventureMode/files/lever.xml", x - (amount/2 - (i-1)) * padding, y)
    table.insert(levers, lever)
    set_var_store_string(lever, "global_variable", "AdventureMode_lever_puzzle_lever_" .. i)
    EntityAddComponent2(lever, "LuaComponent", {
      _enabled = false,
      _tags = "enable_on_lever_changed",
      script_source_file = "mods/AdventureMode/files/lever_puzzle_lever_changed.lua",
      execute_on_added = true,
    })
  end
end
