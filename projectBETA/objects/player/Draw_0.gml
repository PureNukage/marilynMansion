switch(states)
{
	#region Free
		case states.free:
			
			if inventory[inventoryIndex].item == item.flashlight {
				if arm0 > -1 draw_sprite_ext(arm0,0,x + (arm0_offsetX*image_xscale), y + arm0_offsetY, 1, image_xscale,gunRotation,c_white,1)	
				
				draw_self()
				
				if arm1 > -1 draw_sprite_ext(arm1,0,x + (arm1_offsetX*image_xscale), y + arm1_offsetY, 1,image_xscale,gunRotation,c_white,1)	
			}
			else {
				draw_self()	
			}
		
		break
	#endregion
	
	#region Aim
		case states.aim:
		
			if mouse_x > x image_xscale = 1 else image_xscale = -1
			
			//sprite_index = s_player_body
		
			var index = 0
			if firingGun > -1 index = firingGun.image_index
			if arm0 > -1 draw_sprite_ext(arm0,index,x + (arm0_offsetX*image_xscale), y + arm0_offsetY, 1, image_xscale,gunRotation,c_white,1)	
		
			draw_sprite_ext(sprite_index,image_index,x,y,image_xscale,1,0,c_white,1)
			
			//	DEBUG find the x,y of the players handgun
			var rotation = gunRotation
			var _arm1 = arm1
			if inventory[inventoryIndex].item == item.gun {
				var x1 = x + (arm0_offsetX*image_xscale)
				var y1 = y + arm0_offsetY
				
				var x2 = x1 + lengthdir_x(20, gunRotation)
				var y2 = y1 + lengthdir_y(20, gunRotation)
				
				//draw_set_color(c_yellow)
				//draw_circle(x2,y2,4,false)
				rotation = point_direction(x + (arm1_offsetX*image_xscale),y + arm1_offsetY, x2,y2)
				
				if gunRotation > 30 and gunRotation < 140 {
					_arm1 = s_player_arm_side
					rotation = 0
					if image_xscale < 0 rotation = -180
				}
			}
			
			if arm1 > -1 draw_sprite_ext(_arm1,0, x + (arm1_offsetX*image_xscale), y + arm1_offsetY, 1,image_xscale,rotation,c_white,1)
		
		break	
	#endregion
	
	#region Reloading
		case states.reloading:
			
			draw_self()
			
		break
	#endregion	
}

if bulletArcDraw > 0 {
	bulletArcDraw--
	draw_set_color(c_yellow)
	var XX = x + (-8*image_xscale)
	var YY = y - 17
	var Direction = point_direction(bulletArray[2],bulletArray[3], bulletArray[0],bulletArray[1])
	XX += lengthdir_x(32, Direction)
	YY += lengthdir_y(32, Direction)
	if debug.on draw_line(XX,YY, bulletArray[0],bulletArray[1])
} else {
	bulletArcDraw = -1	
}

//reticle.firstCalculate()