dofile_once("data/scripts/lib/utilities.lua")
dofile_once("data/scripts/game_helpers.lua")

local entity_id = GetUpdatedEntityID()
local x, y = EntityGetTransform(entity_id)

local players = EntityGetWithTag("player_unit")

pressed = false

local did_hit = RaytracePlatforms(x - 10, y -2, x + 10, y - 2)

if did_hit then

    play_animation( entity_id, "down")
    
    pressed = true
    
    GamePrint("Pressed")

end

if #players > 0 then
  
    local player_x, player_y = EntityGetTransform(players[1])
  
    if player_x > x - 10 and player_y < y and player_y > y - 4 and player_x < x + 10 then
            
        play_animation( entity_id, "down")
        
        pressed = true
        
        GamePrint("Pressed")

    end
  
end

if pressed == false then

    play_animation( entity_id, "up")

end
