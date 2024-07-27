if (has_main_nearby == false) && (y_frame == 0)
{
	draw_self();
}

if (has_main_nearby == true)
{
	x_frame += anim_speed/room_speed;
	if (y_frame == 0) && (x_frame >= anim_length)
	{
		y_frame = 1;
		x_frame = 0;
	}
	if (x_frame >= anim_length) x_frame = 0;
	draw_sprite_part(spr_holo_all,
			0, floor(x_frame) * frame_width,
			y_frame * frame_height,
			frame_width,
			frame_height, x, y);
} else {
	if (y_frame != 0)
	{
		y_frame = 0;
		x_frame = anim_length - 1;
	}
	if (x_frame > 0)
	{
		x_frame -= anim_speed/room_speed;
	} else {
		x_frame = 0;
	}
}

draw_sprite_part(spr_holo_all,
			0, floor(x_frame) * frame_width,
			y_frame * frame_height,
			frame_width,
			frame_height, x, y);