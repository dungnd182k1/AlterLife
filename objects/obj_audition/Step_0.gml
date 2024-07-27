key_up = keyboard_check_pressed(vk_up);
key_down = keyboard_check_pressed(vk_down);
key_left = keyboard_check_pressed(vk_left);
key_right = keyboard_check_pressed(vk_right);

for (var i = 0; i < array_length(buttons); i++)
{
	instance_create_depth(x + i * (button_sep + 64) , y, depth -10 ,buttons[i]);
}