if roomChangeStage > -1 __change_room()

if !audio_is_playing(snd_wind) sound.playSoundEffect(snd_wind)

var clampX1 = 0
var clampX2 = room_width
var clampY1 = 0
var clampY2 = room_height

//	Looting
if (player.inventory[player.inventoryIndex].item != item.gun) and states == states.free {
	states = states.looting
	lootingClampX1 = camera_get_view_x(camera)
	lootingClampX2 = camera_get_view_x(camera) + camera_get_view_width(camera)
	lootingClampY1 = camera_get_view_y(camera)
	lootingClampY2 = camera_get_view_y(camera) + camera_get_view_height(camera)
	
	lootingClampX1 += -width
	lootingClampX2 += width
	
	zoom_level = 1
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
		x = lerp(x, player.x, Lerp)
		y = lerp(y, player.y, Lerp)
		
		//clampX1 = lootingClampX1
		//clampX2 = lootingClampX2
		//clampY1 = lootingClampY1
		//clampY2 = lootingClampY2
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