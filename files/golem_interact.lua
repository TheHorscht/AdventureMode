dofile_once("data/scripts/lib/utilities.lua")
local dialog_system = dofile_once("mods/AdventureMode/lib/DialogSystem/dialog_system.lua")
local entity_id = GetUpdatedEntityID()
local x, y = EntityGetTransform(entity_id)

local dialog_inactive = {
  name = "Strange Statue",
  portrait = "mods/AdventureMode/files/golem_inactive_portrait.png",
  -- typing_sound = "two", -- There are currently 6: default, sans, one, two, three, four and "none" to turn it off, if not specified uses "default"
  text = [[
    An old statue lies on the floor, it looks broken.
  ]],
  options = {
    {
      text = "Insert Gemstone",
      enabled = false,
      func = function(dialog)
        local sprite_component = EntityGetFirstComponentIncludingDisabled(entity_id, "SpriteComponent")
        ComponentSetValue2(sprite_component, "rect_animation", "wake")
        local sprite_particle_emitter_component = EntityGetFirstComponentIncludingDisabled(entity_id, "SpriteParticleEmitterComponent")
        EntitySetComponentIsEnabled(entity_id, sprite_particle_emitter_component, true)
        GlobalsSetValue("AdventureMode_golem_activated", "1")
        async(function()
          for i=1, 5 do
            GameScreenshake(5, x, y)
            wait(10)
          end
          -- wait(30)
          EntitySetComponentIsEnabled(entity_id, sprite_particle_emitter_component, false)
        end)
        dialog.close()
      end
    }, {
      text = "Leave it alone"
    }
  }
}

local dialog_active = {
  name = "Golem",
  portrait = "mods/AdventureMode/files/golem_portrait.png",
  -- typing_sound = "two", -- There are currently 6: default, sans, one, two, three, four and "none" to turn it off, if not specified uses "default"
  text = [[
    Were you the one who woke me from my slumber?{@pause 30}
    Then that makes you my new master.{@pause 60}
    What is your command?
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
          text = "Command accepted. Step aside and watch me go.",
          options = {
            {
              text = "End",
              func = function(dialog)
                dialog.close(function()
                  local sprite_component = EntityGetFirstComponentIncludingDisabled(entity_id, "SpriteComponent")
                  local interactable_component = EntityGetFirstComponentIncludingDisabled(entity_id, "InteractableComponent")
                  EntitySetComponentIsEnabled(entity_id, interactable_component, false)
                  ComponentSetValue2(sprite_component, "rect_animation", "wind_up")
                  async(function()
                    wait(60)
                    ComponentSetValue2(sprite_component, "rect_animation", "blink_slow")
                    wait(80)
                    ComponentSetValue2(sprite_component, "rect_animation", "blink_fast")
                    wait(40)
                    ComponentSetValue2(sprite_component, "rect_animation", "blink_fastest")
                    wait(40)
                    ComponentSetValue2(sprite_component, "rect_animation", "attack")
                    for j=1, 5 do
                      local x, y = EntityGetTransform(entity_id)
                      for i=1, 20 do
                        EntitySetTransform(entity_id, x + i * 5, y)
                        local did_hit ,hit_x ,hit_y = RaytraceSurfaces(x + 17 + i * 5, y, x + 17 + (i + 1) * 5, y)
                        if did_hit then
                          GameScreenshake(100, x, y)
                          -- function shoot_projectile( who_shot, entity_file, x, y, vel_x, vel_y, send_message )
                          shoot_projectile(entity_id, "mods/AdventureMode/files/golem_explosion.xml", x + 22 + i * 5, y - 40, 0, 0, false)
                          shoot_projectile(entity_id, "mods/AdventureMode/files/golem_explosion.xml", x + 22 + i * 5, y - 20, 0, 0, false)
                          shoot_projectile(entity_id, "mods/AdventureMode/files/golem_explosion.xml", x + 22 + i * 5, y, 0, 0, false)
                          break
                        end
                        wait(0)
                      end
                      if j < 5 then
                        ComponentSetValue2(sprite_component, "rect_animation", "wind_up")
                        wait(60)
                        ComponentSetValue2(sprite_component, "rect_animation", "attack")
                        wait(5)
                      end
                    end
                    ComponentSetValue2(sprite_component, "rect_animation", "stand")
                    EntitySetComponentIsEnabled(entity_id, interactable_component, true)
                    GlobalsSetValue("AdventureMode_golem_has_destroyed_wall", "1")
                  end)
                end)
              end
            }
          }
        })
      end
    },
  }
}

local dialog_wall_destroyed = {
  name = "Golem",
  portrait = "mods/AdventureMode/files/golem_portrait.png",
  -- typing_sound = "two", -- There are currently 6: default, sans, one, two, three, four and "none" to turn it off, if not specified uses "default"
  text = [[
    That was fun :)
  ]],
  -- options = {
  --   {
  --     text = "Who created you?",
  --     func = function(dialog)
  --       dialog.show({
  --         text = [[
  --           Well, you see{@pause 15}.{@pause 15}.{@pause 15}. {@pause 15}
  --           When a mommy stone and a daddy stone
  --           love each other very much...
  --         ]],
  --         options = {
  --           {
  --             text = "Spare me the rest..."
  --           }
  --         }
  --       })
  --     end
  --   },
  --   {
  --     text = "Can you break the wall for me?",
  --     func = function(dialog)
  --       dialog.show({
  --         text = "Command accepted. Step aside and watch me go.",
  --         options = {
  --           {
  --             text = "End",
  --             func = function(dialog)
  --               local sprite_component = EntityGetFirstComponentIncludingDisabled(entity_id, "SpriteComponent")
  --               local interactable_component = EntityGetFirstComponentIncludingDisabled(entity_id, "InteractableComponent")
  --               EntitySetComponentIsEnabled(entity_id, interactable_component, false)
  --               ComponentSetValue2(sprite_component, "rect_animation", "wind_up")
  --               async(function()
  --                 wait(60)
  --                 ComponentSetValue2(sprite_component, "rect_animation", "blink_slow")
  --                 wait(80)
  --                 ComponentSetValue2(sprite_component, "rect_animation", "blink_fast")
  --                 wait(40)
  --                 ComponentSetValue2(sprite_component, "rect_animation", "blink_fastest")
  --                 wait(40)
  --                 ComponentSetValue2(sprite_component, "rect_animation", "attack")
  --                 for j=1, 5 do
  --                   local x, y = EntityGetTransform(entity_id)
  --                   for i=1, 20 do
  --                     EntitySetTransform(entity_id, x + i * 5, y)
  --                     local did_hit ,hit_x ,hit_y = RaytraceSurfaces(x + 17 + i * 5, y, x + 17 + (i + 1) * 5, y)
  --                     if did_hit then
  --                       GameScreenshake(100, x, y)
  --                       -- function shoot_projectile( who_shot, entity_file, x, y, vel_x, vel_y, send_message )
  --                       shoot_projectile(entity_id, "data/entities/projectiles/explosion.xml", x + 22 + i * 5, y - 40, 0, 0, false)
  --                       shoot_projectile(entity_id, "data/entities/projectiles/explosion.xml", x + 22 + i * 5, y - 20, 0, 0, false)
  --                       shoot_projectile(entity_id, "data/entities/projectiles/explosion.xml", x + 22 + i * 5, y, 0, 0, false)
  --                       break
  --                     end
  --                     wait(0)
  --                   end
  --                   if j < 5 then
  --                     ComponentSetValue2(sprite_component, "rect_animation", "wind_up")
  --                     wait(60)
  --                     ComponentSetValue2(sprite_component, "rect_animation", "attack")
  --                     wait(5)
  --                   end
  --                 end
  --                 ComponentSetValue2(sprite_component, "rect_animation", "stand")
  --                 EntitySetComponentIsEnabled(entity_id, interactable_component, true)
  --                 GlobalsSetValue("AdventureMode_golem_has_destroyed_wall", "1")
  --               end)
  --               dialog.close()
  --             end
  --           }
  --         }
  --       })
  --     end
  --   },
  -- }
}

function interacting(entity_who_interacted, entity_interacted, interactable_name)
  local dialog = dialog_inactive
  if GlobalsGetValue("AdventureMode_golem_activated", "0") == "1" then
    dialog = dialog_active
  end
  if GlobalsGetValue("AdventureMode_golem_has_destroyed_wall", "0") == "1" then
    dialog = dialog_wall_destroyed
  end
  dialog_system.open_dialog(dialog)
end
