zone = 0

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
			
				buffer_get_surface(roomChangeBuffer2, surface, 0,0,0)
			
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
	
function change_room(next_room, duration) {	
	roomChangeStage = 0
	roomDuration = duration
	roomChange = next_room
	roomChangeBuffer1 = buffer_create(room_width*room_height*4, buffer_grow, 1)
	roomChangeBuffer2 = buffer_create(room_width*room_height*4, buffer_grow, 1)
	roomDoorID = other.ID
	
	//	Take screenshot of current room
	var surface = surface_create(room_width,room_height)
	surface_set_target(surface)
	draw_clear_alpha(c_black, 0)
	draw_set_alpha(1)
	
	with class_unit if object_index != player draw_self()
	
	with block draw_self()
			
	//draw_surface(application_surface, 0,0)
	surface_reset_target()
			
	buffer_get_surface(roomChangeBuffer1, surface, 0,0,0)
			
	surface_free(surface)
	
				
	room_goto(roomChange)
}