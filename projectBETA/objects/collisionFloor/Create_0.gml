Floor = 0

function create_floor() {
	var Width = abs(bbox_right-bbox_left)
	var Height = abs(bbox_bottom-bbox_top)
	
	var surfaceRaw = create_surface(room_width, room_height)
	var surfaceCrop = create_surface(Width, Height)
	surface_set_target(surfaceRaw)
	
	var ID = layer_tilemap_get_id("Tiles_floor")
	draw_tilemap(ID,0,0)
	
	surface_reset_target()
	
	surface_copy_part(surfaceCrop,0,0,surfaceRaw,x,y,Width,Height)
	
	floorSurfaceBuffer = buffer_create(Width*Height*4,buffer_grow,1)
	
	buffer_get_surface(floorSurfaceBuffer, surfaceCrop, 0)
	
	surface_free(surfaceRaw)
	surface_free(surfaceCrop)
	
}

function create_ceiling() {
	var Width = abs(bbox_right-bbox_left)
	var Height = abs(bbox_bottom-bbox_top)	
	
	var surfaceRaw = create_surface(room_width, room_height)
	var surfaceCrop = create_surface(Width, Height)
	surface_set_target(surfaceRaw)
	
	var ID = layer_tilemap_get_id("Tiles_ceiling")
	draw_tilemap(ID,0,0)
	
	surface_reset_target()
	
	surface_copy_part(surfaceCrop,0,0,surfaceRaw,x,y,Width,Height)
	
	ceilingSurfaceBuffer = buffer_create(Width*Height*4,buffer_grow,1)
	
	buffer_get_surface(ceilingSurfaceBuffer, surfaceCrop, 0)
	
	surface_free(surfaceRaw)
	surface_free(surfaceCrop)
}

create_floor()
create_ceiling()