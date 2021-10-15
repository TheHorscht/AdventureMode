dofile_once("mods/AdventureMode/files/util.lua")
dofile_once("mods/AdventureMode/lib/coroutines.lua")
dofile_once("data/scripts/status_effects/status_list.lua")

local function remove_game_effects(entity_id)
  local undetectable = {
    ALCOHOLIC = true,
    POISONED = true,
    HP_REGENERATION = true,
    HYDRATED = true,
    INGESTION_DRUNK = true,
    TRIP = true,
    NIGHTVISION = true,
    INGESTION_MOVEMENT_SLOWER = true,
    INGESTION_DAMAGE = true,
    INGESTION_EXPLODING = true,
    INGESTION_FREEZING = true,
    INGESTION_ON_FIRE = true,
    CURSE_CLOUD = true,
  }
  for i, effect in ipairs(status_effects) do
    if not undetectable[effect.id] then
      local comp = GameGetGameEffect(entity_id, effect.id)
      if comp > 0 then
        print("REmoving " ..effect.id)
        ComponentSetValue2(comp, "frames", 0)
      end
    end
  end
  entity_set_component_value(entity_id, "DamageModelComponent", "is_on_fire", false)
end

local bla = false
function damage_received(damage, message, entity_thats_responsible, is_fatal, projectile_thats_responsible)
  if is_fatal and not bla then
    local entity_id = GetUpdatedEntityID()
    local x, y = EntityGetTransform(entity_id)
    local corpse = EntityLoad("mods/AdventureMode/files/player_corpse.xml", x, y)
    local player_vel_comp = EntityGetFirstComponentIncludingDisabled(entity_id, "VelocityComponent")
    local character_data_component = EntityGetFirstComponentIncludingDisabled(entity_id, "CharacterDataComponent")
    local vel_comp = EntityGetFirstComponentIncludingDisabled(corpse, "VelocityComponent")
    local vx, vy = ComponentGetValue2(player_vel_comp, "mVelocity")
    ComponentSetValue2(vel_comp, "mVelocity", vx, vy)
    ComponentSetValue2(character_data_component, "mVelocity", 0, 0)
    local disable_component = { "DamageModelComponent", "" }
    local comp = EntityGetFirstComponentIncludingDisabled(entity_id, "DamageModelComponent")
    EntitySetComponentIsEnabled(entity_id, comp, false)
    local comp = EntityGetFirstComponentIncludingDisabled(entity_id, "SpriteComponent")
    EntitySetComponentIsEnabled(entity_id, comp, false)
    local comp = EntityGetFirstComponentIncludingDisabled(entity_id, "PlatformShooterPlayerComponent")
    EntitySetComponentIsEnabled(entity_id, comp, false)
    local comp = EntityGetFirstComponentIncludingDisabled(entity_id, "CharacterPlatformingComponent")
    EntitySetComponentIsEnabled(entity_id, comp, false)
    local comp = EntityGetFirstComponentIncludingDisabled(entity_id, "Inventory2Component")
    EntitySetComponentIsEnabled(entity_id, comp, false)
    local comp = EntityGetFirstComponentIncludingDisabled(entity_id, "InventoryGuiComponent")
    EntitySetComponentIsEnabled(entity_id, comp, false)

    -- Hide cape
    local cape_entity = EntityGetWithName("cape")
    local comp = EntityGetFirstComponentIncludingDisabled(cape_entity, "VerletPhysicsComponent")
    EntitySetComponentIsEnabled(cape_entity, comp, false)
    
    -- Hide arm
    local arm_r_entity = EntityGetWithName("arm_r")
    local comp = EntityGetFirstComponentIncludingDisabled(arm_r_entity, "SpriteComponent")
    EntitySetComponentIsEnabled(arm_r_entity, comp, false)

    -- Reset all game effects
    remove_game_effects(entity_id)

    -- local comp = EntityGetFirstComponentIncludingDisabled(entity_id, "GunComponent")
    -- EntitySetComponentIsEnabled(entity_id, comp, false)
    -- local comp = EntityGetFirstComponentIncludingDisabled(entity_id, "KickComponent")
    -- EntitySetComponentIsEnabled(entity_id, comp, false)
    set_controls_enabled(false)
    bla = true
    async(function()
      wait(180)
      remove_game_effects(entity_id)
      EntitySetTransform(entity_id, 1173, -553)
      local comp = EntityGetFirstComponentIncludingDisabled(entity_id, "DamageModelComponent")
      EntitySetComponentIsEnabled(entity_id, comp, true)
      local comp = EntityGetFirstComponentIncludingDisabled(entity_id, "SpriteComponent")
      EntitySetComponentIsEnabled(entity_id, comp, true)
      local comp = EntityGetFirstComponentIncludingDisabled(entity_id, "PlatformShooterPlayerComponent")
      EntitySetComponentIsEnabled(entity_id, comp, true)
      local comp = EntityGetFirstComponentIncludingDisabled(entity_id, "CharacterPlatformingComponent")
      EntitySetComponentIsEnabled(entity_id, comp, true)
      local comp = EntityGetFirstComponentIncludingDisabled(entity_id, "Inventory2Component")
      EntitySetComponentIsEnabled(entity_id, comp, true)
      local comp = EntityGetFirstComponentIncludingDisabled(entity_id, "InventoryGuiComponent")
      EntitySetComponentIsEnabled(entity_id, comp, true)
      local damage_model_component = EntityGetFirstComponentIncludingDisabled(entity_id, "DamageModelComponent")
      ComponentSetValue2(damage_model_component, "hp", ComponentGetValue2(damage_model_component, "max_hp"))

      -- Show cape
      local cape_entity = EntityGetWithName("cape")
      local comp = EntityGetFirstComponentIncludingDisabled(cape_entity, "VerletPhysicsComponent")
      EntitySetComponentIsEnabled(cape_entity, comp, true)
      
      -- Show arm
      local arm_r_entity = EntityGetWithName("arm_r")
      local comp = EntityGetFirstComponentIncludingDisabled(arm_r_entity, "SpriteComponent")
      EntitySetComponentIsEnabled(arm_r_entity, comp, true)

      set_controls_enabled(true)
      bla = false
    end)
  end
end
