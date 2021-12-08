local entity_id = GetUpdatedEntityID()
local x, y = EntityGetTransform(entity_id)
local item_comp = EntityGetFirstComponentIncludingDisabled(entity_id, "ItemComponent")
local next_frame_pickable = ComponentGetValue2(item_comp, "next_frame_pickable")
if next_frame_pickable <= GameGetFrameNum() then
  local sprite_comp = EntityGetFirstComponentIncludingDisabled(entity_id, "SpriteComponent")
  EntitySetComponentIsEnabled(entity_id, sprite_comp, true)
end

function item_pickup(entity_item, entity_pickupper, item_name)
  -- EntityKill(entity_item)
  local x, y = EntityGetTransform(entity_item)
  local character_data_component = EntityGetFirstComponentIncludingDisabled(entity_pickupper, "CharacterDataComponent")
  ComponentSetValue2(character_data_component, "mFlyingTimeLeft", 1000)
  local pickup = EntityLoad("mods/AdventureMode/files/levitation_refresh_pickup.xml", x, y)
  local item_comp = EntityGetFirstComponentIncludingDisabled(pickup, "ItemComponent")
  local sprite_comp = EntityGetFirstComponentIncludingDisabled(pickup, "SpriteComponent")
  ComponentSetValue2(item_comp, "next_frame_pickable", GameGetFrameNum() + 300)
  EntitySetComponentIsEnabled(pickup, sprite_comp, false)
  -- EntityAddComponent2(pickup, "next_frame_pickable")
  EntityKill(entity_item)
end
