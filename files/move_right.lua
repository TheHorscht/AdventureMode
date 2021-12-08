dofile_once("mods/AdventureMode/lib/coroutines.lua")
dofile_once("mods/AdventureMode/files/util.lua")
dofile_once("mods/AdventureMode/files/camera.lua")
dofile_once("data/scripts/lib/utilities.lua")

local entity_id = GetUpdatedEntityID()
local x, y = EntityGetTransform(entity_id)
local character_data_component = EntityGetFirstComponentIncludingDisabled(entity_id, "CharacterDataComponent")
ComponentSetValue2(character_data_component, "mVelocity", 35, 0)
ComponentSetValue2(character_data_component, "is_on_ground", true)

local controls_component = EntityGetFirstComponentIncludingDisabled(entity_id, "ControlsComponent")
ComponentSetValue2(controls_component, "mAimingVector", 1, 0)
ComponentSetValue2(controls_component, "mAimingVectorNormalized", 5000, 0)
ComponentSetValue2(controls_component, "mAimingVectorNonZeroLatest", 5000, 0)
ComponentSetValue2(controls_component, "mMousePosition", 5000, 0)


local number = GetValueNumber("number", 0)
SetValueNumber("number", number + 1)

if number == 2 then
	EntityLoad("mods/AdventureMode/files/camera_fixer.xml")
	LoadGameEffectEntityTo( entity_id, "data/entities/misc/effect_remove_fog_of_war.xml" )
	LoadBackgroundSprite( "mods/AdventureMode/files/noita_background.png", x - 256, y - 300, 100, false )
	-- local background = EntityCreateNew()
	-- EntitySetTransform(background, x, y)
	-- EntityAddComponent2(background, "SpriteComponent", {
		-- image_file="mods/AdventureMode/files/noita_background.png",
		-- offset_x=256,
		-- offset_y=256
	-- } )
end