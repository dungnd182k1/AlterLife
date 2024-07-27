
// Draw background
draw_sprite(combat_bg, 0, x, y);

// Draw units in depth order
var _unitWithCurrentTurn = unitTurnOrder[turn].id;
for (var i = 0; i < array_length(unitRenderOrder); i++)
{
	with (unitRenderOrder[i])
	{
		draw_self();	
	}
	
}

// Draw ui box
draw_sprite_stretched(spr_dialog_box, 0, x+75,y+156, 213, 60)
draw_sprite_stretched(spr_dialog_box, 0, x,y+156, 74, 60)

//Positons
#macro COLUMN_ENEMY 15;
#macro COLUMN_NAME 90;
#macro COLUMN_HP 160;
#macro COLUMN_MP 220;

//Draw headings
draw_set_font(fnM3x6);
draw_set_halign(fa_left);
draw_set_valign(fa_top);
draw_set_color(c_gray);

column_enemy = x + COLUMN_ENEMY;
column_name = x + COLUMN_NAME;
column_hp = x + COLUMN_HP;
column_mp = x + COLUMN_MP;


draw_text(column_enemy, y+156, "ENEMY");
draw_text(column_name, y+156, "NAME");
draw_text(column_hp, y+156, "HP");
draw_text(column_mp, y+156, "MP");

// Draw enemies
draw_set_font(fnM3x6);
draw_set_halign(fa_left);
draw_set_valign(fa_top);
draw_set_color(c_white);

var draw_limit = 3
var _drawed = 0

for (var i = 0; i < array_length(enemyUnits) && _drawed < draw_limit; i++)
{
	var _enemy = enemyUnits[i]	
	if (_enemy.hp > 0)
	{
		_drawed++
		draw_set_color(c_white);
		if (_enemy.id == _unitWithCurrentTurn) draw_set_color(c_purple);
		
		draw_text(column_enemy, y+170+(i*12), _enemy.name);
	}
}	

for (var i = 0; i < array_length(partyUnits); i++)
{
	var _char = partyUnits[i];
	
	//Draw char name
	draw_set_color(c_white);
	if (_char.id == _unitWithCurrentTurn) draw_set_color(c_green);
	if (_char.hp <= 0) draw_set_color(c_red);
	draw_text(column_name, y+170+(i*12), _char.name);
	
	// Draw char hp
	draw_set_color(c_white);
	if (_char.hp <= _char.hpMax/2) draw_set_color(c_orange);
	if (_char.hp <= 0) draw_set_color(c_red);
	draw_text(column_hp, y+170+(i*12), string(_char.hp) + "/" + string(_char.hpMax));
	
	// Draw char mp
	draw_set_color(c_blue);
	if (_char.mp <= _char.mpMax/2) draw_set_color(c_orange);
	if (_char.mp <= 0) draw_set_color(c_red);
	draw_text(column_mp, y+170+(i*12), string(_char.mp) + "/" + string(_char.mpMax));
	
	draw_set_color(c_white);
}

// Draw target cursor
if (cursor.active)
{
	with (cursor)
	{
		if (activeTarget != noone)
		{
			if (!is_array(activeTarget))
			{
				draw_sprite(spr_pointer, 0, activeTarget.x + 24, activeTarget.y + 32);
			} else {
				draw_set_alpha(sin(get_timer()/50000)+1);
				for (var i = 0; i < array_length(activeTarget); i++)
				{
					draw_sprite(spr_pointer, 0, activeTarget[i].x + 24, activeTarget[i].y + 32);
				}
				draw_set_alpha(1);
			}
		}
	}
}

// Draw combat text
if (combatText != "")
{
	var _w = string_width(combatText) + 20;
	draw_sprite_stretched(spr_box, 0, x + 160 - (_w*0.5), y + 5, _w, 25);
	draw_set_halign(fa_center);
	draw_set_color(c_white);
	draw_text(x+160, y + 10, combatText);
}






