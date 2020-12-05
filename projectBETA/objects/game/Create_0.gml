function scale_canvas(width, height) {
	window_set_size(width, height)	
}

depth = -300

cursor = -1

Player = {
	flashlightOn : false,
	inventoryIndex : 0,
	image_xscale : 1
}

states = states.free

lootingClampX1 = -1
lootingClampX2 = -1
lootingClampY1 = -1
lootingClampY2 = -1
lootingString = ""
lootingID = -1
lootingMoving = false
function looting() {
	
	//	Lets grab some stuff
	if (player.inventory[player.inventoryIndex].item != item.gun or player.states == states.free) {
		var old_mask_index = mask_index
		mask_index = cursor
		var ID = instance_position(mouse_x,mouse_y,class_grab)
		if ID > -1 {
			lootingString = object_get_name(ID.object_index)
			
			if playerInput.mouseLeftPress {
				if ID.object_index == candle {
					lootingID = ID
					lootingMoving = true
				}
				else if ID.object_index == door {
					lootingID = ID
					lootingMoving = true
				}
			}
		}
		else {
			lootingString = ""	
		}
		mask_index = old_mask_index
	}
	
}

function cameraSetup() {

		width = 320
		height = 180
		zoom_level = 1
		
		var fullscreen = false
		//var windowWidth = window_get_width()
		var windowHeight = window_get_height()
		//var displayWidth = display_get_width()
		var displayHeight = display_get_height()
		if window_get_width() == display_get_width() and (abs(windowHeight - displayHeight) < 100) {
			fullscreen = true
		}

		#region Views

			view_enabled = true
			view_visible[0] = true

			view_set_visible(0,true)

			view_set_wport(0,width)
			view_set_hport(0,height)

		#endregion
		#region Resize and Center Game Window

			if !fullscreen window_set_rectangle((display_get_width()-view_wport[0])*0.5,(display_get_height()-view_hport[0])*0.5,view_wport[0],view_hport[0])
			
			if !fullscreen window_center()
	
			surface_resize(application_surface,view_wport[0],view_hport[0])
	
			display_set_gui_size(width,height)


		#endregion
		#region Camera Create

			camera = camera_create()

			var viewmat = matrix_build_lookat(width,height,-10,width,height,0,0,1,0)
			var projmat = matrix_build_projection_ortho(width,height,1.0,32000.0)

			camera_set_view_mat(camera,viewmat)
			camera_set_proj_mat(camera,projmat)
	
			camera_set_view_pos(camera,x,y)
			camera_set_view_size(camera,width,height)
	
			camera_set_view_speed(camera,200,200)
			camera_set_view_border(camera,width,height)
	
			camera_set_view_target(camera,id)

			view_camera[0] = camera

		#endregion
	
		//if !fullscreen scale_canvas(1920,1080)
		if !fullscreen scale_canvas(1280, 720)

		default_zoom_width = camera_get_view_width(camera)
		default_zoom_height = camera_get_view_height(camera)

}
	
cameraSetup()

roomChangeStage = -1
roomChange = -1
roomChangeBuffer1 = -1
roomChangeBuffer2 = -1
roomDuration = -1
roomTime = 0
roomDoorID = -1
function __change_room() {
	
	switch(roomChangeStage) {
		case 0:			
			roomChangeStage = 1
			
			game.cameraSetup()
			
			//	Activate physics
			if instance_exists(zombiePart) with zombiePart {
				//if !phy_active phy_active = true
			}
			
			//	Move player to the door
			if instance_exists(door) with door if ID == other.roomDoorID {
				player.x = x	
			}
		break
		case 1:
			//	Take screenshot of new room
			if room == roomChange {
				var surface = surface_create(room_width,room_height)
				surface_set_target(surface)
				draw_clear_alpha(c_black, 0)
				draw_set_alpha(1)
				
				with class_unit if object_index != player draw_self()
	
				with block draw_self()
				
				//draw_surface(application_surface, 0,0)
				surface_reset_target()
			
				buffer_get_surface(roomChangeBuffer2, surface, 0)
			
				surface_free(surface)
			
				roomChangeStage = 2

			}
			
		break
		case 2:

			//	Done transitioning
			if roomTime >= roomDuration {
				roomChangeStage = -1
				roomChange = -1
				roomDuration = -1
				roomTime = 0
				roomDoorID = -1
				
				//	Clear buffers
				buffer_delete(roomChangeBuffer1)
				buffer_delete(roomChangeBuffer2)
				roomChangeBuffer1 = -1
				roomChangeBuffer2 = -1
			}
			else roomTime++
			
		break
	}
	
}
	
function change_room(next_room, duration, doorID) {	
	roomChangeStage = 0
	roomDuration = duration
	roomChange = next_room
	roomChangeBuffer1 = buffer_create(room_width*room_height*4, buffer_grow, 1)
	roomChangeBuffer2 = buffer_create(room_width*room_height*4, buffer_grow, 1)
	roomDoorID = doorID
	
	//	Player variables
	game.Player.image_xscale = player.image_xscale
	
	//	Take screenshot of current room
	var surface = surface_create(room_width,room_height)
	surface_set_target(surface)
	draw_clear_alpha(c_black, 0)
	draw_set_alpha(1)
	
	with class_unit if object_index != player draw_self()
	
	with block draw_self()
			
	//draw_surface(application_surface, 0,0)
	surface_reset_target()
			
	buffer_get_surface(roomChangeBuffer1, surface, 0)
			
	surface_free(surface)
	
				
	room_goto(roomChange)
}
	
////	Floors
floors[0][floor_floor] = "Tiles_2"
floors[0][floor_ceiling] = "Tiles_3"

floors[1][floor_floor] = "Tiles_Floor1_floor"
floors[1][floor_ceiling] = ""
floors[1][floor_ceiling_y] = 320
	
function floorManager() {
	//switch(player.Floor) {
	//	case 0:
	//		layer_set_visible("Tiles_Floor1_floor", false)
	//	break
	//	case 1:
	//		layer_set_visible("Tiles_Floor1_floor", true)
	//	break
	//}
	
	if player.Floor+1 <= array_length(floors)-1 {
		var playerVision = player.bbox_top + 8
		if playerVision <= floors[player.Floor+1][floor_ceiling_y] {
			layer_set_visible(floors[player.Floor+1][floor_floor], true)	
			layer_depth(floors[player.Floor+1][floor_floor], -10)
		}
	}
	
}