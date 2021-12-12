dofile_once("mods/AdventureMode/files/util.lua")

function item_pickup(entity_item, entity_pickupper, item_name)
  GlobalsSetValue("AdventureMode_poison_challenge_beaten", "1")
  entity_set_component_value(entity_pickupper, "CharacterDataComponent", "fly_time_max", 2)
  entity_set_component_value(entity_pickupper, "CharacterDataComponent", "fly_recharge_spd", 0.4)
  entity_set_component_value(entity_pickupper, "CharacterDataComponent", "fly_recharge_spd_ground", 3.0)
  GamePrintImportant(item_name, "You gained " .. item_name)
  local x, y = EntityGetTransform(entity_pickupper)
  EntityKill(entity_item)
end
