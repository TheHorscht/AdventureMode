dofile_once("mods/AdventureMode/files/util.lua")

local entity_id = GetUpdatedEntityID()
local x, y = EntityGetTransform(entity_id)

local torch_positions = {}
-- Check if all torche places have been loaded yet so we know the locations we should spawn the torches in
for i=1, 5 do
  local pos_x = GlobalsGetValue("AdventureMode_puzzle_torch_pos_x_" .. i, "nil")
  if pos_x ~= "nil" then
    local pos_y = GlobalsGetValue("AdventureMode_puzzle_torch_pos_y_" .. i, "nil")
    table.insert(torch_positions, { x = pos_x, y = pos_y })
  end
end


-- This should only be true once execute_on_removed runs and we already spawned our torches
if torches then
  -- Kill the currently spawned torches, because we're out of range
  for i, torch in ipairs(torches) do
    EntityKill(torch)
  end
  torches = nil
elseif #torch_positions == 5 then
  -- We know all our torch positions, time to spawn them
  -- Sort them from left to right, so the leftmost torch will be our #1
  table.sort(torch_positions, function(a, b)
    return a.x < b.x
  end)
  torches = {}
  for i, pos in ipairs(torch_positions) do
    local torch = EntityLoad("mods/AdventureMode/files/puzzle_torch.xml", torch_positions[i].x, torch_positions[i].y)
    set_var_store_int(torch, "order", i)
    table.insert(torches, torch)
  end
  -- Stop checking for torch places, once the CameraBoundComponent kicks in and respawns this entity,
  -- the LuaComponent will get reloaded with its default values
  entity_set_component_value(entity_id, "LuaComponent", "execute_every_n_frame", -1)
end
