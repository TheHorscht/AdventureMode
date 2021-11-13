function item_pickup(entity_item, entity_pickupper, item_name)
  GamePrint("PICKED UP FUCKKKKK")  
  EntityKill(entity_item)
  local x, y = EntityGetTransform(entity_pickupper)
  local gem = EntityLoad("mods/AdventureMode/files/gem_item.xml", x, y)
  GamePickUpInventoryItem(entity_pickupper, gem, true)
end
