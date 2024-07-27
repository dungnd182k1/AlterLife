accept_key = keyboard_check_pressed(vk_space);

textbox_x = camera_get_view_x(view_camera[0]);
textbox_y = camera_get_view_y(view_camera[0]) + 120;

if (setup == false)
{
	setup = true;
	draw_set_font(global.font_main);
	draw_set_valign(fa_top);
	draw_set_halign(fa_left);
	
	//loop through the pages
	for (var p = 0; p < page_number; p++)
	{
		// count number of characters on each page and store it in text length array
		text_length[p] = string_length(text[p]);
		
		// get the x position for the textbox
		//char on the left
		text_x_offset[p] = 80;
		portrait_x_offset[p] = 8;
		//char on the right
		if (speaker_side[p] == -1)
		{
			text_x_offset[p] = 8;
			portrait_x_offset[p] = 216;
		}
		
		// no character ( center the text box)
		if (speaker_sprite[p] == noone)
		{
			text_x_offset[p] = 44;
		}
		
		//setting individual characters and finding where the lines of text should break
		for (var c = 0; c < text_length[p]; c++)
		{
			var _char_pos = c + 1;
			// store  individual characters into "char" array
			char[c, p] = string_char_at(text[p], _char_pos);
			
			// get cur with of line
			var _text_up_to_char = string_copy(text[p], 1, _char_pos)
			var _current_text_w = string_width(_text_up_to_char) - string_width(char[c, p]);
			
			// get the last free spce
			if (char[c, p] == " ")
			{
				last_free_space = _char_pos + 1;
			}
			
			//get the line break
			if (_current_text_w - line_break_offset[p] > line_width)
			{
				line_break_pos[line_break_num[p], p] = last_free_space;
				line_break_num[p]++;
				var _text_up_to_last_space = string_copy(text[p], 1, last_free_space);
				var _last_free_space_string = string_char_at(text[p], last_free_space);
				line_break_offset[p] = string_width(_text_up_to_last_space) - string_width(_last_free_space_string);
			}						
		}
		//getting each charraters coordinate
		for (var c = 0; c < text_length[p]; c++)
		{
			var _char_pos = c + 1;
			var _text_x = textbox_x + text_x_offset[p] + border;
			var _text_y = textbox_y + border;
			// get cur with of line
			var _text_up_to_char = string_copy(text[p], 1, _char_pos)
			var _current_text_w = string_width(_text_up_to_char) - string_width(char[c, p]);
			var _text_line = 0;
				
			// compensate for line breaks
			for (var lb = 0; lb < line_break_num[p]; lb++)
			{
				// if the current looping character is after a line break
				if (_char_pos >= line_break_pos[lb, p])
				{
					var _str_copy = string_copy(text[p], line_break_pos[lb, p] * 1, _char_pos - line_break_pos[lb, p]);
					_current_text_w = string_width(_str_copy);
					
					//record the "line" this charater should be on
					_text_line = lb + 1; // +1 since lb starts at 0
				}
			}
			// add to the x, y coor base on new info
			char_x[c, p] = _text_x + _current_text_w;
			char_y[c, p] = _text_y + _text_line * line_sep;
			
		}
	}
}

// typing the text
if (text_pause_timer <= 0)
{
	if (draw_char < text_length[page])
	{
		draw_char += text_spd;
		draw_char = clamp(draw_char, 0, text_length[page]);
		var _check_char = string_char_at(text[page], draw_char);
		if (_check_char == ".") || (_check_char == "!") || (_check_char == "?") || (_check_char == ",")
		{
			text_pause_timer = text_pause_time;
			if (!audio_is_playing(sounds[page]))
			{
				audio_play_sound(sounds[page], 8, false);
			}
		} else {
			//typing sound
			if (sound_count < sound_delay)
			{
				sound_count++;
			} else {
				sound_count = 0;
				audio_play_sound(sounds[page], 8, false);
			}
		}
	}
} else {
	text_pause_timer--;
}

// flip through the pages
if (accept_key)
{
	// if the typing is done
	if (draw_char == text_length[page])
	{
		//next page
		if (page < page_number - 1)
		{
			page++;
			draw_char = 0;
		} else {
			
			//link text for option
			if (option_number > 0)
			{
				create_textbox(option_link_ids[option_pos], owner_id)
			}
			
			// destroy textbox
			instance_destroy();
		}
	} else {
		// not done typing
		draw_char = text_length[page];
	}
}

// draw textbox
var _textbox_x = textbox_x + text_x_offset[page];
var _textbox_y = textbox_y;

textbox_img += textbox_img_spd;
textbox_spr_w = sprite_get_width(textbox_spr[page]);
textbox_spr_h = sprite_get_height(textbox_spr[page]);

//draw the speaker
if (speaker_sprite[page] != noone)
{
	sprite_index = speaker_sprite[page];
	if (draw_char == text_length[page]) image_index = 0;
	var _speaker_x = textbox_x + portrait_x_offset[page];
	if (speaker_side[page] == -1)
	{
		_speaker_x += sprite_width;
	}
	draw_sprite_ext(textbox_spr[page],textbox_img,
					textbox_x + portrait_x_offset[page],
					textbox_y, sprite_width/textbox_spr_w,
					sprite_height/textbox_spr_h,
					0, c_white, 1);
					
	draw_sprite_ext(sprite_index, image_index,
					_speaker_x, textbox_y,
					speaker_side[page],
					1, 0, c_white, 1);
}

// back of the textbox
draw_sprite_ext(textbox_spr[page], textbox_img,
				_textbox_x, _textbox_y,
				textbox_width/textbox_spr_w,
				textbox_height/textbox_spr_h,
				0, c_white, 1)

// options
if (draw_char == text_length[page] && page = page_number - 1)
{
	var _op_space = 15;
	var _op_border = 4;
	for (var op = 0; op < option_number; op++)
	{
		
		// option selection
		option_pos += keyboard_check_pressed(vk_down) - keyboard_check_pressed(vk_up);
		option_pos = clamp(option_pos, 0, option_number-1);
		
		
		// option box
		var _o_w = string_width(options[op]) + _op_border * 2;
		draw_sprite_ext(textbox_spr[page], textbox_img,
						_textbox_x + 16,
						_textbox_y - _op_space * option_number + _op_space * op,
						_o_w/textbox_spr_w,
						(_op_space-1)/textbox_spr_h,
						0, c_white, 1);
						
		// the pointer
		if (option_pos == op)
		{
			draw_sprite(spr_pointer, 0, _textbox_x + 24, _textbox_y - _op_space * option_number + _op_space * op + 4);
		}
						
		//option text
		draw_text(_textbox_x + 16 + _op_border,
				  _textbox_y - _op_space * option_number + _op_space * op + 4,
				  options[op]);
	};
}
				
// draw text
for (var c = 0; c < draw_char; c++)
{
	
	// floating text
	var _float_y = 0;
	if (float_text[c, page] == true)
	{
		float_dir[c, page] += -6;
		_float_y = dsin(float_dir[c, page])*1;
	}
	//shake text
	var _shake_x = 0;
	var _shake_y = 0;
	if (shake_text[c, page] == true)
	{
		shake_timer[c, page]--;
		if (shake_timer[c, page] <= 0)
		{
			shake_timer[c, page] = irandom_range(4, 8);
			shake_dir[c, page] = irandom(360);
		}
		_shake_x = lengthdir_x(1, shake_dir[c, page])
		_shake_y = lengthdir_y(1, shake_dir[c, page])
	}
	
	
	draw_text_color(char_x[c, page] + _shake_x, char_y[c, page] + _float_y + _shake_y, char[c, page],
					col_1[c, page], col_2[c, page], col_3[c, page],
					col_4[c, page], 1);
	
}
















