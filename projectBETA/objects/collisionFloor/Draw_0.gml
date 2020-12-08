//	Draw floor
if player.bbox_top <= bbox_top {
	drawingCeiling = false
	var Width = abs(bbox_right-bbox_left)
	var Height = abs(bbox_bottom-bbox_top)
	
	var surface = create_surface(Width, Height)
	buffer_set_surface(floorSurfaceBuffer,surface,0)
	
	draw_surface(surface,x,y)
	
	surface_free(surface)
	
	//if place_meeting(x,y,class_unit) {
	//	var list = ds_list_create()
	//	var amount = instance_place_list(x,y,class_unit,list,true)
	//	for(var i=0;i<amount;i++) {
	//		var ID = list[| i]
	//		if ID.Floor < Floor ID.depth = 600
	//	}
	//}
	
	//if Floor > 0 {
	//	
	//}
	
}
 //	Draw ceiling
else  {
	drawingCeiling = true
	var Width = abs(bbox_right-bbox_left)
	var Height = abs(bbox_bottom-bbox_top)
	
	var surface = create_surface(Width, Height)
	buffer_set_surface(ceilingSurfaceBuffer,surface,0)
	
	draw_surface(surface,x,y)
	
	surface_free(surface)
}