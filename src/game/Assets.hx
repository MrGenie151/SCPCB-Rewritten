package game;

import raylib.Raylib.*;
import raylib.Types;
import haxe.io.Path;

class Assets {

	static final assetsPath = "assets/";
	
	static var cachedImages : Map<String,Texture> = new Map<String,Texture>();

	static function getFilePath(filePath : String) {
		return Path.join([assetsPath,filePath]);
	}

	public static function getImage(imagePath) {
		var filePath = getFilePath("GFX/" + imagePath);
		if (cachedImages.exists(filePath)) {
			return cachedImages[filePath];
		} else {
			var texture = LoadTexture(filePath);
			cachedImages[filePath] = texture;
			return texture;
		}
	}

}
