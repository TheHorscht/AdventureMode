dofile_once("mods/AdventureMode/files/util.lua")

if GlobalsGetValue("AdventureMode_game_complete", "0") == "0" then

	local min_heatwarp_at_x = 550
	local max_heatwarp_at_x = 0

	local player = EntityGetWithTag("player_unit")[1]
	if player then
	  local x, y = EntityGetTransform(player)
	  if x < min_heatwarp_at_x then
		local heat_warp_amount = math.min(1, math.max(0, (min_heatwarp_at_x - x) / (min_heatwarp_at_x - max_heatwarp_at_x)))
		GameSetPostFxParameter("heat_warp_amount", heat_warp_amount, 0, 0, 0)
		if heat_warp_amount == 1 then
		  -- local count = GameGetGameEffectCount(player, "CUSTOM")
		  -- print("count: " .. type(count) .. " - " .. tostring(count))
		  -- if count < 1 then
			if GlobalsGetValue("AdventureMode_respawn_in_progress", "0") == "0" and not get_child_with_name(player, "heatstroke") then
			  local effect_entity = EntityLoad("mods/AdventureMode/files/heatstroke_effect.xml", x, y)
			  EntityAddChild(player, effect_entity)
			end
			-- local effect_component_id, effect_entity_id = LoadGameEffectEntityTo(player, "mods/AdventureMode/files/heatstroke_effect.xml")
		  -- end
		  -- local effect_component_id, effect_entity_id = GetGameEffectLoadTo(player, "ADVENTUREMODE_HEATSTROKE", false)
		end
	  elseif GameGetFrameNum() % 60 == 0 then -- Only check once per second
		local heatstroke = get_child_with_name(player, "heatstroke")
		if heatstroke then
		  EntityKill(heatstroke)
		end
	  end
	end

end