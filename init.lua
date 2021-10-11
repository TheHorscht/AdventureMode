-- ModMagicNumbersFileAdd("mods/AdventureMode/files/magic_numbers.xml")
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

ModTextFileSetContent("mods/AdventureMode/_virtual/magic_numbers.xml", string.format([[
<MagicNumbers
  DESIGN_PLAYER_START_POS_X="%d"
  DESIGN_PLAYER_START_POS_Y="%d"
></MagicNumbers>
]],715,-600))
-- DESIGN_PLAYER_START_POS_X="150"
-- DESIGN_PLAYER_START_POS_Y="-768"

-- DESIGN_PLAYER_START_POS_X="715"
-- DESIGN_PLAYER_START_POS_Y="-600"
ModMagicNumbersFileAdd("mods/AdventureMode/_virtual/magic_numbers.xml")

function OnPlayerSpawned(player)
  -- EntityLoad("mods/AdventureMode/files/intro.xml")
  local world_state_entity = GameGetWorldStateEntity()
  local world_state_component = EntityGetFirstComponentIncludingDisabled(world_state_entity, "WorldStateComponent")
  ComponentSetValue2(world_state_component, "intro_weather", true)
  ComponentSetValue2(world_state_component, "time", 1)
  ComponentSetValue2(world_state_component, "fog", 0)
  ComponentSetValue2(world_state_component, "fog_target", 0)
  ComponentSetValue2(world_state_component, "sky_sunset_alpha_target", 0.5)
  ComponentSetValue2(world_state_component, "gradient_sky_alpha_target", 0.5)
  -- ComponentSetValue2(world_state_component, "", 2)
  -- camera_tracking_shot(260, -800, 260, -600, 0.01)
end

function OnWorldPreUpdate()
  -- local player = EntityGetWithTag("player_unit")[1]
end

function OnWorldPostUpdate()

end
