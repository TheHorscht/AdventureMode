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
      Yo what?! You can burn this with fire?{@delay 30}...{@delay 3} Dang!{@pause 30}
      I told him we should've brought a torch...
    ]],
  })
end
