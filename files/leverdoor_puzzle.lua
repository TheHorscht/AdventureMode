function toggle_color(color)
  local color_state = tonumber(GlobalsGetValue("AdventureMode_leverdoor_puzzle_color_" .. color, "0"))
  GlobalsSetValue("AdventureMode_leverdoor_puzzle_color_" .. color, 1 - color_state)
end

function lever_01_switched()
  toggle_color("pink")
  toggle_color("blue")
end

function lever_02_switched()
  toggle_color("red")
  toggle_color("blue")
end

function lever_03_switched()
  toggle_color("green")
end

function lever_04_switched()
  toggle_color("red")
  toggle_color("green")
  toggle_color("blue")
end

function lever_05_switched()
  toggle_color("red")
  toggle_color("green")
end

function lever_06_switched()
  toggle_color("orange")
  toggle_color("pink")
end
