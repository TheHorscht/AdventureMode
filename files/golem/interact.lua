dofile_once("data/scripts/lib/utilities.lua")
dofile_once("mods/AdventureMode/lib/coroutines.lua")
dofile_once("mods/AdventureMode/files/util.lua")
local dialog_system = dofile_once("mods/AdventureMode/lib/DialogSystem/dialog_system.lua")

-- Make NPC stop walking while player is close
local entity_id = GetUpdatedEntityID()
local x, y = EntityGetTransform(entity_id)
local player = EntityGetInRadiusWithTag(x, y, 15, "player_unit")[1]
local character_platforming_component = EntityGetFirstComponentIncludingDisabled(entity_id, "CharacterPlatformingComponent")
local walking_to_wall = get_var_store_bool(entity_id, "walking_to_wall", false)
if player and not walking_to_wall then
  ComponentSetValue2(character_platforming_component, "run_velocity", 0)
elseif walking_to_wall then
  ComponentSetValue2(character_platforming_component, "run_velocity", 40)
else
  ComponentSetValue2(character_platforming_component, "run_velocity", 20)
end

local dialog_active = {
  name = "Golem",
  portrait = "mods/AdventureMode/files/golem/portrait.png",
  -- typing_sound = "two", -- There are currently 6: default, sans, one, two, three, four and "none" to turn it off, if not specified uses "default"
  text = [[
    {@delay 5}#ROAR!!#{@pause 60}{@delay 2} Were you the one who woke me from my slumber?{@pause 60}
    Another seeker of magic?{@pause 30} Ah, who else would it be...{@pause 30}
    I wonder if this one going to finally make it?
  ]],
  options = {
    {
      text = "Who created you?",
      func = function(dialog)
        dialog.show({
          text = [[
            Well, you see{@pause 15}.{@pause 15}.{@pause 15}. {@pause 15}
            When a mommy stone and a daddy stone
            love each other very much...
          ]],
          options = {
            {
              text = "Spare me the rest..."
            }
          }
        })
      end
    },
    {
      text = "Can you break the wall for me?",
      func = function(dialog)
        dialog.show({
          text = "Nothing easier than that. Step aside and watch me go.",
          options = {
            {
              text = "End",
              func = function(dialog)
                dialog.close(function()
                  local animal_ai_component = EntityGetFirstComponentIncludingDisabled(entity_id, "AnimalAIComponent")
                  local interactable_component = EntityGetFirstComponentIncludingDisabled(entity_id, "InteractableComponent")
                  local sprite_component = EntityGetFirstComponentIncludingDisabled(entity_id, "SpriteComponent")
                  local animal_ai_component = EntityGetFirstComponentIncludingDisabled(entity_id, "AnimalAIComponent")
                  local sprite_animator_component = EntityGetFirstComponentIncludingDisabled(entity_id, "SpriteAnimatorComponent")
                  local character_data_comp = EntityGetFirstComponentIncludingDisabled(entity_id, "CharacterDataComponent")
                  set_var_store_bool(entity_id, "walking_to_wall", true)
                  EntitySetComponentIsEnabled(entity_id, interactable_component, false)
                  local max_distance_to_move_from_home = ComponentGetValue2(animal_ai_component, "max_distance_to_move_from_home")
                  ComponentSetValue2(animal_ai_component, "max_distance_to_move_from_home", 10)
                  ComponentSetValue2(animal_ai_component, "mAiStateLastSwitchFrame", GameGetFrameNum() - 1000)
                  -- ComponentSetValue2(animal_ai_component, "mHomePosition", x + 100, y)
                  ComponentSetValue2(animal_ai_component, "ai_state", 21)
                  local home_x, home_y = ComponentGetValue2(animal_ai_component, "mHomePosition")
                  wait_until(function()
                    local x, y = EntityGetTransform(entity_id)
                    local dist2 = get_distance2(x, y, home_x, home_y)
                    return dist2 <= 150
                  end, 20)
                  EntitySetComponentIsEnabled(entity_id, sprite_animator_component, false)
                  EntitySetComponentIsEnabled(entity_id, animal_ai_component, false)
                  EntitySetComponentIsEnabled(entity_id, character_data_comp, false)
                  local x, y, rot = EntityGetTransform(entity_id)
                  -- Face right
                  EntitySetTransform(entity_id, x, y, rot, 1)
                  ComponentSetValue2(sprite_component, "rect_animation", "wind_up")
                  wait(60)
                  ComponentSetValue2(sprite_component, "rect_animation", "blink_slow")
                  wait(80)
                  ComponentSetValue2(sprite_component, "rect_animation", "blink_fast")
                  wait(40)
                  ComponentSetValue2(sprite_component, "rect_animation", "blink_fastest")
                  wait(40)
                  ComponentSetValue2(sprite_component, "rect_animation", "attack")
                  for j=1, 4 do
                    local x, y = EntityGetTransform(entity_id)
                    for i=1, 20 do
                      EntitySetTransform(entity_id, x + i * 5, y)
                      local lookahead = 17
                      local did_hit ,hit_x ,hit_y = RaytraceSurfaces(x + lookahead + i * 5, y - 20, x + lookahead + (i + 1) * 5, y - 20)
                      if did_hit then
                        GameScreenshake(100, x, y)
                        shoot_projectile(entity_id, "mods/AdventureMode/files/golem/explosion.xml", x + 22 + i * 5, y - 30, 0, 0, false)
                        shoot_projectile(entity_id, "mods/AdventureMode/files/golem/explosion.xml", x + 22 + i * 5, y - 10, 0, 0, false)
                        shoot_projectile(entity_id, "mods/AdventureMode/files/golem/explosion.xml", x + 22 + i * 5, y + 10, 0, 0, false)
                        break
                      end
                      wait(0)
                    end
                    if j < 4 then
                      ComponentSetValue2(sprite_component, "rect_animation", "wind_up")
                      wait(60)
                      ComponentSetValue2(sprite_component, "rect_animation", "attack")
                      wait(5)
                    end
                  end
                  ComponentSetValue2(sprite_component, "rect_animation", "stand")
                  EntitySetComponentIsEnabled(entity_id, interactable_component, true)
                  EntitySetComponentIsEnabled(entity_id, animal_ai_component, true)
                  EntitySetComponentIsEnabled(entity_id, sprite_animator_component, true)
                  EntitySetComponentIsEnabled(entity_id, character_data_comp, true)
                  ComponentSetValue2(animal_ai_component, "max_distance_to_move_from_home", max_distance_to_move_from_home)
                  GlobalsSetValue("AdventureMode_golem_has_destroyed_wall", "1")
                  set_var_store_bool(entity_id, "walking_to_wall", false)
                end)
              end
            }
          }
        })
      end
    },
    {
      text = "Leave"
    },
  }
}

local dialog_wall_destroyed = {
  name = "Golem",
  portrait = "mods/AdventureMode/files/golem/portrait.png",
  text = [[
    That was fun :)
  ]],
}

function interacting(entity_who_interacted, entity_interacted, interactable_name)
  local dialog = dialog_active
  if GlobalsGetValue("AdventureMode_golem_has_destroyed_wall", "0") == "1" then
    dialog = dialog_wall_destroyed
  end
  dialog_system.open_dialog(dialog)
end
