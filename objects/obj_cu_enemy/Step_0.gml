event_inherited();
if ( hp <= 0)
{
	sprite_index = sprites.down;
	if (image_index >= image_number - 1)  { //checks if the animation ended
	    image_speed = 0;//stops the animation from looping
	}
} else {
	if (hit == true) {
		sprite_index = sprites.damaged;
		if (image_index >= image_number - 1)  { //checks if the animation ended
			hit = false;
			sprite_index = sprites.idle;
		}
	}
}