local dialog_system = dofile_once("mods/AdventureMode/lib/DialogSystem/dialog_system.lua")
local entity_id = GetUpdatedEntityID()
local x, y = EntityGetTransform(entity_id)

function interacting(entity_who_interacted, entity_interacted, interactable_name)
  dialog_system.open_dialog({
    name = "Sign",
    portrait = "mods/AdventureMode/files/sign_portrait.png",
    -- typing_sound = "two", -- There are currently 6: default, sans, one, two, three, four and "none" to turn it off, if not specified uses "default"
    text = [[
      {@delay 2}Keep possession of your items, avoid throwing them in 
	  unreachable areas such as the poison {@pause 30} ...{@pause 30}
      Think before you throw.
    ]],
  })
end
