creator = ""
version = ""

cameraRefresh = -1

instance_create_layer(0,0,"Instances",time)
instance_create_layer(0,0,"Instances",game)
instance_create_layer(0,0,"Instances",debug)
instance_create_layer(0,0,"Instances",sound)
instance_create_layer(0,0,"Instances",lighting)

if room == RoomAppStart {
	room_goto(Room1)
	cameraRefresh = 0
}