-- ModMagicNumbersFileAdd("mods/AdventureMode/files/magic_numbers.xml")
ModLuaFileAppend("data/scripts/status_effects/status_list.lua", "mods/AdventureMode/files/status_list_append.lua")
ModMaterialsFileAdd("mods/AdventureMode/files/materials.xml")
ModRegisterAudioEventMappings("mods/AdventureMode/files/audio/GUIDs.txt")
dofile_once("mods/AdventureMode/lib/DialogSystem/init.lua")("mods/AdventureMode/lib/DialogSystem", {
  disable_controls = true,
  sounds = {
    bones = { bank = "mods/AdventureMode/files/audio/AdventureMode.bank", event = "bones_rattle" },
    stone = { bank = "mods/AdventureMode/files/audio/AdventureMode.bank", event = "golem_speak" },
  }
})
dofile_once("mods/AdventureMode/lib/coroutines.lua")
dofile_once("data/scripts/lib/utilities.lua")
dofile_once("mods/AdventureMode/files/util.lua")
local nxml = dofile_once("mods/AdventureMode/lib/nxml.lua")

-- Overwrite death sound to disable it
GamePlaySound("mods/AdventureMode/files/audio/death.bank", "dummy_sound", 0, 0)

--set collapsed concrete strength
local content = ModTextFileGetContent("data/materials.xml")
local xml = nxml.parse(content)
for element in xml:each_child() do
  if element.attr.name == "concrete_collapsed" then
    element.attr.durability = 5000
  end
end
ModTextFileSetContent("data/materials.xml", tostring(xml))

--add custom materials
ModMaterialsFileAdd("mods/AdventureMode/files/materials/materials.xml")

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
<Biome
  biome_filename="mods/AdventureMode/files/biomes/golem_room.xml" 
  height_index="0"
  color="ff986b4f">
</Biome>
]]))
ModTextFileSetContent("data/biome/_biomes_all.xml", tostring(xml))

local starting_positions = {
  { x = 150, y = -768 }, -- 1 Intro
  { x = 715, y = -600 }, -- 2 In front of Main door
  { x = 1057, y = -553 }, -- 3 Tablet
  { x = 1173, y = -553 }, -- 4 Lava room
  { x = 1341, y = -891 }, -- 5 Electricity door room
  { x = 1412, y = -895 }, -- 6 Pressure plate puzzle
  { x = 1722, y = -910 }, -- 7 Spike corridor
  { x = 2450, y = -910 }, -- 8 Golem
  { x = 2138, y = -844 }, -- 9 After spike corridor
  { x = 1290, y = -285 }, -- 10 Lever puzzle
  { x = 2203, y = -910 }, -- 11 Brazier
  { x = 2735, y = -625 }, -- 12 Teleporter room
  { x = 3054, y = -870 }, -- 13 Water
  { x = 4444, y = -103 }, -- 14 Lever puzzle
  { x = 3460, y = -1179}, -- 15 Golem
  { x = 3817, y = -1171 }, -- 16 Hand with gem
  { x = 4400, y = -1020 }, -- 17 Lever door maze
  { x = 5560, y = -668 }, -- 18 Wand Mistress
  { x = 3874, y = -864 }, -- 19 Water area, alligator testing
  { x = 5669, y = 412 }, -- 20 Rebirth Room
  { x = 3814, y = -1000 }, -- 21 Gate Opener Puzzle
  { x = 6055, y = -893 }, -- 22 Poison Challenge
  { x = 2747, y = -1514 }, -- 23 rising lava Challenge
}
local starting_position = 1

ModTextFileSetContent("mods/AdventureMode/_virtual/magic_numbers.xml", string.format([[
<MagicNumbers
  DESIGN_PLAYER_START_POS_X="%d"
  DESIGN_PLAYER_START_POS_Y="%d"
  ></MagicNumbers>
  ]], starting_positions[starting_position].x, starting_positions[starting_position].y))
  
  -- DEBUG_MATERIAL_AREA_CHECKER="1"
  -- DEBUG_COLLISION_TRIGGERS="1"
ModMagicNumbersFileAdd("mods/AdventureMode/_virtual/magic_numbers.xml")

-- ModLuaFileAppend("data/scripts/gun/gun_actions.lua", "mods/AdventureMode/files/gun_actions_append.lua")

function OnPlayerSpawned(player)

  local x, y = EntityGetTransform(player)
  
  if starting_position == 23 then
	EntityLoad("mods/AdventureMode/files/pickups/jetpack2.xml", x, y)
  end

  EntitySetDamageFromMaterial( player, "poison_permanent", 0.01 )
  
  GlobalsSetValue("AdventureMode_DEBUG_starting_position", starting_position)
  
  if GlobalsGetValue("AdventureMode_player_initialized", "0") == "0" then
    GlobalsSetValue("AdventureMode_player_initialized", "1")
    if starting_position == 1 then
      EntityLoad("mods/AdventureMode/files/intro.xml")
    else
      GlobalsSetValue("AdventureMode_respawn_x", starting_positions[starting_position].x)
      GlobalsSetValue("AdventureMode_respawn_y", starting_positions[starting_position].y)
	  
	  local world_state = GameGetWorldStateEntity()
	  EntityAddComponent(world_state, "LuaComponent", {
		  script_source_file="mods/AdventureMode/files/music_player.lua",
		  execute_every_n_frame=1,
		  execute_on_added=1
	  })
	  
    end
    local world_state_entity = GameGetWorldStateEntity()
    local world_state_component = EntityGetFirstComponentIncludingDisabled(world_state_entity, "WorldStateComponent")
    ComponentSetValue2(world_state_component, "intro_weather", true)
    ComponentSetValue2(world_state_component, "time", 1)
    ComponentSetValue2(world_state_component, "fog", 0)
    ComponentSetValue2(world_state_component, "fog_target", 0)
    ComponentSetValue2(world_state_component, "sky_sunset_alpha_target", 0.5)
    ComponentSetValue2(world_state_component, "gradient_sky_alpha_target", 0.5)
  
    -- Remove crown etc
    local sprite_tags = {
      "player_hat2",
      "player_hat2_shadow",
      "player_hat",
      "player_amulet_gem",
      "player_amulet",
      "lukki_enable",
    }
    for i, tag in ipairs(sprite_tags) do
      local comp = EntityGetFirstComponentIncludingDisabled(player, "SpriteComponent", tag)
      EntityRemoveComponent(player, comp)
    end

    -- Disable jetpack
    if starting_position > 1 then
      entity_set_component_value(player, "CharacterDataComponent", "fly_time_max", 1)
    else
      entity_set_component_value(player, "CharacterDataComponent", "fly_time_max", 0)
    end
    entity_set_component_value(player, "CharacterDataComponent", "fly_recharge_spd", 0.2)
    entity_set_component_value(player, "CharacterDataComponent", "fly_recharge_spd_ground", 1.0)
  
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
    EntityAddChild(inventory_quick, water_potion)
    -- GamePickUpInventoryItem(player, water_potion, false)
  
    -- Add no-item-arm
    EntityAddComponent2(player, "SpriteComponent", {
      _tags="right_arm_root,character",
      image_file="data/enemies_gfx/player_arm_no_item.xml",
      z_index=0.59
    })
    -- local torch = EntityLoad("mods/AdventureMode/files/torch.xml")
    -- GamePickUpInventoryItem(player, torch, false)
  
  
    -- EntityAddChild(inventory_quick, water_potion)
    -- EntityAddChild(inventory_quick)
    -- EntityKill(items[1])
    -- EntityKill(items[2])
  
  
    -- ComponentSetValue2(world_state_component, "", 2)
    -- camera_tracking_shot(260, -800, 260, -600, 0.01)
  end
end

function handle_arm_sprite()
  local respawn_in_progress = GlobalsGetValue("AdventureMode_respawn_in_progress", "0") == "1"
  local arm_r_entity = EntityGetWithName("arm_r")
  if not respawn_in_progress and arm_r_entity > 0 then
    local inventory_quick = EntityGetWithName("inventory_quick")
    local items = EntityGetAllChildren(inventory_quick)
    local sprite_component = EntityGetFirstComponentIncludingDisabled(arm_r_entity, "SpriteComponent")
    local active_item = get_active_item()
    -- Check if active item still exists, if EntityGetTransform returns nil then it doesn't
    local x = EntityGetTransform(active_item)
    local active_item_exists = x ~= nil
    local show_arm = not items or not active_item_exists
    local player = EntityGetWithTag("player_unit")[1]
    local no_item_arm_sprite_component = EntityGetFirstComponentIncludingDisabled(player, "SpriteComponent", "right_arm_root")
    ComponentSetValue2(no_item_arm_sprite_component, "alpha", show_arm and 1 or 0)
    EntitySetComponentIsEnabled(arm_r_entity, sprite_component, not show_arm)
  end
end

local debug_menu_open = false

function OnWorldPreUpdate()
  dofile("mods/AdventureMode/files/heatstroke_watcher.lua")
  local id = 2
  local function new_id()
    id = id + 1
    return id
  end
  gui = gui or GuiCreate()
  GuiStartFrame(gui)

  -- if GuiButton(gui, new_id(), 2, 200, "D") then
  --   debug_menu_open = not debug_menu_open
  -- end

  if debug_menu_open then
    GuiLayoutBeginVertical(gui, 1, 20)
    local inventory_quick = EntityGetWithName("inventory_quick")
    local player = EntityGetWithTag("player_unit")[1]
    if GuiButton(gui, new_id(), 0, 0, "Give torch") then
      local item = EntityLoad("mods/AdventureMode/files/torch.xml")
      GamePickUpInventoryItem(player, item, false)
    end
    if GuiButton(gui, new_id(), 0, 0, "Give rock") then
      local item = EntityLoad("data/entities/items/pickup/physics_gold_orb_greed.xml")
      GamePickUpInventoryItem(player, item, false)
    end
    if GuiButton(gui, new_id(), 0, 0, "Give gem") then
      local item = EntityLoad("mods/AdventureMode/files/gem_item.xml")
      GamePickUpInventoryItem(player, item, false)
    end
    if GuiButton(gui, new_id(), 0, 0, "Die") then
      local player = EntityGetWithTag("player_unit")[1]
      EntityInflictDamage(player, 999, "DAMAGE_MELEE", "", "NORMAL", 0, 0)
    end
    if GuiButton(gui, new_id(), 0, 0, "Ending teleport") then
      dofile_once("mods/AdventureMode/files/ending_portal.lua")
      local player = EntityGetWithTag("player_unit")[1]
      if player then
        do_teleport(player)
      end
    end
    if GuiButton(gui, new_id(), 0, 0, "Reload world") then
      BiomeMapLoad_KeepPlayer("data/biome_impl/biome_map.png")
    end
    if GuiButton(gui, new_id(), 0, 0, "Spawn brazier") then
      local player = EntityGetWithTag("player_unit")[1]
      if player then
        local x, y = EntityGetTransform(player)
        EntityLoad("mods/AdventureMode/files/brazier.xml", x, y)
      end
    end
    if GuiButton(gui, new_id(), 0, 0, "Bones rattling") then
      GamePlaySound("mods/AdventureMode/files/audio/AdventureMode.bank", "bones_rattle", 0, 0)
    end
    if GuiButton(gui, new_id(), 0, 0, "Rattle me bones!") then
      GamePlaySound("mods/AdventureMode/files/audio/AdventureMode.bank", "rattle_me_bones", 0, 0)
    end
    if not old_pos then
      if GuiButton(gui, new_id(), 0, 0, "Teleport far away") then
        local player = EntityGetWithTag("player_unit")[1]
        local x, y = EntityGetTransform(player)
        
        EntitySetTransform(player, x - 100000, y - 100000)
        old_pos = { x = x, y = y }
      end
    else
      if GuiButton(gui, new_id(), 0, 0, "Teleport back") then
        local player = EntityGetWithTag("player_unit")[1]
        EntitySetTransform(player, old_pos.x, old_pos.y)
        old_pos = nil
      end
    end
    GuiLayoutEnd(gui)
  end

  local number = #EntityGetWithTag("test")
  local number_last_frame = tonumber(GlobalsGetValue("number", "0"))
  if number ~= number_last_frame then
    print(("========== CHANGED from (%d) to (%d) =========="):format(number_last_frame, number))
    GamePrint("CHANGED")
    GlobalsSetValue("number", number)
  end

  -- Make sure arm doesn't hang weirdly without items
  handle_arm_sprite()
end
