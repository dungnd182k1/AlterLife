if (active)
{
	//control menu with keyboard
	hover += keyboard_check_pressed(vk_down) - keyboard_check_pressed(vk_up) // control which option that is pointed at
	if (hover > array_length(options)-1) hover = 0;
	if (hover < 0) hover = array_length(options)-1;
	
	// execute selected otion
	if (keyboard_check_pressed(vk_enter))
	{
		if (options[hover].func != undefined) && (options[hover].avail == true)
		{
			var _func = options[hover].func;
			if (options[hover].args != -1)
			{
				script_execute_ext(_func, options[hover].args);
			}
			if (options[hover].func == MenuGoBack)
			{
				MenuGoBack()
			}
		}
	}
	if (keyboard_check_pressed(vk_escape))
	{
		if (subMenuLevel > 0) MenuGoBack();
	}
}