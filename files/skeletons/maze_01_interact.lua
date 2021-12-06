local dialog_system = dofile_once("mods/AdventureMode/lib/DialogSystem/dialog_system.lua")
local entity_id = GetUpdatedEntityID()
local x, y = EntityGetTransform(entity_id)

function interacting(entity_who_interacted, entity_interacted, interactable_name)
  dialog_system.open_dialog({
    name = "Skeleton",
    portrait = "mods/AdventureMode/files/skull_portrait.png",
    typing_sound = "bones", 
    -- There are currently 6: default, sans, one, two, three, four and "none" to turn it off, if not specified uses "default"
    text = [[
      Maybe I shouldn't have gone into this maze without a torch...
    ]],
  })
end
