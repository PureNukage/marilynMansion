if debug.on visible = false
else visible = true

if instance_exists(fix.id) {
	if fix.id > -1 and fix.x > -1 and fix.y > -1 {
		x = fix.id.x + fix.x
		y = fix.id.y + fix.y
		x = clamp(x,fix.id.bbox_left,fix.id.bbox_right)
		y = clamp(y,fix.id.bbox_top,fix.id.bbox_bottom)
	}	
}

if sprite_index == s_bloodsquib and animation_end {
	image_index = image_number-1
	fix.id = -1
	depth = 5
}