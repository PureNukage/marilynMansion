function spawnRagdoll() {
	
	switch(object_index)
	{
		case zombieRagdoll:
			
			
			for(var b=0;b<array_length(bodyparts);b++) {
				
				var BodyPartEnum = bodyparts[b][bodyparts_enum]
				var BodyPartID = bodyparts[b][bodyparts_id]
				var BodyStruct = bodyparts[b][bodyparts_struct]
				
				var sprite = BodyStruct.sprite
				var fix_width = BodyStruct.fix_width
				var fix_height = BodyStruct.fix_height
				var fix_offsetX = BodyStruct.fix_offsetX
				var fix_offsetY = BodyStruct.fix_offsetY
				var fix_density = BodyStruct.fix_density
				var fix_friction = BodyStruct.fix_friction
				var min_angle = BodyStruct.min_angle
				var max_angle = BodyStruct.max_angle
				var angle = BodyStruct.angle
				var bind = BodyStruct.bind
				
				var _x = sprite_get_xoffset(sprite)
				var _y = sprite_get_yoffset(sprite)
				
				var _xx = (_x - 64) * image_xscale
				var _yy = (_y - 64)
				
				var BodyPart = instance_create_layer(x+_xx,y+_yy,"Instances",zombiePart)
				
				BodyPart.bodyParts = BodyPartEnum
				BodyPart.image_xscale = image_xscale
				BodyPart.spriteBase = sprite
				BodyPart.sprite = sprite
				BodyPart.sprite_index = sprite
				BodyPart.mask_index = sprite
				if BodyPartEnum == bodyParts.torso BodyPart.depth = 1
				
				with BodyPart {
					fixture = physics_fixture_create()
					
					physics_fixture_set_density(fixture, fix_density)
					physics_fixture_set_friction(fixture, fix_friction)
					physics_fixture_set_polygon_shape(fixture)
					physics_fixture_add_point(fixture, -fix_width/2, -fix_height/2)
					physics_fixture_add_point(fixture, fix_width/2, -fix_height/2)
					physics_fixture_add_point(fixture, fix_width/2, fix_height/2)
					physics_fixture_add_point(fixture, -fix_width/2, fix_height/2)
					physics_fixture_bind_ext(fixture, id, -fix_offsetX * image_xscale, -fix_offsetY)
					
					if bind > -1 {
						physics_joint_revolute_create(id, other.bodyparts[bind][bodyparts_id], x, y, min_angle, max_angle, angle, 0, 0, 0, 0)	
					}
				}
				
				bodyparts[b][bodyparts_id] = BodyPart
				
			}
			
			
			
		break
	}
	
}