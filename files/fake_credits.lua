dofile_once("data/scripts/lib/utilities.lua")

local lines = {
  " ",
  "A mod for Noita by",
  " ",
  "Horscht",
  "Initial idea, coding, layout, puzzles, riddles",
  " ",
  "Keith Sammut (hornedkey)",
  "Sprites, coding, layout, later areas with boss and ending cutscene",
  " ",
  "The One The Only Spoopy Boi",
  "Golem portait, talking sounds for golem and funny skeletons",
}

local entity_id = GetUpdatedEntityID()
local controls_comp = EntityGetFirstComponentIncludingDisabled(entity_id, "ControlsComponent")
local jump_down = ComponentGetValue2(controls_comp, "mButtonDownFly")
local player = EntityGetWithTag("player_unit")[1]
local accelerate = jump_down and (player == nil)

gui = gui or GuiCreate()
GuiStartFrame(gui)
roll_credits_progress = (roll_credits_progress or -1) - 0.415 * (accelerate and 15 or 1)

if not do_once and roll_credits_progress <= -100 then
  do_once = true
  local player = EntityGetWithTag("player_unit")[1]
  if player then
    GameAddFlagRun("ending_game_completed")
    GameOnCompleted()
    EntityKill(player)
  end
end

if roll_credits_progress < -800 then
  EntityKill(entity_id)
end

GuiLayoutBeginVertical(gui, 50, 100)
GuiOptionsAddForNextWidget(gui, GUI_OPTION.Align_HorizontalCenter)
GuiImage(gui, 2, 0, roll_credits_progress, "mods/AdventureMode/files/intro_logo/aloittaa_colours.png", 1, 1, 1)
for i, line in ipairs(lines) do
  -- Draw black shadow first
  GuiOptionsAddForNextWidget(gui, GUI_OPTION.Align_HorizontalCenter)
  GuiColorSetForNextWidget(gui, 0, 0, 0, 1)
  GuiText(gui, 0, 0, line)
  -- Now the actual text at the same position minus one y
  local clicked, right_clicked, hovered, x, y, width, height, draw_x, draw_y, draw_width, draw_height = GuiGetPreviousWidgetInfo(gui)
  GuiOptionsAddForNextWidget(gui, GUI_OPTION.Layout_NoLayouting)
  GuiText(gui, x, y-1, line)
end
GuiLayoutEnd(gui)
