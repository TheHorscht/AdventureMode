dofile_once("mods/AdventureMode/lib/coroutines.lua")
dofile_once("mods/AdventureMode/files/util.lua")
dofile_once("data/scripts/lib/utilities.lua")

-- print("RUNNING ASYNC TEST")

-- local entity_id = GetUpdatedEntityID()
-- local i = GetValueInteger("i", 0)
-- i = i + 1
-- SetValueInteger("i", i)
-- print(("entity_id(%d), %d"):format(entity_id, i))
local entity_id = GetUpdatedEntityID()
function get_state()
  _state = _state or {}
  _state[entity_id] = _state[entity_id] or {}
  print("Getting state for " .. entity_id)
  return _state[entity_id]
end
local state = get_state()
local i = 0
-- This should exist when the entity gets frozen, in that case, kill the old async script
if state.async then
  print("ASYNC REMOVED")
  state.async.stop()
else
  print("ASYNC ADDED")
  state.async = async(function()
    while true do
      i = i + 1
      local entity_id2 = GetUpdatedEntityID() -- Will return the "main" entity only
      local x, y, r = EntityGetTransform(entity_id)
      EntitySetTransform(entity_id, x, y, r + 0.01745329251994329576923690768489)
      print(("entity_id(%d), i(%d) "):format(entity_id, i))
      wait(60)
    end
  end)
end
