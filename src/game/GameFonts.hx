package game;

import raylib.Raylib.*;
import raylib.Types;

class GameFonts {

	public static var Font1 : Font;
	
	public static function init() {
		Font1 = LoadFont("assets/GFX/font/cour/Courier New.ttf");
	}

}
