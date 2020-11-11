creator = ""
version = ""

instance_create_layer(0,0,"Instances",game)
instance_create_layer(0,0,"Instances",debug)
instance_create_layer(0,0,"Instances",sound)

if room == RoomAppStart {
	room_goto(Room1)	
}