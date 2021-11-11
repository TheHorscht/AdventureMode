dofile_once("mods/AdventureMode/files/util.lua")

local entity_id = GetUpdatedEntityID()
local x, y = EntityGetTransform(entity_id)

local color = get_var_store_string(entity_id, "color", "")
local default_state = get_var_store_int(entity_id, "default_state", 1)
local active_state = tonumber(GlobalsGetValue("AdventureMode_leverdoor_puzzle_color_" .. color, "0"))
local comp = EntityGetFirstComponentIncludingDisabled(entity_id, "LaserEmitterComponent")
EntitySetComponentIsEnabled(entity_id, comp, active_state ~= default_state)
