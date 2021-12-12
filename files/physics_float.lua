dofile( "data/scripts/lib/utilities.lua" )

corners_in_water = 0

local entity_id = GetUpdatedEntityID()

local x, y, rot = EntityGetTransform( entity_id )

local square_vertex_distance = 12

--corners
local top_left_corner = { x = -1 * square_vertex_distance, y = -1 * square_vertex_distance }
local top_left_x, top_left_y = vec_rotate(top_left_corner.x, top_left_corner.y, rot)
top_left_x = x + top_left_x
top_left_y = y + top_left_y

local bottom_left_corner = { x = -1 * square_vertex_distance, y = square_vertex_distance }
local bottom_left_x, bottom_left_y = vec_rotate(bottom_left_corner.x, bottom_left_corner.y, rot)
bottom_left_x = x + bottom_left_x
bottom_left_y = y + bottom_left_y

local top_right_corner = { x = square_vertex_distance, y = -1 * square_vertex_distance }
local top_right_x, top_right_y = vec_rotate(top_right_corner.x, top_right_corner.y, rot)
top_right_x = x + top_right_x
top_right_y = y + top_right_y

local bottom_right_corner = { x = square_vertex_distance, y = square_vertex_distance }
local bottom_right_x, bottom_right_y = vec_rotate(bottom_right_corner.x, bottom_right_corner.y, rot)
bottom_right_x = x + bottom_right_x
bottom_right_y = y + bottom_right_y

--edges
local top_edge = { x = 0, y = -1 * square_vertex_distance }
local top_edge_x, top_edge_y = vec_rotate(top_edge.x, top_edge.y, rot)
top_edge_x = x + top_edge_x
top_edge_y = y + top_edge_y

local bottom_edge = { x = 0, y = square_vertex_distance }
local bottom_edge_x, bottom_edge_y = vec_rotate(bottom_edge.x, bottom_edge.y, rot)
bottom_edge_x = x + bottom_edge_x
bottom_edge_y = y + bottom_edge_y

local right_edge = { x = square_vertex_distance, y = 0 }
local right_edge_x, right_edge_y = vec_rotate(right_edge.x, right_edge.y, rot)
right_edge_x = x + right_edge_x
right_edge_y = y + right_edge_y

local left_edge = { x = -1 * square_vertex_distance, y = 0 }
local left_edge_x, left_edge_y = vec_rotate(left_edge.x, left_edge.y, rot)
left_edge_x = x + left_edge_x
left_edge_y = y + left_edge_y

function corner_in_liquid(corner_x, corner_y)

    local corner_in_water, hit_x, hit_y = RaytraceSurfacesAndLiquiform( corner_x, corner_y, corner_x, corner_y )
    local corner_in_solid, hit_x2, hit_y2 = RaytracePlatforms( corner_x, corner_y, corner_x, corner_y )

    if corner_in_water and not corner_in_solid then
        corners_in_water = corners_in_water + 1
    end
    
end

corner_in_liquid(top_left_x, top_left_y)
corner_in_liquid(top_right_x, top_right_y)
corner_in_liquid(bottom_left_x, bottom_left_y)
corner_in_liquid(bottom_right_x, bottom_right_y)

corner_in_liquid(top_edge_x, top_edge_y)
corner_in_liquid(bottom_edge_x, bottom_edge_y)
corner_in_liquid(left_edge_x, left_edge_y)
corner_in_liquid(right_edge_x, right_edge_y)

if corners_in_water > 3 then
    -- PhysicsApplyTorque(entity_id, -rot * 3)
    PhysicsApplyForce(entity_id, 0, -40)
end

--Check stuff to kill the entity if necessary
if GlobalsGetValue("AdventureMode_respawn_in_progress", "0") == "1" then

	local entity_id = GetUpdatedEntityID()
	GlobalsSetValue("AdventureMode_poison_challenge_in_progress", "0")
	
	EntityAddComponent( entity_id, "LuaComponent", 
	{ 
		script_source_file="mods/AdventureMode/files/alligator/kill_on_timer.lua",
		execute_every_n_frame = "240"
	} )
end