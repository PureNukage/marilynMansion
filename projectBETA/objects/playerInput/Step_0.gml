keyRight = keyboard_check(ord("D"))
keyLeft = keyboard_check(ord("A"))
keyUp = keyboard_check(ord("W"))
keyDown = keyboard_check(ord("S"))

mouseLeft = mouse_check_button(mb_left)
mouseLeftPress = mouse_check_button_pressed(mb_left)

mouseRight = mouse_check_button(mb_right)
mouseRightPress = mouse_check_button_pressed(mb_right)
mouseRightRelease = mouse_check_button_released(mb_right)

keyInteract = keyboard_check_pressed(ord("E"))

keyFlashlight = keyboard_check_pressed(ord("F"))

if keyboard_check_pressed(vk_space) {
	game_restart()	
}