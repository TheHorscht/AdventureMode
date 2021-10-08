ModMagicNumbersFileAdd("mods/AdventureMode/files/magic_numbers.xml")
dofile_once("mods/AdventureMode/lib/coroutines.lua")
dofile_once("data/scripts/lib/utilities.lua")

local nxml = dofile_once("mods/AdventureMode/lib/nxml.lua")
local content = ModTextFileGetContent("data/biome/_biomes_all.xml")
local xml = nxml.parse(content)
xml:add_child(nxml.parse([[
<Biome 
  biome_filename="mods/AdventureMode/files/biomes/sand.xml" 
  height_index="0"
  color="ff792701">
</Biome>
]]))
ModTextFileSetContent("data/biome/_biomes_all.xml", tostring(xml))

local camera_controls
function OnPlayerSpawned(player)
  camera_controls = EntityCreateNew()
  EntityAddComponent2(camera_controls, "ControlsComponent")
  -- GameGetCameraPos() -> x:number,y:number
  -- GameSetCameraPos( x:number, y:number )
  -- GameSetCameraFree( is_free:bool )
  GameSetCameraFree(true)
  local controls_component = EntityGetFirstComponentIncludingDisabled(player, "ControlsComponent")
  ComponentSetValue2(controls_component, "enabled", false)
  camera_tracking_shot(260, -800, 260, -600, 0.01)
end

--[[ 
lerp with t: 0.5
edge0: 88.73673248291
edge1: 0
0.99990511011308
lerp with t: 0.5
edge0: -37.602340698242
edge1: 0
1
]]

function smoothstep(edge0, edge1, t)
  t = clamp((t - edge0) / (edge1 - edge0), 0, 1)
  print(t * t * (3 - 2 * t))
  return t * t * (3 - 2 * t)
end

function smootherstep(edge0, edge1, t)
  t = clamp((t - edge0) / (edge1 - edge0), 0.0, 1.0)
  return t * t * t * (t * (t * 6 - 15) + 10)
end

function lerp(a, b, t)
  t = smoothstep(0, 1, t)
	return a * t + b * (1 - t)
end

local camera_coroutine
function camera_tracking_shot(start_x, start_y, end_x, end_y, speed)
  if camera_coroutine then return end
  camera_coroutine = async(function()
    local cx, cy = start_x, start_y
    local t = 0
    GameSetCameraPos(cx, cy)
    wait(0)
    while true do
      t = t + speed
      if t >= 1 then
        t = 1
      end
      cx, cy = vec_lerp(end_x, end_y, start_x, start_y, t)
      GameSetCameraPos(cx, cy)
      if t >= 1 then
        break
      end
      wait(0)
    end
    camera_coroutine = nil
  end)
end

function OnWorldPreUpdate()
  -- local player = EntityGetWithTag("player_unit")[1]
  local controls_component = EntityGetFirstComponentIncludingDisabled(camera_controls, "ControlsComponent")
  local mButtonDownUp = ComponentGetValue2(controls_component, "mButtonFrameUp") == GameGetFrameNum()
  local mButtonDownDown = ComponentGetValue2(controls_component, "mButtonFrameDown") == GameGetFrameNum()
  local mButtonDownLeft = ComponentGetValue2(controls_component, "mButtonFrameLeft") == GameGetFrameNum()
  local mButtonDownRight = ComponentGetValue2(controls_component, "mButtonFrameRight") == GameGetFrameNum()
  local mButtonDownFire = ComponentGetValue2(controls_component, "mButtonFrameFire") == GameGetFrameNum()
  angle = math.mod(angle + 0.05, math.pi * 2)
  -- cx, cy = GameGetCameraPos()
  -- GameSetCameraPos(240 + math.cos(angle) * 100, -40)
  wake_up_waiting_threads(1)
  if mButtonDownFire then
    local cx, cy = GameGetCameraPos()
    local mx, my = DEBUG_GetMouseWorld()
    camera_tracking_shot(cx, cy, mx, my, 0.01)
  end
end

function OnWorldPostUpdate()
  -- cy = cy + 0.5
  -- GameSetCameraPos(cx, cy)
end
