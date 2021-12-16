dofile_once("mods/AdventureMode/files/util.lua")
dofile_once("mods/AdventureMode/lib/coroutines.lua")
dofile_once("data/scripts/status_effects/status_list.lua")

local function remove_game_effects(entity_id)
  local undetectable = {
    ALCOHOLIC = true,
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
    ADVENTUREMODE_SADNESS = true,
    ADVENTUREMODE_CANNIBALISM = true,
  }
  -- Some game effects have different IDs in the status list than the GameEffectComponents for some reason...
  local convert_ids = {
    POISONED = "POISON"
  }
  for i, effect in ipairs(status_effects) do
    if not undetectable[effect.id] then
      if convert_ids[effect.id] then
        effect.id = convert_ids[effect.id]
      end
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
    local x, y, _, scale_x = EntityGetTransform(entity_id)
    GamePlaySound("data/audio/Desktop/player.bank", "player/death", x, y)
    GamePlaySound("mods/AdventureMode/files/audio/AdventureMode.bank", "death_sound", x, y)
    local player_vel_comp = EntityGetFirstComponentIncludingDisabled(entity_id, "VelocityComponent")
    local character_data_component = EntityGetFirstComponentIncludingDisabled(entity_id, "CharacterDataComponent")
    local damage_model_component = EntityGetFirstComponentIncludingDisabled(entity_id, "DamageModelComponent")
    local corpse_spawner = EntityLoad("mods/AdventureMode/files/player_corpse_spawner.xml", x, y)
    local vx, vy = ComponentGetValue2(player_vel_comp, "mVelocity")
    set_var_store_float(corpse_spawner, "vel_x", vx)
    set_var_store_float(corpse_spawner, "vel_y", vy)
    set_var_store_int(corpse_spawner, "scale_x", scale_x)
    ComponentSetValue2(character_data_component, "mVelocity", 0, 0)
    local disable_components = {
      "DamageModelComponent",
      "SpriteComponent",
      "HitboxComponent",
      "GenomeDataComponent",
      "PlatformShooterPlayerComponent",
      "CharacterPlatformingComponent",
      "ItemPickUpperComponent",
      "Inventory2Component",
      "InventoryGuiComponent",
      "SpriteParticleEmitterComponent",
    }
	
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
    -- Remove SpriteStainsComponent and StatusEffectDataComponent to get rid of stains and effects
    -- Later re-add them on respawn. To do that, we save the values so we can re-set them to the same values later when adding the new component
    local sprite_stains_component = EntityGetFirstComponentIncludingDisabled(entity_id, "SpriteStainsComponent")
    local fade_stains_towards_srite_top, sprite_id, stain_shaken_drop_chance_multiplier
    if sprite_stains_component then
      fade_stains_towards_srite_top = ComponentGetValue2(sprite_stains_component, "fade_stains_towards_srite_top")
      sprite_id = ComponentGetValue2(sprite_stains_component, "sprite_id")
      stain_shaken_drop_chance_multiplier = ComponentGetValue2(sprite_stains_component, "stain_shaken_drop_chance_multiplier")
      EntityRemoveComponent(entity_id, sprite_stains_component)
    end

    local status_effect_data_component = EntityGetFirstComponentIncludingDisabled(entity_id, "StatusEffectDataComponent")
    if status_effect_data_component then
      EntityRemoveComponent(entity_id, status_effect_data_component)
    end

    -- Empty stomach
    local Ingestion_comp = EntityGetFirstComponentIncludingDisabled(entity_id, "IngestionComponent")
    if Ingestion_comp then
      EntityRemoveComponent(entity_id, Ingestion_comp)
      EntityAddComponent2(entity_id, "IngestionComponent", {
        ingestion_capacity=7500,
        overingestion_damage=0.002,
        blood_healing_speed=0.0016,
      })
    end

    set_controls_enabled(false)

    async(function()
      wait(180)
      remove_game_effects(entity_id)
      for i, comp_name in ipairs(disable_components) do
          entity_set_component_is_enabled(entity_id, comp_name, true)
      end
	  
      local sprite_comps = EntityGetComponent(entity_id, "SpriteComponent") or {}
      for i, sprite_comp in ipairs(sprite_comps) do
        EntityRefreshSprite(entity_id, sprite_comp)
      end
	
      -- Re-add components if they were removed (which they should, but it never hurts to double check)
      if sprite_stains_component then
        EntityAddComponent2(entity_id, "SpriteStainsComponent", {
          fade_stains_towards_srite_top=fade_stains_towards_srite_top,
          sprite_id=sprite_id,
          stain_shaken_drop_chance_multiplier=stain_shaken_drop_chance_multiplier
        })
      end
		
      if status_effect_data_component then
        EntityAddComponent2(entity_id, "StatusEffectDataComponent", {})
      end

      -- Heal to full hp
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