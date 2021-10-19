dofile_once("mods/AdventureMode/lib/coroutines.lua")
dofile_once("mods/AdventureMode/files/util.lua")
dofile_once("data/scripts/lib/utilities.lua")

print("SHIIIIT")

-- GetUpdatedEntityID() INSIDE async when using multiple instances without
-- vm_type="ONE_PER_COMPONENT_INSTNACE always returns only the first entity_id of the first instance
local entity_id = GetUpdatedEntityID()
async(function()
  -- Need to wait one frame for the var store to get added
  wait(0)
  local order = get_var_store_int(entity_id, "order")
  local direction = get_var_store_int(entity_id, "direction")
  local delay = get_var_store_int(entity_id, "delay")
  local pause_in = get_var_store_int(entity_id, "pause_in")
  local pause_out = get_var_store_int(entity_id, "pause_out")
  wait(delay)
  while true do   
    for i=1, 10 do
      local x, y, r = EntityGetTransform(entity_id)
      EntitySetTransform(entity_id, x, y + 5 * direction)
      wait(0)
    end
    -- wait(50 + 30)
    wait(pause_in)
    for i=1, 10 do
      local x, y, r = EntityGetTransform(entity_id)
      EntitySetTransform(entity_id, x, y - 5 * direction)
      wait(0)
    end
    -- for i=1, 100 do
    --   local x, y, r = EntityGetTransform(entity_id)
    --   EntitySetTransform(entity_id, x, y - 0.5 * direction)
    --   wait(0)
    -- end
    -- wait(80)
    -- wait(50 + 30)
    wait(pause_out)
  end
end)
