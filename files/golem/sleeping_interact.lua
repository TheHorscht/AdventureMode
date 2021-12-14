dofile_once("data/scripts/lib/utilities.lua")
local dialog_system = dofile_once("mods/AdventureMode/lib/DialogSystem/dialog_system.lua")
local entity_id = GetUpdatedEntityID()
local x, y = EntityGetTransform(entity_id)

function interacting(entity_who_interacted, entity_interacted, interactable_name)
  dialog_system.open_dialog({
    name = "Strange Statue",
    portrait = "mods/AdventureMode/files/golem/inactive_portrait.png",
    -- typing_sound = "two", -- There are currently 6: default, sans, one, two, three, four and "none" to turn it off, if not specified uses "default"
    text = [[
      An old statue lies on the floor, it looks broken.
    ]],
    options = {
      {
        text = "Insert Gemstone",
        show = function(stats)
          return stats.get_item_with_name("red_gem")
        end,
        func = function(dialog, stats)
          EntityKill(stats.get_item_with_name("red_gem"))
          local sprite_component = EntityGetFirstComponentIncludingDisabled(entity_id, "SpriteComponent")
          GamePlaySound("mods/AdventureMode/files/audio/AdventureMode.bank", "golem_reform", x, y)
          ComponentSetValue2(sprite_component, "rect_animation", "wake")
          local sprite_particle_emitter_component = EntityGetFirstComponentIncludingDisabled(entity_id, "SpriteParticleEmitterComponent")
          local interactable_component = EntityGetFirstComponentIncludingDisabled(entity_id, "InteractableComponent")
          local path_finding_component = EntityGetFirstComponentIncludingDisabled(entity_id, "PathFindingComponent")
          local character_platforming_component = EntityGetFirstComponentIncludingDisabled(entity_id, "CharacterPlatformingComponent")
          local animal_ai_component = EntityGetFirstComponentIncludingDisabled(entity_id, "AnimalAIComponent")
          EntitySetComponentIsEnabled(entity_id, sprite_particle_emitter_component, true)
          EntitySetComponentIsEnabled(entity_id, interactable_component, false)
          GlobalsSetValue("AdventureMode_golem_activated", "1")
          async(function()
            for i=1, 5 do
              GameScreenshake(5, x, y)
              wait(10)
            end
          end)
          dialog.close(function()
            EntityKill(entity_interacted)
            EntityLoad("mods/AdventureMode/files/golem/golem.xml", x, y)
          end)
        end
      },
      {
        text = "Leave it alone"
      }
    }
  })
end
