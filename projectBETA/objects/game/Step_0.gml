if roomChangeStage > -1 __change_room()

var clampX1 = 0
var clampX2 = room_width
var clampY1 = 0
var clampY2 = room_height

//	Looting
if playerInput.keyLoot and states == states.free {
	states = states.looting
	lootingClampX1 = camera_get_view_x(camera)
	lootingClampX2 = camera_get_view_x(camera) + camera_get_view_width(camera)
	lootingClampY1 = camera_get_view_y(camera)
	lootingClampY2 = camera_get_view_y(camera) + camera_get_view_height(camera)
	zoom_level = 0.7
}
else if states == states.looting looting()

if instance_exists(player) {
	if states == states.free {
		var Lerp = 0.05
		var xOffset = 0		// 262
		x = lerp(x, player.x + (player.image_xscale * xOffset), Lerp)
		y = lerp(y, player.y, Lerp)
		//x = player.x
		//y = player.y
	} else {
		var Lerp = 0.04
		if point_distance(x,y, mouse_x,mouse_y) >= 50 {
			//x = lerp(x, mouse_x, Lerp)
			//	y = lerp(y, mouse_y, Lerp)
			clampX1 = lootingClampX1
			clampX2 = lootingClampX2
			clampY1 = lootingClampY1
			clampY2 = lootingClampY2
		}
	}
}

////	Camera
//zoom_level = clamp((zoom_level + (mouse_wheel_down()-mouse_wheel_up())*0.1),0.25,1.0)

camera_set_view_pos(camera,
		clamp( camera_get_view_x(camera), 0, room_width - camera_get_view_width(camera) ),
		clamp( camera_get_view_y(camera), 0, room_height - camera_get_view_height(camera) ));

var view_w = camera_get_view_width(camera)
var view_h = camera_get_view_height(camera)

var rate = 0.2

var new_w = round(lerp(view_w, zoom_level *  default_zoom_width, rate))
var new_h = round(lerp(view_h, zoom_level * default_zoom_height, rate))
			
if new_w & 1 {
	new_w++	
}
if new_h & 1 {
	new_h++	
}

//	Middle Mouse Drag
if instance_exists(player) and states == states.looting {
	if playerInput.mouseMiddlePress and anchorX == -1 and !dragging {
		dragging = true
		anchorX = mouse_x
		anchorY = mouse_y
	} 
	if playerInput.mouseMiddle and dragging {
		var new_xview = camera_get_view_x(camera) + anchorX - mouse_x
		var new_yview = camera_get_view_y(camera) + anchorY - mouse_y
		new_xview = clamp(new_xview, clampX1, clampX2 - camera_get_view_width(camera))
		new_yview = clamp(new_yview, clampY1, clampY2-(camera_get_view_height(camera)))
		camera_set_view_pos(camera,new_xview,new_yview)
		var edgeX = camera_get_view_x(camera)+camera_get_view_width(camera)/2
		var edgeY = camera_get_view_y(camera)+camera_get_view_height(camera)/2
		x = edgeX
		y = edgeY
	}
	if playerInput.mouseMiddleRelease and anchorX > -1 {
		dragging = false
		anchorX = -1
		anchorY = -1
	}
}

camera_set_view_size(camera, new_w, new_h)

//	Realignment
var shift_x = camera_get_view_x(camera) - (new_w - view_w) * 0.5
var shift_y = camera_get_view_y(camera) - (new_h - view_h) * 0.5

camera_set_view_pos(camera,shift_x, shift_y)


////	Clamp app x,y within room
var edgeX = camera_get_view_width(camera)/2
var edgeY = camera_get_view_height(camera)/2
x = clamp(x,clampX1+edgeX,clampX2-edgeX)
y = clamp(y,clampY1+edgeY,clampY2-edgeY)