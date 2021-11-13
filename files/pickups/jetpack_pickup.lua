dofile_once("mods/AdventureMode/files/util.lua")

function item_pickup(entity_item, entity_pickupper, item_name)
  entity_set_component_value(entity_pickupper, "CharacterDataComponent", "fly_time_max", 1)
  GamePrintImportant(item_name, "You gained the " .. item_name)
  local x, y = EntityGetTransform(entity_pickupper)
  GlobalsSetValue("AdventureMode_respawn_x", x)
  GlobalsSetValue("AdventureMode_respawn_y", y)
  EntityKill(entity_item)
end
