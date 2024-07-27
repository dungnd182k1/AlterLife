/*
	options form:
		[{"name", func, args, avail}, {...}]
Example:[{name: "attack", func: funcAttack, args: -1, avail: true}, {...}]	
*/


function Menu(_x, _y, _options, _description = -1, _width = undefined, _height = undefined)
{
	with (instance_create_depth(_x, _y, -99999, obj_menu))
	{
		options = _options;
		description = _description;
		var _optionsCount = array_length(_options);
		maxVisibleOptions = _optionsCount;
		
		// Set up size
		xMargin = 10;
		yMargin = 8;
		draw_set_font(fnM3x6)
		heightLine = 12;
		
		// auto width
		if (_width == undefined)
		{
			width = 1;
			if (description != -1) width = max(width, string_width(description));
			for (var i = 0; i < _optionsCount; i++)
			{
				width = max(width, string_width(options[i].name));
			}
			widthFull = width + xMargin * 2;
		} else {
			widthFull = _width
		}
		
		// auto height
		if (_height == undefined)
		{
			height = heightLine * (_optionsCount + !(description == -1));
			heightFull = height + yMargin * 2;
		} else {
			heightFull = _height
			//scrolling
			if (heightLine * (_optionsCount + !(description == -1)) > _height - yMargin * 2)
			{
				scrolling = true;
				maxVisibleOptions = (_height - yMargin * 2) div heightLine;
			}
		}
	}
}

function SubMenu(_options)
{
	// store old options in array and increase submenu level
	optionsAbove[subMenuLevel] = options;
	subMenuLevel++;
	options = _options;
	hover = 0;
}

function MenuGoBack()
{
	subMenuLevel--;
	options = optionsAbove[subMenuLevel];
	hover = 0;
}

function MenuSelectAction(_user, _action)
{
	with (obj_menu) active = false;
	with (obj_combat) 
	{	
		if (_action.targetRequired)
		{
			with (cursor)
			{
				active = true;
				activeAction = _action;
				targetAll = _action.targetAll;
				if (targetAll == MODE.VARIES) targetAll = true;
				activeUser = _user
				
				//which side to target by default?
				if (_action.targetEnemyByDefault)
				{
					targetIndex = 0;
					targetSide = obj_combat.enemyUnits;
					activeTarget = obj_combat.enemyUnits[targetIndex];
				} else { // target self by default
					targetSide = obj_combat.partyUnits;
					activeTarget = activeUser;
					var _findSelf = function(_element)
					{
						return (_element == activeTarget)
					}
					targetIndex = array_find_index(obj_combat.partyUnits, _findSelf);
				}
			}
		} else { // if no target, auto action and end the menu
			BeginAction(_user, _action, -1);
			with (obj_menu) instance_destroy();
		}
	}
}

function create_menu_option_struct(_name, _func, _args, _avail)
{
	return
	{
		name: _name,
		func: _func,
		args: _args,
		avail: _avail
	}
}

