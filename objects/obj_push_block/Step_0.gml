//check state
if (sliding == false)
{
	start_x = x;
	start_y = y;
	xspd = 0;
	yspd = 0;
} 

if (place_empty(x, y, obj_auto_slide_area))
{
	auto_slide = true;
} else {
	auto_slide = false;	
}

if (sliding == true)
{	
	//get 360 degree direction
	var _real_dir = dir * 90;
	
	//get target coordinates
	var _target_x_dist = lengthdir_x(grid_space, _real_dir);
	target_x = start_x + _target_x_dist;
	var _target_y_dist = lengthdir_y(grid_space, _real_dir);
	target_y = start_y + _target_y_dist;
	
	//set speeds
	var _target_dist = point_distance(x, y, target_x, target_y);
	var _final_speed = min(mspd, _target_dist);
	xspd = lengthdir_x(_final_speed, _real_dir);
	yspd = lengthdir_y(_final_speed, _real_dir);
	
	//cancel move if in auto slide area but target coordinates are not
	if (auto_slide == true) && (!place_meeting(target_x, target_y, obj_auto_slide_area))
	{
		xspd = 0;
		yspd = 0;
	}
	// wall check
	if place_meeting(target_x, target_y, obj_wall)
	{
		xspd = 0;
		yspd = 0;
	}
	
}

x += xspd;
y += yspd;

if (xspd == 0) && (yspd == 0)
{
	sliding = false;
}

depth = -bbox_bottom;







