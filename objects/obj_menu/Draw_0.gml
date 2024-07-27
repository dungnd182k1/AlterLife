draw_sprite_stretched(spr_dialog_box, 0, x, y, widthFull, heightFull);
draw_set_color(c_white);
draw_set_font(fnM3x6);
draw_set_halign(fa_left);
draw_set_valign(fa_top);

var _desc = !(description == -1)
var _scrollPush = max(0, hover - (maxVisibleOptions - 1));

for (var i = 0; i < (maxVisibleOptions + _desc);  i++)
{
	if (i >= array_length(options)) break;
	draw_set_color(c_white)
	if (i == 0) && (_desc)
	{
		draw_text(x + xMargin, y + yMargin, description);
	} else {
		var _optionsToShow = i - _desc + _scrollPush;
		var _str = options[_optionsToShow].name;
		if (hover == _optionsToShow - _desc)
		{
			draw_set_color(c_yellow);
		}
		if (options[_optionsToShow].avail == false) draw_set_color(c_gray);
		draw_text(x + xMargin, y + yMargin + i * heightLine, _str)
	}
}

draw_sprite(spr_pointer, 0, x + xMargin + 8, y + yMargin + ((hover - _scrollPush) * heightLine) + 7);
if (maxVisibleOptions < array_length(options)) && (hover < array_length(options) - 1)
{
	draw_sprite(spr_down_arr, 0, (x + widthFull - 4) * 0.5, y + heightFull - 18);
}