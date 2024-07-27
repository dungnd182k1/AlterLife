instance_deactivate_all(true);

// variables go here

_action = false;

units = [] // general units array: store all unit in combat
turn = 0;
unitTurnOrder = [];
unitRenderOrder = [];


default_enemy_x_pos = x + 216
default_enemy_y_pos = y + 75
default_party_x_pos = x + 72
default_party_y_pos = y + 75

turnCount = 0;
roundCount = 0;
combatWaitTimeFrames = 60;
combatWaitTimeRemaining = 0;
currentUser = noone;
currentAction = -1;
currentTargets = noone;

combatText = "";

// create cursor
cursor = {
	activeUser: noone,
	activeTarget: noone,
	activeAction: -1,
	targetSide: -1,
	targetIndex: 0,
	targetAll: false,
	confirmDelay: 0,
	active: false,
};


// create enemies

for (i = 0; i < array_length(enemies); i++)
{
	enemyUnits[i] = instance_create_depth(default_enemy_x_pos + (i * 10), 
										  default_enemy_y_pos + (i * 20),
										  depth-10,
										  obj_cu_enemy,
										  enemies[i]);
	array_push(units, enemyUnits[i]) // push new unit into general units array above
}

// same for party
for (i = 0; i < array_length(global.party); i++)
{
	partyUnits[i] = instance_create_depth(default_party_x_pos + (i * 10), 
										  default_party_y_pos + (i * 20),
										  depth-10,
										  obj_cu_party,
										  global.party[i]);
	array_push(units, partyUnits[i]) // push new unit into general units array above
}

//shuffle turn order
 unitTurnOrder = array_shuffle(units);
 
 // get render order
 
RefreshRenderOrder = function()
{
	unitRenderOrder = [];
	array_copy(unitRenderOrder, 0, units, 0, array_length(units));
	array_sort(unitRenderOrder, function(_1, _2)
	{
		return _1.y - _2.y;
	});
}
RefreshRenderOrder();

function CombatStateSelectAction()
{
	if (!instance_exists(obj_menu))
	{
		// get current unit
		var _unit = unitTurnOrder[turn];
	
		// check if unit is dead or cant act
		if (!instance_exists(_unit)) || (_unit.hp <= 0)
		{
			combatState = CombatStateVictoryCheck;
			exit;
		}
	
		// Select action to perform
		//BeginAction(_unit.id, global.actions.attack, _unit.id);
		if (_unit.object_index == obj_cu_party)
		{
			//compile the menu action
			var _menuOptions = [];
			var _subMenus = {};
			
			var _actionList = _unit.actions;
			for (var i = 0; i < array_length(_actionList); i++)
			{
				var _action = _actionList[i];
				var _available = true; // check mp cost
				var _nameAndCount = _action.name; // modify name include action count if it is an item
				if (_action.subMenu == -1)
				{
					array_push(_menuOptions, create_menu_option_struct(_nameAndCount, MenuSelectAction, [_unit, _action], _available));
				} else {
					// create or add submenu
					if (is_undefined(_subMenus[$ _action.subMenu]))
					{
						variable_struct_set(_subMenus, _action.subMenu, [create_menu_option_struct(_nameAndCount, MenuSelectAction, [_unit, _action], _available)]);
					} else {
						array_push(_subMenus[$ _action.subMenu], create_menu_option_struct(_nameAndCount, MenuSelectAction, [_unit, _action], _available));
					}
				}
			}
			// turn subMenu into an array
			var _subMenusArray = variable_struct_get_names(_subMenus)
			for (var i = 0; i < array_length(_subMenusArray); i++)
			{
				// sort submenu if needed
		
		
				//add back option at the end
				array_push(_subMenus[$ _subMenusArray[i]], create_menu_option_struct("Back", MenuGoBack, -1, true))
				// add submenu into main menu
				array_push(_menuOptions, create_menu_option_struct(_subMenusArray[i], SubMenu, [_subMenus[$ _subMenusArray[i]]], true))
			}
			Menu(x+10, y+150, _menuOptions, , 74, 60);
			
		} else {
			var _enemyAction = _unit.AIscript();
			if (_enemyAction != -1) BeginAction(_unit.id, _enemyAction[0], _enemyAction[1]);
		}
	}
}

function BeginAction(_user, _action, _targets)
{
	currentUser = _user;
	currentAction = _action;
	currentTargets =_targets;
	combatText = string_ext(currentAction.description, [currentUser.name]);
	if (!is_array(currentTargets)) currentTargets = [currentTargets];
	combatWaitTimeRemaining = combatWaitTimeFrames;
	with (_user)
	{
		acting = true;
		// check if the anim is define for that action and that user
		if (!is_undefined(_action[$ "userAnimation"])) && (!is_undefined(_user.sprites[$ _action.userAnimation]))
		{
			sprite_index = sprites[$ _action.userAnimation];
			image_index = 0;
		}
	}
	combatState = CombatStatePerformAction;
}

function CombatStatePerformAction()
{
	//check if animation etc is still playing
	if (currentUser.acting)
	{
		// perform effect when action end if exist
		if (currentUser.image_index >= currentUser.image_number - 1)
		{
			with (currentUser)
			{
				sprite_index = sprites.idle;
				image_index = 0;
				acting = false;
			}
		
			if (variable_struct_exists(currentAction, "effectSprite"))
			{
				if (currentAction.effectOnTarget == MODE.ALWAYS) || ((currentAction.effectOnTarget == MODE.VARIES) && (array_length(currentTargets) <= 1))
				{
					for (var i = 0; i < array_length(currentTargets); i++)
					{
						effect = instance_create_depth(currentTargets[i].x - currentAction.width/2 + 8,currentTargets[i].y - currentAction.height/2 + 8, currentTargets[i].depth - 1, obj_combat_effect, {sprite_index: currentAction.effectSprite});
						effect.target = currentTargets[i]
					}
				} else {
					var _effectSprite = currentAction._effectSprite
					if (variable_struct_exists(currentAction, "effectSprite")) _effectSprite = currentAction.effectSpriteNoTarget;
					effect = instance_create_depth(x - currentAction.width/2,y - currentAction.height/2,depth-100,obj_combat_effect,{sprite_index: _effectSprite});
				}
			}
			_action = true;
		}
	} else {
		if (!instance_exists(obj_combat_effect))
		{	
			if (_action == true)
			{
				currentAction.func(currentUser, currentTargets);
				_action = false;
			}
			combatWaitTimeRemaining--;
			if (combatWaitTimeRemaining == 0)
			{
				combatState = CombatStateVictoryCheck;
			}
		}
	}
}

function CombatStateVictoryCheck()
{
	var _remainParties = array_filter(obj_combat.partyUnits, function(_unit, _index)
	{
		return (_unit.hp > 0);
	});
	/*
	if (array_length(_remainParties) <= 0)
	{
		//game over scene
	}
	*/
	var _remainEnemies = array_filter(obj_combat.enemyUnits, function(_unit, _index)
	{
		return (_unit.hp > 0);
	});
	/*
	if (array_length(_remainEnemies) <= 0)
	{
		// destroy everythings related to combat and reactivated all the other objects
		// same as code below
	}
	*/
	if (array_length(_remainParties) > 0) && (array_length(_remainEnemies) > 0)
	{
		combatState = CombatStateTurnProgression;
	} else {
		with (obj_combat) instance_destroy();
		with (obj_cu_enemy) instance_destroy();
		with (obj_cu_party) instance_destroy();
		instance_activate_object(obj_main);
		instance_activate_object(obj_game);
		instance_activate_object(obj_wall);
		instance_activate_object(obj_holo);
	}
}

function CombatStateTurnProgression()
{
	combatText = "";
	turnCount++;
	turn++;
	
	if (turn > array_length(unitTurnOrder) - 1)
	{
		turn = 0;
		roundCount++;
	}
	combatState = CombatStateSelectAction;
}

combatState = CombatStateSelectAction;

