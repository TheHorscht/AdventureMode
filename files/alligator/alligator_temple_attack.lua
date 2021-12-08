dofile_once("data/scripts/lib/utilities.lua")

local range = 20
local projectile_velocity = 20
local scatter = 0

local entity_id = GetUpdatedEntityID()
local pos_x, pos_y = EntityGetFirstHitboxCenter( entity_id )
local root_id = EntityGetRootEntity( entity_id )

-- locate nearest enemy
local enemy, enemy_x, enemy_y
local min_dist = 9999
for _,id in pairs(EntityGetInRadiusWithTag(pos_x, pos_y, range, "mortal")) do
	-- is target a valid enemy
	if EntityGetComponent(id, "GenomeDataComponent") ~= nil and EntityGetHerdRelation(root_id, id) < 40 then
		local x, y = EntityGetFirstHitboxCenter( id )
		local dist = get_distance(pos_x, pos_y, x, y)
		if dist < min_dist then
			min_dist = dist
			enemy = id
			enemy_x = x
			enemy_y = y
		end
	end
end

-- check los
local can_shoot = false
if enemy then can_shoot = not RaytraceSurfaces(pos_x, pos_y, enemy_x, enemy_y) end

-- hand/shooting state & animation control
-- edit_component2( entity_id, "SpriteComponent", function(comp,vars)
	-- -- if enemy is not visible then open hand
	-- local hand_open = ComponentGetValue2(comp, "rect_animation") == "stand"
	-- if not can_shoot then
		-- if not hand_open then
			-- ComponentSetValue2( comp, "rect_animation", "stand")
			-- --EntitySetComponentsWithTagEnabled( entity_id, "enabled_when_attacking", false )
		-- end
		-- return
	-- end

	-- -- prepare to shoot
	-- if hand_open then
		-- ComponentSetValue2( comp, "rect_animation", "attack")
		-- --EntitySetComponentsWithTagEnabled( entity_id, "enabled_when_attacking", true )
		-- can_shoot = false
		-- return
	-- end
-- end)

if not can_shoot then return end

-- direction
local vel_x, vel_y = vec_sub(enemy_x, enemy_y, pos_x, pos_y)
vel_x,vel_y = vec_normalize(vel_x, vel_y)

-- scatter
SetRandomSeed(pos_x + GameGetFrameNum(), pos_y)
vel_x,vel_y = vec_rotate(vel_x,vel_y, rand(-scatter, scatter))

-- apply velocity & shoot
vel_x,vel_y = vec_mult(vel_x,vel_y, projectile_velocity)

local distance = get_distance(pos_x, pos_y, enemy_x, enemy_y)

if distance < range then
	--animation
	local sprite_component = EntityGetFirstComponent(entity_id, "SpriteComponent")
	local animation = ComponentGetValue2( sprite_component, "rect_animation")

	ComponentSetValue2(sprite_component, "rect_animation", "attack")
	ComponentSetValue2(sprite_component, "next_rect_animation", "stand")

	--attack
	GamePlaySound("data/audio/Desktop/animals.bank", "animals/giantshooter/attack_bite", pos_x, pos_y)
	EntityInflictDamage( enemy, 2, "DAMAGE_SLICE", "Alligator Bite", "BLOOD_EXPLOSION", 0, 0, root_id, enemy_x, enemy_y, 1000)

end
