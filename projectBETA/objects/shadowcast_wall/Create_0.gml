draw = true

ceiling = true

surfaceBuffer = -1

function create_Surface() {
	var Width = abs(bbox_right-bbox_left)
	var Height = abs(bbox_bottom-bbox_top)	
	
	var surfaceRaw = create_surface(room_width,room_height)
	var surface = create_surface(Width, Height)
	surface_set_target(surfaceRaw)
	
	var ID = layer_tilemap_get_id("Tiles_ceiling")
	draw_tilemap(ID,0,0)
	
	surface_reset_target()
	
	surface_copy_part(surface,0,0, surfaceRaw, bbox_left,bbox_top, Width,Height)
	
	surfaceBuffer = buffer_create(Width*Height*4, buffer_grow, 1)
	
	buffer_get_surface(surfaceBuffer, surface, 0)
	
	surface_free(surface)
	surface_free(surfaceRaw)
}

create_Surface()