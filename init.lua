-- ModMagicNumbersFileAdd("mods/AdventureMode/files/magic_numbers.xml")
dofile_once("mods/AdventureMode/lib/DialogSystem/init.lua")("mods/AdventureMode/lib/DialogSystem")
dofile_once("mods/AdventureMode/lib/coroutines.lua")
dofile_once("data/scripts/lib/utilities.lua")
dofile_once("mods/AdventureMode/files/util.lua")
local nxml = dofile_once("mods/AdventureMode/lib/nxml.lua")
local content = ModTextFileGetContent("data/biome/_biomes_all.xml")
local xml = nxml.parse(content)
xml:add_children(nxml.parse_many([[
<Biome
  biome_filename="mods/AdventureMode/files/biomes/desert.xml" 
  height_index="0"
  color="ffc1ab5b">
</Biome>
<Biome
  biome_filename="mods/AdventureMode/files/biomes/sand.xml" 
  height_index="0"
  color="ff877531">
</Biome>
]]))
ModTextFileSetContent("data/biome/_biomes_all.xml", tostring(xml))

local starting_positions = {
  { x = 150, y = -768 }, -- Intro
  { x = 715, y = -600 }, -- In front of Main door
  { x = 1173, y = -553 }, -- Lava room
  { x = 1341, y = -891 }, -- Electricity door room
  { x = 1412, y = -895 }, -- Pressure plate puzzle
}
local starting_position = 1
ModTextFileSetContent("mods/AdventureMode/_virtual/magic_numbers.xml", string.format([[
<MagicNumbers
  DESIGN_PLAYER_START_POS_X="%d"
  DESIGN_PLAYER_START_POS_Y="%d"
></MagicNumbers>
]], starting_positions[starting_position].x, starting_positions[starting_position].y))
-- DESIGN_PLAYER_START_POS_X="150"
-- DESIGN_PLAYER_START_POS_Y="-768"

-- DESIGN_PLAYER_START_POS_X="715"
-- DESIGN_PLAYER_START_POS_Y="-600"
ModMagicNumbersFileAdd("mods/AdventureMode/_virtual/magic_numbers.xml")

function OnPlayerSpawned(player)
  EntityLoad("mods/AdventureMode/files/intro.xml")
  local world_state_entity = GameGetWorldStateEntity()
  local world_state_component = EntityGetFirstComponentIncludingDisabled(world_state_entity, "WorldStateComponent")
  ComponentSetValue2(world_state_component, "intro_weather", true)
  ComponentSetValue2(world_state_component, "time", 1)
  ComponentSetValue2(world_state_component, "fog", 0)
  ComponentSetValue2(world_state_component, "fog_target", 0)
  ComponentSetValue2(world_state_component, "sky_sunset_alpha_target", 0.5)
  ComponentSetValue2(world_state_component, "gradient_sky_alpha_target", 0.5)

  -- Disable jetpack
  entity_set_component_value(player, "CharacterDataComponent", "fly_time_max", 0)
  entity_set_component_value(player, "CharacterDataComponent", "fly_recharge_spd", 0)
  entity_set_component_value(player, "CharacterDataComponent", "fly_recharge_spd_ground", 0.4)

  -- Make immortal
  entity_set_component_value(player, "DamageModelComponent", "wait_for_kill_flag_on_death", true)
  EntityAddComponent2(player, "LuaComponent", {
    script_source_file = "mods/AdventureMode/files/player_lethal_damage_watcher.lua",
    script_damage_received = "mods/AdventureMode/files/player_lethal_damage_watcher.lua",
    execute_every_n_frame=-1,
    execute_on_added=true,
    enable_coroutines=true,
  })

  -- Prepare Inventory
  local inventory_quick = EntityGetWithName("inventory_quick")
  local items = EntityGetAllChildren(inventory_quick) or {}
  for i, item in ipairs(items) do
    EntityKill(item)
  end
  local water_potion = EntityLoad("data/entities/items/pickup/potion_water.xml")
  AddMaterialInventoryMaterial(water_potion, "water", 300)
  GamePickUpInventoryItem(player, water_potion, false)
  -- EntityAddChild(inventory_quick, water_potion)
  -- EntityAddChild(inventory_quick)
  -- EntityKill(items[1])
  -- EntityKill(items[2])


  -- ComponentSetValue2(world_state_component, "", 2)
  -- camera_tracking_shot(260, -800, 260, -600, 0.01)
end

function OnWorldPreUpdate()
  -- local player = EntityGetWithTag("player_unit")[1]
  gui = gui or GuiCreate()
  GuiStartFrame(gui)
  if GuiButton(gui, 2, 0, 0, "boop") then
    BiomeMapLoad_KeepPlayer("data/biome_impl/biome_map.png")
  end

  -- Make sure arm doesn't hang weirdly without items
  local arm_r_entity = EntityGetWithName("arm_r")
  if arm_r_entity > 0 then
    local inventory_quick = EntityGetWithName("inventory_quick")
    local items = EntityGetAllChildren(inventory_quick)
    -- local players = EntityGetWithTag("player_unit")
    -- local player = players[1]
    -- -- local x, y, r, scale_x = EntityGetTransform(arm_r_entity)
    -- local x, y, r, scale_x = EntityGetTransform(player)
    
    -- EntitySetTransform(arm_r_entity, x, y, math.pi/2 - 0.3 * scale_x)
    local sprite_component = EntityGetFirstComponentIncludingDisabled(arm_r_entity, "SpriteComponent")
    EntitySetComponentIsEnabled(arm_r_entity, sprite_component, not not items)
  end
end

function OnWorldPostUpdate()
end
