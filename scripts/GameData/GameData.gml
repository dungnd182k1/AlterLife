// action data
global.actions = 
{
	attack:
	{
		name: "Attack",
		description: "{0} attacks!",
		width: 96-32,
		height: 96-32,
		subMenu: -1,
		targetRequired: true,
		targetEnemyByDefault: true,
		targetAll: MODE.NEVER,
		userAnimation: "attack",
		effectSprite: spr_pink_strike,
		effectOnTarget: MODE.ALWAYS,
		func : function(_user, _targets)
		{
			var _damage = ceil(_user.strength + random_range(_user.strength * -0.25,_user.strength * 0.25));
			combat_change_hp(_targets[0], -_damage, 0);
		}
	},
	tentacle_slam:
	{
		name: "Tentacle Slam",
		description: "{0} attacks!",
		width: 96,
		height: 96,
		subMenu: -1,
		targetRequired: true,
		targetEnemyByDefault: true,
		targetAll: MODE.NEVER,
		userAnimation: "tentacle_slam",
		effectSprite: spr_tentacle_slam,
		effectOnTarget: MODE.ALWAYS,
		func : function(_user, _targets)
		{
			var _damage = ceil(_user.strength + random_range(_user.strength * -0.25,_user.strength * 0.25));
			combat_change_hp(_targets[0], -_damage, 0);
		}
	},
	ice:
	{
		name: "Ice",
		description: "{0} cast Ice!",
		width: 96,
		height: 96,
		subMenu: "Magic",
		mpCost: 4,
		targetRequired: true,
		targetEnemyByDefault: true, // 0: party/self, 1: enemy
		targetAll: MODE.VARIES,
		userAnimation: "cast",
		effectSprite: spr_pink_strike,
		effectOnTarget: MODE.ALWAYS,
		func : function(_user, _targets)
		{
			for (var i = 0; i < array_length(_targets); i++)
			{
				var _damage = irandom_range(10, 15);
				if (array_length(_targets) > 1) _damage = ceil(_damage * 0.75)
				combat_change_hp(_targets[i], -_damage);
			}
			combat_change_mp(_user, -mpCost);
		}
	},
	create_minigame:
	{
		name: "Attack",
		description: "{0} create minigames!",
		width: 96-32,
		height: 96-32,
		subMenu: -1,
		targetRequired: true,
		targetEnemyByDefault: true,
		targetAll: MODE.NEVER,
		userAnimation: "attack",
		effectSprite: spr_pink_strike,
		effectOnTarget: MODE.ALWAYS,
		func : new_minigame
	}
	
}

enum MODE
{
	NEVER = 0,
	ALWAYS = 1,
	VARIES = 2,
}

//Party data
global.party = 
[
	{
		name: "Ari",
		hp: 50,
		hpMax: 50,
		mp: 20,
		mpMax: 20,
		strength: 20,
		sprites : { idle: spr_main_combat_idle, attack: spr_main_attack, cast: spr_main_combat_idle, down: spr_main_dead, damaged: spr_main_damaged},
		actions : [global.actions.attack, global.actions.create_minigame],
		hit : false,
		width: 32,
		height: 48,
	},
	/*{
		name: "Char_2",
		hp: 18,
		hpMax: 44,
		mp: 20,
		mpMax: 30,
		strength: 3,
		sprites : { idle: spr_main_char_idle, attack: spr_char_attack, cast: sAttackIce, down: spr_char_dead},
		actions : [global.actions.attack, global.actions.ice]
	}*/
]

//Enemy Data
global.enemies =
{
	EnemyG: 
	{
		name: "Holo",
		hp: 30,
		hpMax: 30,
		mp: 0,
		mpMax: 0,
		strength: 8,
		sprites: { idle: spr_holo_combat_idle, tentacle_slam: spr_holo_attack, down: spr_holo_dead, damaged: spr_holo_damaged},
		actions: [global.actions.tentacle_slam],
		xpValue : 15,
		AIscript : function()
		{
			var _action = actions[0];
			var _possibleTargets = array_filter(obj_combat.partyUnits, function(_unit, _index)
			{
				return (_unit.hp > 0);
			});
			var _target = _possibleTargets[irandom(array_length(_possibleTargets)-1)];
			return [_action, _target];
		},
		hit : false,
		width: 64,
		height: 64,
	},
	/*EnemyG_2: 
	{
		name: "Dark Knight 2",
		hp: 30,
		hpMax: 30,
		mp: 0,
		mpMax: 0,
		strength: 10,
		sprites: { idle: spr_enemy, attack: sAttackBonk},
		actions: [global.actions.attack],
		xpValue : 15,
		AIscript : function()
		{
			var _action = actions[0];
			var _possibleTargets = array_filter(obj_combat.partyUnits, function(_unit, _index)
			{
				return (_unit.hp > 0);
			});
			var _target = _possibleTargets[irandom(array_length(_possibleTargets)-1)];
			return [_action, _target];
		}
	}*/
}





