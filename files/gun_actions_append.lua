table.insert(actions, {
  id = "ADVENTUREMODE_TORCH",
  name = "$action_torch",
  description = "$actiondesc_torch",
  sprite = "data/ui_gfx/gun_actions/torch.png",
  sprite_unidentified = "data/ui_gfx/gun_actions/torch_unidentified.png",
  type = ACTION_TYPE_PASSIVE,
  spawn_level       = "0,1,2",
  spawn_probability = "1,1,1",
  price = 100,
  mana = 0,
  custom_xml_file = "mods/AdventureMode/files/spells/torch.xml",
  action = function()
    draw_actions(1, true)
  end,
})
