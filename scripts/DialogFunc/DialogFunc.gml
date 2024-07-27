function src_set_defaults_for_text()
{
	line_break_pos[0, page_number] = 999;
	line_break_num[page_number] = 0;
	line_break_offset[page_number] = 0;
	
	//variable for single character
	for (var c = 0; c < 999; c++)
	{
		col_1[c, page_number] = c_white;
		col_2[c, page_number] = c_white;
		col_3[c, page_number] = c_white;
		col_4[c, page_number] = c_white;
		
		float_text[c, page_number] = 0;
		float_dir[c, page_number] = c*20;
		
		shake_text[c, page_number] = 0;
		shake_dir[c, page_number] = irandom(360);
		shake_timer[c, page_number] = irandom(4);
	}
	
	textbox_spr[page_number] = spr_dialog_box;
	speaker_sprite[page_number] = noone;
	speaker_side[page_number] = 1;
	
	sounds[page_number] = snd_default;
}

// text vfx

function src_text_color(_start, _end, _col1, _col2, _col3, _col4)
{
	for(var c = _start; c <= _end; c++)
	{
		col_1[c, page_number - 1] = _col1;
		col_2[c, page_number - 1] = _col2;
		col_3[c, page_number - 1] = _col3;
		col_4[c, page_number - 1] = _col4;
	}
}

function src_text_float(_start, _end)
{
	for(var c = _start; c <= _end; c++)
	{
		float_text[c, page_number - 1] = true;
	}
}

function src_text_shake(_start, _end)
{
	for(var c = _start; c <= _end; c++)
	{
		shake_text[c, page_number - 1] = true;
	}
}


/// @param text
/// @ param [character]
/// @ param [side]
function src_text(_text)
{
	src_set_defaults_for_text();
	text[page_number] = _text;
	
	if (argument_count > 1)
	{
		switch(argument[1])
		{
			case "Error machine":
				speaker_sprite[page_number] = spr_holo_combat_idle;
				textbox_spr[page_number] = spr_box;
				sounds[page_number] = snd_default;
				break;
			case "Error machine - happy":
				speaker_sprite[page_number] = spr_holo_idle;
				textbox_spr[page_number] = spr_dialog_box;
				sounds[page_number] = snd_default;
				break;
		}
	}
	//side char is on
	if (argument_count > 2)
	{
		speaker_side[page_number] = argument[2];
	}
	
	page_number++;
	
}

/// @param option
/// @param link_id
function src_option(_option, _link_id)
{
	options[option_number] = _option;
	option_link_ids[option_number] = _link_id;
	option_number++;
}

/// @param: text_id
/// @param: owner_id
function create_textbox(_text_id, _owner_id)
{
	with (instance_create_depth(0, 0, -99999, obj_textbox))
	{
		owner_id = _owner_id;
		src_game_text(_text_id)
	};
}