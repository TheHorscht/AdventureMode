local dialog_system = dofile_once("mods/AdventureMode/lib/DialogSystem/dialog_system.lua")
local entity_id = GetUpdatedEntityID()
local x, y = EntityGetTransform(entity_id)

function interacting(entity_who_interacted, entity_interacted, interactable_name)
  dialog_system.open_dialog({
    name = "Ancient tablet",
    portrait = "mods/AdventureMode/files/slab_portrait.png",
    -- typing_sound = "two", -- There are currently 6: default, sans, one, two, three, four and "none" to turn it off, if not specified uses "default"
    text = [[
      {@delay 2}Strain as you might, the object of your desire eludes you.
      To reach your goal, you must first set your eyes on it.
      Then through sheer determination and power of will, let your
      aspiration lift you higher.
    ]],
  })
end
