dofile_once("data/scripts/lib/utilities.lua")

local entity_id = GetUpdatedEntityID()
local x, y = EntityGetTransform(entity_id)

local var_store_active = get_variable_storage_component(entity_id, "active")
ComponentSetValue2(var_store_active, "value_bool", true)
local torch = EntityGetAllChildren(entity_id)[1]
local particle_emitter_components = EntityGetComponentIncludingDisabled(torch, "ParticleEmitterComponent")
local light_component = EntityGetFirstComponentIncludingDisabled(torch, "LightComponent")
EntitySetComponentIsEnabled(torch, light_component, true)
local var_store_active = get_variable_storage_component(entity_id, "active")
ComponentSetValue2(var_store_active, "value_bool", true)
for i, comp in ipairs(particle_emitter_components) do
  ComponentSetValue2(comp, "is_emitting", true)
end
