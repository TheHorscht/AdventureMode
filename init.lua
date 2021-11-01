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
<Biome
  biome_filename="mods/AdventureMode/files/biomes/dark.xml" 
  height_index="0"
  color="ff282620">
</Biome>
<Biome
  biome_filename="mods/AdventureMode/files/biomes/pyramid.xml" 
  height_index="0"
  color="ffec2b42">
</Biome>
]]))
ModTextFileSetContent("data/biome/_biomes_all.xml", tostring(xml))

local starting_positions = {
  { x = 150, y = -768 }, -- Intro
  { x = 715, y = -600 }, -- In front of Main door
  { x = 1173, y = -553 }, -- Lava room
  { x = 1341, y = -891 }, -- Electricity door room
  { x = 1412, y = -895 }, -- Pressure plate puzzle
  { x = 1722, y = -910 }, -- Spike corridor
  { x = 2450, y = -910 }, -- Golem
  { x = 2138, y = -844 }, -- After spike corridor
  { x = 1565, y = -285 }, -- Lever puzzle
  { x = 2203, y = -910 }, -- Brazier
  { x = 2253, y = -707 }, -- Above chase
}
local starting_position = 11
ModTextFileSetContent("mods/AdventureMode/_virtual/magic_numbers.xml", string.format([[
<MagicNumbers
  DESIGN_PLAYER_START_POS_X="%d"
  DESIGN_PLAYER_START_POS_Y="%d"
></MagicNumbers>
]], starting_positions[starting_position].x, starting_positions[starting_position].y))

ModMagicNumbersFileAdd("mods/AdventureMode/_virtual/magic_numbers.xml")

-- ModLuaFileAppend("data/scripts/gun/gun_actions.lua", "mods/AdventureMode/files/gun_actions_append.lua")

function OnPlayerSpawned(player)
  if starting_position == 1 then
    EntityLoad("mods/AdventureMode/files/intro.xml")
  end
  local world_state_entity = GameGetWorldStateEntity()
  local world_state_component = EntityGetFirstComponentIncludingDisabled(world_state_entity, "WorldStateComponent")
  ComponentSetValue2(world_state_component, "intro_weather", true)
  ComponentSetValue2(world_state_component, "time", 1)
  ComponentSetValue2(world_state_component, "fog", 0)
  ComponentSetValue2(world_state_component, "fog_target", 0)
  ComponentSetValue2(world_state_component, "sky_sunset_alpha_target", 0.5)
  ComponentSetValue2(world_state_component, "gradient_sky_alpha_target", 0.5)

  -- Disable jetpack
  -- entity_set_component_value(player, "CharacterDataComponent", "fly_time_max", 0)
  entity_set_component_value(player, "CharacterDataComponent", "fly_time_max", 1)
  entity_set_component_value(player, "CharacterDataComponent", "fly_recharge_spd", 0.4)
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

  -- local torch = EntityLoad("mods/AdventureMode/files/torch.xml")
  -- GamePickUpInventoryItem(player, torch, false)


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
  GuiLayoutBeginVertical(gui, 0, 20)
  if GuiButton(gui, 2, 0, 0, "Give torch") then
    local inventory_quick = EntityGetWithName("inventory_quick")
    local torch = EntityLoad("mods/AdventureMode/files/torch.xml")
    local player = EntityGetWithTag("player_unit")[1]
    GamePickUpInventoryItem(player, torch, false)
  end
  if GuiButton(gui, 3, 0, 0, "Die") then
    local player = EntityGetWithTag("player_unit")[1]
    EntityInflictDamage(player, 999, "DAMAGE_MELEE", "", "NORMAL", 0, 0)
  end
  if not old_pos then
    if GuiButton(gui, 4, 0, 0, "Teleport far away") then
      local player = EntityGetWithTag("player_unit")[1]
      local x, y = EntityGetTransform(player)
      
      EntitySetTransform(player, x - 50000, y - 50000)
      old_pos = { x = x, y = y }
    end
  else
    if GuiButton(gui, 4, 0, 0, "Teleport back") then
      local player = EntityGetWithTag("player_unit")[1]
      EntitySetTransform(player, old_pos.x, old_pos.y)
      old_pos = nil
    end
  end
  GuiLayoutEnd(gui)

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
