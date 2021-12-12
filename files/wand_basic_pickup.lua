dofile_once("mods/AdventureMode/files/util.lua")

function item_pickup(entity_item, entity_pickupper, item_name)
  -- GlobalsSetValue("AdventureMode_portal_unlocked_03", "1")
  -- GamePrintImportant(item_name, "You gained the ")
  local x, y = EntityGetTransform(entity_pickupper)
  LoadGameEffectEntityTo( entity_pickupper, "mods/AdventureMode/files/effect_edit_wands_everywhere.xml" )
  GlobalsSetValue("AdventureMode_respawn_x", x)
  GlobalsSetValue("AdventureMode_respawn_y", y)
end
