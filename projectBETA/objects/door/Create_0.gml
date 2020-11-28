event_inherited()

Room = -1
ID = -1
locked = false

function interact(doorID) {
	if !locked {
		game.change_room(Room, 120, doorID)
		sound.playSoundEffect(snd_door)
	}
	
	else {
		if !audio_is_playing(snd_door_locked) sound.playSoundEffect(snd_door_locked)	
	}
}

function _lock(on_or_off) {
	if on_or_off {
		locked = true
		
		var Lock = instance_create_layer(x+5, y+35,"Instances",lock)
		Lock.myDoor = id
	}
	else {
		locked = false	
	}
}

depth = 200