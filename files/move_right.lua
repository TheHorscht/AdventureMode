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
	
	local general_z_index = 100

	--BACKGROUND SKY
	local background_sky = EntityCreateNew()
	EntitySetTransform(background_sky, 270, -85)
	EntityAddComponent2(background_sky, "SpriteComponent", {
		image_file="mods/AdventureMode/files/noita_weather_background/background_sky.png",
		offset_x=256,
		offset_y=206,
		z_index=general_z_index
	} )
	
	--GRADIENT BACK
	local gradient_back = EntityCreateNew()
	EntitySetTransform(gradient_back, 270, -85)
	EntityAddComponent2(gradient_back, "SpriteComponent", {
		image_file="mods/AdventureMode/files/noita_weather_background/gradient_back.png",
		offset_x=256,
		offset_y=256,
		z_index=general_z_index - 1
	} )

	--BACKGROUND CLOUDS
	local background_clouds = EntityCreateNew()
	EntitySetTransform(background_clouds, 270, -85)
	EntityAddComponent2(background_clouds, "SpriteComponent", {
		image_file="mods/AdventureMode/files/noita_weather_background/background_clouds.png",
		offset_x=533,
		offset_y=206,
		z_index=general_z_index - 2
	} )
	EntityAddComponent2(background_clouds, "SpriteComponent", {
		image_file="mods/AdventureMode/files/noita_weather_background/background_clouds.png",
		offset_x=1599,
		offset_y=206,
		z_index=general_z_index - 2
	} )
	EntityAddComponent2(background_clouds, "SpriteComponent", {
		image_file="mods/AdventureMode/files/noita_weather_background/background_clouds.png",
		offset_x=-533,
		offset_y=206,
		z_index=general_z_index - 2
	} )
	EntityAddComponent2(background_clouds, "LuaComponent", {
		script_source_file="mods/AdventureMode/files/noita_weather_background/background_clouds_move_left.lua",
		execute_every_n_frame=4
	} )

	--BACKGROUND MOUNTAINS
	local background_mountains = EntityCreateNew()
	EntitySetTransform(background_mountains, 270, -85)
	EntityAddComponent2(background_mountains, "SpriteComponent", {
		image_file="mods/AdventureMode/files/noita_weather_background/background_mountains.png",
		offset_x=256,
		offset_y=190,
		z_index=general_z_index - 3
	} )

	--FOREGROUND CLOUDS
	local foreground_clouds = EntityCreateNew()
	EntitySetTransform(foreground_clouds, 270, -85)
	EntityAddComponent2(foreground_clouds, "SpriteComponent", {
		image_file="mods/AdventureMode/files/noita_weather_background/foreground_clouds.png",
		offset_x=570,
		offset_y=256,
		z_index=general_z_index - 4
	} )
	EntityAddComponent2(foreground_clouds, "SpriteComponent", {
		image_file="mods/AdventureMode/files/noita_weather_background/foreground_clouds.png",
		offset_x=1710,
		offset_y=256,
		z_index=general_z_index - 4
	} )
	EntityAddComponent2(foreground_clouds, "SpriteComponent", {
		image_file="mods/AdventureMode/files/noita_weather_background/foreground_clouds.png",
		offset_x=-570,
		offset_y=256,
		z_index=general_z_index - 4
	} )
	EntityAddComponent2(foreground_clouds, "LuaComponent", {
		script_source_file="mods/AdventureMode/files/noita_weather_background/foreground_clouds_move_left.lua",
		execute_every_n_frame=2
	} )

	--FOREGROUND MOUNTAINS
	local foreground_mountains = EntityCreateNew()
	EntitySetTransform(foreground_mountains, 270, -60)
	EntityAddComponent2(foreground_mountains, "SpriteComponent", {
		image_file="mods/AdventureMode/files/noita_weather_background/foreground_mountains.png",
		offset_x=256,
		offset_y=350,
		z_index=general_z_index - 5
	} )

	--FOREGROUND MOUNTAINS LIGHTING
	local foreground_mountains_lighting = EntityCreateNew()
	EntitySetTransform(foreground_mountains_lighting, 270, -60)
	EntityAddComponent2(foreground_mountains_lighting, "SpriteComponent", {
		image_file="mods/AdventureMode/files/noita_weather_background/foreground_mountains_lighting.png",
		offset_x=256,
		offset_y=350,
		z_index=general_z_index - 6
	} )

	--GRADIENT FRONT
	local gradient_front = EntityCreateNew()
	EntitySetTransform(gradient_front, 270, -85)
	EntityAddComponent2(gradient_front, "SpriteComponent", {
		image_file="mods/AdventureMode/files/noita_weather_background/gradient_front.png",
		offset_x=256,
		offset_y=206,
		z_index=general_z_index - 7
	} )
	
	-- LoadBackgroundSprite( "mods/AdventureMode/files/noita_background.png", x - 256, y - 300, 100, false )
	-- local background = EntityCreateNew()
	-- EntitySetTransform(background, x, y)
	-- EntityAddComponent2(background, "SpriteComponent", {
		-- image_file="mods/AdventureMode/files/noita_background.png",
		-- offset_x=256,
		-- offset_y=256
	-- } )
end