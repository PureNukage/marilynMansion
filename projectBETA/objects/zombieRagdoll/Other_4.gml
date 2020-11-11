//	Update bodyparts with fixture information
for(var b=0;b<array_length(bodyparts);b++) {
	var BodyPartEnum = bodyparts[b][bodyparts_enum]
	var BodyPartID = bodyparts[b][bodyparts_id]
	var BodyStruct = bodyparts[b][bodyparts_struct]
	
	var min_angle = BodyStruct.min_angle
	var max_angle = BodyStruct.max_angle
	var angle = BodyStruct.angle
	var bind = BodyStruct.bind
	
	physics_fixture_bind(bodyparts[b][bodyparts_fixture], BodyPartID)	
	
	with BodyPartID {
		if bind > -1 {
			physics_joint_revolute_create(id, other.bodyparts[bind][bodyparts_id], x, y, min_angle, max_angle, angle, 0, 0, 0, 0)	
		}	
	}
	
	//with BodyPartID {
	//	physics_fixture_bind(other.bodyparts[b][bodyparts_fixture], BodyPartID)	
	//}
	
	//var sprite = BodyStruct.sprite
	//var fix_width = BodyStruct.fix_width
	//var fix_height = BodyStruct.fix_height
	//var fix_offsetX = BodyStruct.fix_offsetX
	//var fix_offsetY = BodyStruct.fix_offsetY
	//var fix_density = BodyStruct.fix_density
	//var fix_friction = BodyStruct.fix_friction
	//var fix_angle = BodyStruct.fix_angle
	//var min_angle = BodyStruct.min_angle
	//var max_angle = BodyStruct.max_angle
	//var angle = BodyStruct.angle
	//var bind = BodyStruct.bind
	
	//with BodyPartID {
	//	fixture = physics_fixture_create()
					
	//	physics_fixture_set_density(fixture, fix_density)
	//	physics_fixture_set_friction(fixture, fix_friction)
	//	if BodyPartEnum != bodyParts.rightLegLower and BodyPartEnum != bodyParts.leftLegLower {
	//		physics_fixture_set_polygon_shape(fixture)
	//		physics_fixture_add_point(fixture, -fix_width/2, -fix_height/2)
	//		physics_fixture_add_point(fixture, fix_width/2, -fix_height/2)
	//		physics_fixture_add_point(fixture, fix_width/2, fix_height/2)
	//		physics_fixture_add_point(fixture, -fix_width/2, fix_height/2)
	//	} else {
	//		physics_fixture_set_circle_shape(fixture, 8)
	//	}
	//	//physics_fixture_set_collision_group(fixture, instance_number(zombieRagdoll)*-1)
					
	//	physics_fixture_bind_ext(fixture, id, -fix_offsetX * image_xscale, -fix_offsetY)
					
	//	debug.log(string(instance_number(zombieRagdoll)*-1))
					
	//	if bind > -1 {
	//		physics_joint_revolute_create(id, other.bodyparts[bind][bodyparts_id], x, y, min_angle, max_angle, angle, 0, 0, 0, 0)	
	//	}
	//}
}