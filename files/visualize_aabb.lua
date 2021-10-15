local entity_id = GetUpdatedEntityID()
local material_area_checker_component = EntityGetFirstComponentIncludingDisabled(entity_id, "MaterialAreaCheckerComponent")
local aabb = {}
local a, b, c, d = ComponentGetValue2(material_area_checker_component, "area_aabb")
aabb.min_x = a
aabb.min_y = b
aabb.max_x = c
aabb.max_y = d
local width = aabb.max_x - aabb.min_x
local height = aabb.max_y - aabb.min_y
local scale_x = width / 10
local scale_y = height / 10
EntityAddComponent2(entity_id, "SpriteComponent", {
  image_file="mods/AdventureMode/files/box_10x10.png",
  special_scale_x=scale_x,
  special_scale_y=scale_y,
  offset_x=-aabb.min_x / scale_x,
  offset_y=-aabb.min_y / scale_y,
  has_special_scale=true,
  alpha=0.5,
  z_index=-99,
  smooth_filtering=true,
})
