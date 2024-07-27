// @params: text_id

function src_game_text(_text_id)
{
	switch(_text_id)
	{
		case "Error machine":
			src_text("12312 312312 Error 31232131. 231.", "Error machine");
				src_text_color(13, 17, c_red, c_red, c_red, c_red);
				//src_text_float(13, 17);
				src_text_shake(13, 17);
			src_text("46 545 646 464 542 34234 23423 4234.", "Error machine - happy", -1);
			src_text("Now Die, Bitch!");
				src_option("Yeah, f*uck me pls!", "Error machine - yes");
				src_option("No.", "Error machine - no");
			break;
			case "Error machine - yes":
				src_text("f*ck you!!!");
				break;
			case "Error machine - no":
				src_text("f*ck you 22222!!!");
				break;
			
		case "Holo":
			src_text("Hello!");
			src_text("I'm your Guide.");
			src_text("Welcome to the amazin world of diconmetmay")
			break;
		case "":
			break;
	};
}