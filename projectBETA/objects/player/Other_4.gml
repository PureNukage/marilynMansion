flashlightOn = game.Player.flashlightOn
inventoryIndex = game.Player.inventoryIndex
change_inventory(inventoryIndex)

var old_xscale = image_xscale
image_xscale = game.Player.image_xscale
if old_xscale != image_xscale {
	var X = (x + (arm0_offsetX*old_xscale)) + lengthdir_x(50, gunRotation)
	var Y = y+arm0_offsetY + lengthdir_y(50, gunRotation)
	var newWidth = abs(X - (x + (arm0_offsetX*old_xscale)))
	var newX = (x + (arm0_offsetX*image_xscale)) + (image_xscale * newWidth)
	gunRotation = point_direction((x + (arm0_offsetX*image_xscale)),y+arm0_offsetY, newX,Y)
}
