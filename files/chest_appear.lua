dofile_once("mods/AdventureMode/lib/coroutines.lua")
dofile_once("mods/AdventureMode/files/util.lua")

local entity_id = GetUpdatedEntityID()

async(function()
  local x, y = EntityGetTransform(entity_id)
  local sprite_components = EntityGetComponentIncludingDisabled(entity_id, "SpriteComponent") or {}
  local sprite_particle_emitter_component = EntityGetFirstComponentIncludingDisabled(entity_id, "SpriteParticleEmitterComponent")
  for i=1, 13 do
    ComponentSetValue2(sprite_particle_emitter_component, "randomize_position", -9, i - 2, 9, i)
    EntitySetTransform(entity_id, x, y - i)
    GameScreenshake(5, x, y)
    wait(10)
  end
  local sprite_particle_emitter_component = EntityGetFirstComponentIncludingDisabled(entity_id, "SpriteParticleEmitterComponent")
  EntitySetComponentIsEnabled(entity_id, sprite_particle_emitter_component, false)
  set_var_store_bool(entity_id, "is_done", true)

  local sprite_to_remove = EntityGetFirstComponent(entity_id, "SpriteComponent", "character")
  EntityRemoveComponent(entity_id, sprite_to_remove)
  EntityAddComponent2(entity_id, "PhysicsImageShapeComponent", {
    body_id=1,
    offset_x=8,
    offset_y=0,
    image_file="data/buildings_gfx/chest_random_super.png",
    material=CellFactory_GetType("wood_prop"),
  })
  EntityAddComponent2(entity_id, "PhysicsBodyComponent", {
    uid=1,
    allow_sleep=true,
    angular_damping=0,
    fixed_rotation=false,
    is_bullet=true,
    linear_damping=0,
    auto_clean=true,
    hax_fix_going_through_ground=false,
    on_death_leave_physics_body=false,
    on_death_really_leave_body=false,
  })
end)
