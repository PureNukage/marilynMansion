//	Draw floor
if player.bbox_top <= bbox_top {
	var Width = abs(bbox_right-bbox_left)
	var Height = abs(bbox_bottom-bbox_top)
	
	var surface = create_surface(Width, Height)
	buffer_set_surface(floorSurfaceBuffer,surface,0)
	
	draw_surface(surface,x,y)
	
	surface_free(surface)		
	
}
 //	Draw ceiling
else  {
	var Width = abs(bbox_right-bbox_left)
	var Height = abs(bbox_bottom-bbox_top)
	
	var surface = create_surface(Width, Height)
	buffer_set_surface(ceilingSurfaceBuffer,surface,0)
	
	draw_surface(surface,x,y)
	
	surface_free(surface)
}