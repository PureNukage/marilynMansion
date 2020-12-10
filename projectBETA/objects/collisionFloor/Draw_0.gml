//	Draw floor
if player.bbox_top <= bbox_top {
	var oldDrawing = drawingCeiling 
	
	drawingCeiling = false
	var Width = abs(bbox_right-bbox_left)
	var Height = abs(bbox_bottom-bbox_top)
	
	var surface = create_surface(Width, Height)
	buffer_set_surface(floorSurfaceBuffer,surface,0)
	
	draw_surface(surface,x,y)
	
	surface_free(surface)
	
	if oldDrawing != drawingCeiling {
		//lighting.refreshLights = true
		if instance_exists(class_light) with class_light create_light()
	}
	
}
 //	Draw ceiling
else  {
	var oldDrawing = drawingCeiling 
		
	drawingCeiling = true
	var Width = abs(bbox_right-bbox_left)
	var Height = abs(bbox_bottom-bbox_top)
	
	var surface = create_surface(Width, Height)
	buffer_set_surface(ceilingSurfaceBuffer,surface,0)
	
	draw_surface(surface,x,y)
	
	surface_free(surface)
	
	if oldDrawing != drawingCeiling {
		//lighting.refreshLights = true
		if instance_exists(class_light) with class_light create_light()
	}
}