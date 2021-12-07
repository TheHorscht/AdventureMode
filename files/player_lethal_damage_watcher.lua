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
        ComponentSetValue2(comp, "frames", 0)
      end
    end
  end
  entity_set_component_value(entity_id, "DamageModelComponent", "is_on_fire", false)
end

local function entity_and_children_set_components_with_tag_enabled(entity_id, tag, enabled)
  EntitySetComponentsWithTagEnabled(entity_id, tag, enabled)
  for i, child in ipairs(EntityGetAllChildren(entity_id) or {}) do
    entity_and_children_set_components_with_tag_enabled(child, tag, enabled)
  end
end

function damage_received(damage, message, entity_thats_responsible, is_fatal, projectile_thats_responsible)
  if is_fatal and GlobalsGetValue("AdventureMode_respawn_in_progress", "0") == "0" then
    local respawn_x = tonumber(GlobalsGetValue("AdventureMode_respawn_x", "0"))
    local respawn_y = tonumber(GlobalsGetValue("AdventureMode_respawn_y", "0"))
    local entity_id = GetUpdatedEntityID()
    if respawn_x == 0 then
      entity_set_component_value(entity_id, "DamageModelComponent", "kill_now", true)
    end
    local x, y = EntityGetTransform(entity_id)
    GamePlaySound("data/audio/Desktop/player.bank", "player/death", x, y)
    GamePlaySound("data/audio/Desktop/event_cues.bank", "event_cues/game_over/create", x, y)
    local corpse = EntityLoad("mods/AdventureMode/files/player_corpse.xml", x, y)
    local player_vel_comp = EntityGetFirstComponentIncludingDisabled(entity_id, "VelocityComponent")
    local character_data_component = EntityGetFirstComponentIncludingDisabled(entity_id, "CharacterDataComponent")
    local vel_comp = EntityGetFirstComponentIncludingDisabled(corpse, "VelocityComponent")
    local vx, vy = ComponentGetValue2(player_vel_comp, "mVelocity")
    ComponentSetValue2(vel_comp, "mVelocity", vx, vy)
    ComponentSetValue2(character_data_component, "mVelocity", 0, 0)
    local disable_components = {
      "DamageModelComponent",
      "SpriteComponent",
      "PlatformShooterPlayerComponent",
      "CharacterPlatformingComponent",
      "ItemPickUpperComponent",
      "Inventory2Component",
      "InventoryGuiComponent",
      "SpriteParticleEmitterComponent",
    }
    -- "ParticleEmitterComponent",
    for i, comp_name in ipairs(disable_components) do
      entity_set_component_is_enabled(entity_id, comp_name, false)
    end
    EntitySetComponentsWithTagEnabled(entity_id, "jetpack", false)

    local active_item = get_active_item()
    if active_item > 0 then
      entity_and_children_set_components_with_tag_enabled(active_item, "enabled_in_hand", false)
    end

    -- Hide cape
    local cape_entity = EntityGetWithName("cape")
    EntityKill(cape_entity)
    
    -- Hide arm
    local arm_r_entity = EntityGetWithName("arm_r")
    local comp = EntityGetFirstComponentIncludingDisabled(arm_r_entity, "SpriteComponent")
    ComponentSetValue2(comp, "visible", false)
    EntityRefreshSprite(arm_r_entity, comp)

    -- Hide no-item arm
    local comp = EntityGetFirstComponentIncludingDisabled(entity_id, "SpriteComponent", "right_arm_root")
    ComponentSetValue2(comp, "visible", false)
    EntityRefreshSprite(entity_id, comp)

    GlobalsSetValue("AdventureMode_respawn_in_progress", "1")

    -- Remove heatstroke
    local heatstroke = get_child_with_name(entity_id, "heatstroke")
    if heatstroke then
      EntityKill(heatstroke)
    end

    -- Reset all game effects
    remove_game_effects(entity_id)

    set_controls_enabled(false)

    async(function()
      wait(180)
      remove_game_effects(entity_id)

      for i, comp_name in ipairs(disable_components) do
        entity_set_component_is_enabled(entity_id, comp_name, true)
      end
      local damage_model_component = EntityGetFirstComponentIncludingDisabled(entity_id, "DamageModelComponent")
      ComponentSetValue2(damage_model_component, "hp", ComponentGetValue2(damage_model_component, "max_hp"))

      if active_item > 0 then
        entity_and_children_set_components_with_tag_enabled(active_item, "enabled_in_hand", true)
      end

      -- Show cape
      EntitySetName(cape_entity, "cape")      
      local cape_entity = EntityLoad("data/entities/verlet_chains/cape/cape.xml", x, y)
      EntityAddChild(entity_id, cape_entity)
      
      -- Show arm
      local arm_r_entity = EntityGetWithName("arm_r")
      local comp = EntityGetFirstComponentIncludingDisabled(arm_r_entity, "SpriteComponent")
      ComponentSetValue2(comp, "visible", true)
      EntityRefreshSprite(arm_r_entity, comp)

      -- Show no-item arm
      local comp = EntityGetFirstComponentIncludingDisabled(entity_id, "SpriteComponent", "right_arm_root")
      ComponentSetValue2(comp, "visible", true)
      EntityRefreshSprite(entity_id, comp)

      EntitySetTransform(entity_id, respawn_x, respawn_y)
      GlobalsSetValue("AdventureMode_respawn_in_progress", "0")

      set_controls_enabled(true)
    end)
  end
end
