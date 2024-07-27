if place_meeting(x, y, obj_main)
{
	has_main_nearby = true;
	if (keyboard_check_pressed(ord("E")))
	{
		create_textbox(name, id);
	}
} else {
	has_main_nearby = false;
}


depth = -bbox_bottom + frame_height/2;