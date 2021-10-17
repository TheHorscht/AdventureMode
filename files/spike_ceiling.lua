dofile_once("mods/AdventureMode/lib/coroutines.lua")
dofile_once("data/scripts/lib/utilities.lua")

-- GetUpdatedEntityID() INSIDE async when using multiple instances without
-- vm_type="ONE_PER_COMPONENT_INSTNACE always returns only the first entity_id of the first instance
local entity_id = GetUpdatedEntityID()
local delay_between_spikes = {
  0, 5, 10, 60, 65, 70
  -- 0, 0, 0, 60, 60, 60
}
async(function()
  -- Need to wait one frame for the var store to get added
  wait(0)
  local var_store_order = get_variable_storage_component(entity_id, "order")
  local order = ComponentGetValue2(var_store_order, "value_int")
  local var_store_direction = get_variable_storage_component(entity_id, "direction")
  local direction = ComponentGetValue2(var_store_direction, "value_int")
  wait(delay_between_spikes[order])--order * 20)
  while true do   
    for i=1, 10 do
      local x, y, r = EntityGetTransform(entity_id)
      EntitySetTransform(entity_id, x, y + 5 * direction)
      wait(0)
    end
    wait(50 + 30)
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
    wait(50 + 30)
  end
end)
