function new_encounter(_enemies, _bg)
{
		instance_create_depth
		(
			camera_get_view_x(view_camera[0]),
			camera_get_view_y(view_camera[0]),
			-9999,
			obj_combat,
			{ enemies: _enemies, creator: id, combat_bg: _bg} 
		);
	
}

function combat_change_hp(_target, _amount, _status = 0)
{
	// _status: 0 = ALive only, 1 = Dead only, 2 = any
	var _failed = false;
	if (_status == 0) && (_target.hp <= 0) _failed = true;
	if (_status == 1) && (_target.hp > 0) _failed = true;
	
	var _col = c_white;
	if (_amount > 0) _col = c_lime;
	if (_failed)
	{
		_col = c_white;
		_amount = "failed!";
	}
	instance_create_depth(_target.x + _target.width/2, _target.y +  + _target.height/2, _target.depth-1,
						  obj_combat_floating_text,
						  {font: fnM3x6, col: _col, text: string(_amount)});
	if (!_failed)
	{
		_target.hp = clamp(_target.hp + _amount, 0, _target.hpMax);
		//_target.hit = true;
	}
}

function combat_change_mp(_user, _amount)
{
	var _failed = false;
	if  (_user.mp <= 0) _failed = true;
	
	var _col = c_white;
	if (_amount > 0) _col = c_lime;
	if (_failed)
	{
		_col = c_white;
		_amount = 0;
	}
	/*instance_create_depth(_user.x, _user.y, _user.depth-1,
						  obj_combat_floating_text,
						  {font: fnM3x6, col: _col, text: string(_amount)});*/
	if (!_failed) _user.mp = clamp(_user.mp + _amount, 0, _user.mpMax);
}

function new_minigame()
{
	instance_create_depth
	(
		camera_get_view_x(view_camera[0]) * 3 / 2,
		camera_get_view_y(view_camera[0]) * 3 / 2,
		-999999,
		obj_audition
	);
}

