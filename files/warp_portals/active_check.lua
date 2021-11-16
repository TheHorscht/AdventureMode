dofile_once("mods/AdventureMode/files/util.lua")

local entity_id = GetUpdatedEntityID()
local x, y = EntityGetTransform(entity_id)

local portal_id = get_var_store_int(entity_id, "portal_id")
if portal_id then
  local id_string = string.format("%.2d", portal_id)
  -- AdventureMode_portal_unlocked_01
  local is_active = GlobalsGetValue("AdventureMode_portal_unlocked_" .. id_string, "0") == "1"
  if is_active then
    EntityLoad("mods/AdventureMode/files/warp_portals/portal_" .. id_string .. ".xml", x, y)
    EntityKill(entity_id)
  end
end
-- print("warp_portal.lua running")
