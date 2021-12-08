dofile_once("mods/AdventureMode/lib/coroutines.lua")
dofile_once("mods/AdventureMode/files/util.lua")
dofile_once("data/scripts/lib/utilities.lua")

local entity_id = GetUpdatedEntityID()
function get_state()
  _state = _state or {}
  _state[entity_id] = _state[entity_id] or {}
  return _state[entity_id]
end
local state = get_state()


if state.async then
  -- print("ASYNC REMOVED")
  state.async.stop()
else
  state.async = async(function()
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
        GamePlaySound("mods/AdventureMode/files/audio/AdventureMode.bank", "spike_trap", x, y)
        wait(0)
      end
      wait(pause_in)
      for i=1, 10 do
        local x, y, r = EntityGetTransform(entity_id)
        EntitySetTransform(entity_id, x, y - 5 * direction)
        wait(0)
      end
      wait(pause_out)
    end
  end)
end
