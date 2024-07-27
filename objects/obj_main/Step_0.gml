key_up = keyboard_check(ord("W"));
key_down = keyboard_check(ord("S"));
key_left = keyboard_check(ord("A"));
key_right = keyboard_check(ord("D"));
interact_key_pressed = keyboard_check_pressed(ord("E"))

if (instance_exists(obj_textbox)) || (instance_exists(obj_pauser))
{
	xspd = 0;
	yspd = 0
	mspd = 0;
} else {
	yspd = key_down - key_up;
	xspd = key_right - key_left;
	mspd = spd;
}

var _inputD = point_direction(0,0,xspd,yspd);
var _inputM = point_distance(0,0,xspd,yspd);

if (xspd != 0) or (yspd != 0)
{
	//dir = point_direction(0, 0, xspd, yspd);
	dir = DirectionFunction(xspd, yspd);

	moveX = lengthdir_x(mspd * _inputM, _inputD);
	moveY = lengthdir_y(mspd * _inputM, _inputD);
	
	if place_meeting(x + moveX, y, obj_wall_par)
	{
		moveX = 0
	}
	if place_meeting(x, y + moveY, obj_wall_par)
	{
		moveY = 0
	}

	x += moveX;
	y += moveY;
}

if (interact_key_pressed == true)
{
	var _check_dir = dir * 90;
	
	// check push block
	var _check_x = x + lengthdir_x(interact_dist, _check_dir);
	var _check_y = y + lengthdir_y(interact_dist, _check_dir);
	var _push_block_instance = instance_place(_check_x, _check_y, obj_push_block);
	
	if instance_exists(_push_block_instance) && (_push_block_instance.sliding == false)
	{
		_push_block_instance.sliding = true;
		_push_block_instance.dir = dir;
	}
}



mask_index = spr_main_char_idle;
depth = -bbox_bottom;