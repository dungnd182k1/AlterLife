
if (xspd != 0) or (yspd != 0)
{
	y_frame = dir;
	x_frame += anim_speed/room_speed;
	if (x_frame >= anim_length) x_frame = 0;
} else {
	x_frame = 0.9;
}

draw_sprite_part(spr_main_char_all,
				0, floor(x_frame) * frame_width,
				y_frame * frame_height,
				frame_width, frame_height, x, y);