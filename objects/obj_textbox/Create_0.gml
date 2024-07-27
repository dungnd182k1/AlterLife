owner_id = -1;

// Textbox params
textbox_width = 200;
textbox_height = 64;

border = 6;
line_sep = 12;
line_width = textbox_width - border * 2;

textbox_spr[0] = spr_dialog_box;
textbox_img = 0;
textbox_img_spd = 5/60;

//text
page = 0;
page_number = 0;
text[0] = "";
text_length[0] = string_length(text[0]);

char[0, 0] = "";
char_x[0, 0] = 0;
char_y[0, 0] = 0;

draw_char = 0;
text_spd = 1;

//options
options[0] = "";
option_link_ids[0] = -1;
option_pos = 0;
option_number = 0;

setup = false;

//sound (Only for extreme short sound)
sound_delay = 4;
sound_count = sound_delay;


//effects
src_set_defaults_for_text();
last_free_space = 0;

//pauses
text_pause_timer = 0;
text_pause_time = 16;










