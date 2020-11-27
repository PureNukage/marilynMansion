myBodypart = -1
unit_index = -1

function spawn_ragdoll() {
	for(var b=0;b<array_length(bodyparts);b++) {
				
		var BodyPartEnum = bodyparts[b][bodyparts_enum]
		var BodyPartID = bodyparts[b][bodyparts_id]
		var BodyStruct = bodyparts[b][bodyparts_struct]
		var BodyPartFixture = bodyparts[b][bodyparts_fixture]
				
		var sprite = BodyStruct.sprite
		var fix_density = BodyStruct.fix_density
		var fix_friction = BodyStruct.fix_friction
		var fix_angle = BodyStruct.fix_angle
		var min_angle = BodyStruct.min_angle
		var max_angle = BodyStruct.max_angle 
		var angle = BodyStruct.angle
		var bind = BodyStruct.bind
				
		var _x = sprite_get_xoffset(sprite)
		var _y = sprite_get_yoffset(sprite)
				
		var _xx = (_x - 32) * image_xscale
		var _yy = (_y - 32)
				
		var BodyPart = instance_create_layer(x+_xx,y+_yy,"Instances",class_bodypart)
				
		BodyPart.bodypart = BodyPartEnum
		BodyPart.image_xscale = image_xscale
		BodyPart.spriteBase = sprite
		BodyPart.sprite = sprite
		BodyPart.sprite_index = sprite
		BodyPart.mask_index = sprite
		BodyPart.ragdoll = id
		if BodyPartEnum == bodypart.torso {
			BodyPart.depth = 1
			myBodypart = BodyPart	
		}
		if BodyPartEnum == bodypart.back_arm_upper BodyPart.depth = 2
		if BodyPartEnum == bodypart.back_arm_lower BodyPart.depth = 2
		if BodyPartEnum == bodypart.back_arm_hand BodyPart.depth = 2
				
		with BodyPart {
			fixture = physics_fixture_create()
					
			physics_fixture_set_density(fixture, fix_density)
			physics_fixture_set_friction(fixture, fix_friction)

			physics_fixture_set_polygon_shape(fixture)
			var x1 = -(x - bbox_left)
			var y1 = -(y - bbox_top)
			var x2 = (x - bbox_right)*-1
			var y2 = (y - bbox_bottom)*-1
			physics_fixture_add_point(fixture, x1, y1)
			physics_fixture_add_point(fixture, x2, y1)
			physics_fixture_add_point(fixture, x2, y2)
			physics_fixture_add_point(fixture, x1, y2)

			physics_fixture_set_collision_group(fixture, instance_number(class_ragdoll)*-1)
					
			physics_fixture_bind_ext(fixture, id, 0, 0)
					
			//debug.log(string(instance_number(class_ragdoll)*-1))
					
			if bind > -1 {
				physics_joint_revolute_create(id, other.bodyparts[bind][bodyparts_id], x, y, min_angle, max_angle, angle, 0, 0, 0, 0)	
			}
					
		}
				
		bodyparts[b][bodyparts_id] = BodyPart
		bodyparts[b][bodyparts_fixture] = BodyPart.fixture
				
	}	
}