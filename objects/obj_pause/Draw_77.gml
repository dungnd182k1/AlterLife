//Disable alpha blending
gpu_set_blendenable(false);

if (pause) // draw frozen image while pause
{
	surface_set_target(application_surface);
	if (surface_exists(pauseSurf)) draw_surface(pauseSurf, 0, 0);
	else {// restore from buffer if lost the surface
		pauseSurf = surface_create(resW, resH);
		buffer_set_surface(pauseSurfBuffer, pauseSurf, 0);
		
	}
	surface_reset_target();
}

if (keyboard_check_pressed(ord("P")))
{
	if (!pause)
	{
		pause = true;
		
		//deactivate everything other than this surface
		instance_deactivate_all(true);
		// things like: animating sprites, tiles, room bkgs need to deactivate separately
		
		//capture gamemoment (won't capture draw gui contents)
		pauseSurf = surface_create(resW, resH);
		surface_set_target(pauseSurf);
		draw_surface(application_surface, 0, 0);
		surface_reset_target();
		
		//backup
		if (buffer_exists(pauseSurfBuffer)) buffer_delete(pauseSurfBuffer);
		pauseSurfBuffer = buffer_create(resW * resH * 4, buffer_fixed, 1);
		buffer_get_surface(pauseSurfBuffer, pauseSurf, 0);
	} else {
		pause = false;
		instance_activate_all();
		if (surface_exists(pauseSurf)) surface_free(pauseSurf);
		if (buffer_exists(pauseSurfBuffer)) buffer_delete(pauseSurfBuffer);
	}
}

// enable alpha blending again
gpu_set_blendenable(true);