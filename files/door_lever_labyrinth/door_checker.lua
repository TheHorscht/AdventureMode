dofile_once("mods/AdventureMode/files/util.lua")
dofile_once("mods/AdventureMode/lib/coroutines.lua")

local entity_id = GetUpdatedEntityID()
local x, y = EntityGetTransform(entity_id)

local state = get_state(entity_id)

local color = get_var_store_string(entity_id, "color", "")
local default_state = get_var_store_int(entity_id, "default_state", 1)
local active_state = tonumber(GlobalsGetValue("AdventureMode_leverdoor_puzzle_color_" .. color, "0"))
local PhysicsBody_comp = EntityGetFirstComponentIncludingDisabled(entity_id, "PhysicsBodyComponent")
if PhysicsBody_comp then
  local current_state = ComponentGetIsEnabled(PhysicsBody_comp)
  local physics_joint_component = EntityGetFirstComponentIncludingDisabled(entity_id, "PhysicsJointComponent")
  if not (physics_joint_component and current_state) then
    local orientation = get_var_store_string(entity_id, "orientation")
    local offsets = {
      { x = 0, y = 0 },
      { x = 0, y = 0 },
    }
    if orientation == "h" then
      offsets[1].x = 6
      offsets[1].y = 4
      offsets[2].x = 17
      offsets[2].y = 4
    elseif orientation == "v" then
      offsets[1].x = 4
      offsets[1].y = 6
      offsets[2].x = 4
      offsets[2].y = 17
    end
    -- Remove all old PhysicsJointComponents before adding new ones
    for i, comp in ipairs(EntityGetComponentIncludingDisabled(entity_id, "PhysicsJointComponent") or {}) do
      EntityRemoveComponent(entity_id, comp)
    end
    EntityAddComponent2(entity_id, "PhysicsJointComponent", {
      nail_to_wall = true, breakable = false, grid_joint = true, pos_y = offsets[1].y, pos_x = offsets[1].x,
    })
    EntityAddComponent2(entity_id, "PhysicsJointComponent", {
      nail_to_wall = true, breakable = false, grid_joint = true, pos_y = offsets[2].y, pos_x = offsets[2].x,
    })
  end
  local new_state = active_state ~= default_state
  if new_state ~= current_state then
    EntitySetComponentIsEnabled(entity_id, PhysicsBody_comp, new_state)
    
    local sprite_comp = EntityGetFirstComponentIncludingDisabled(entity_id, "SpriteComponent")
    local orientation = get_var_store_string(entity_id, "orientation")
    
    if state.coroutine then
      state.coroutine.stop()
    end
    local direction = new_state == true and -1 or 1
    local progress = 0
    state.coroutine = async(function()
      local sprite_particle_emitter_comp = EntityGetFirstComponentIncludingDisabled(entity_id, "SpriteParticleEmitterComponent")
      EntitySetComponentIsEnabled(entity_id, sprite_particle_emitter_comp, true)
      local offset_prop = ({ h = "offset_x", v = "offset_y" })[orientation]
      local offset = ComponentGetValue2(sprite_comp, offset_prop)
      while (direction == 1 and offset < 27) or (direction == -1 and offset > 1) do
        offset = offset + direction * 0.5
        ComponentSetValue2(sprite_comp, offset_prop, offset)
        if (last_frame_shaken or 0) + 5 < GameGetFrameNum() then
          last_frame_shaken = GameGetFrameNum()
          local cx, cy = GameGetCameraPos()
          GameScreenshake(3, cx, cy)
        end
        wait(0)
      end
      EntitySetComponentIsEnabled(entity_id, sprite_particle_emitter_comp, false)
    end)
  end
end
