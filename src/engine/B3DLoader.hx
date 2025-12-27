package engine;

import haxe.macro.Expr.Error;
import haxe.io.Bytes;
import raylib.Types;
import sys.io.File;
import sys.FileSystem;
import engine.Exceptions;

// We do need to add b3d loading, but I don't have the time nor energy right now.
class B3DLoader {
	static function loadMesh(filePath) {
		if (FileSystem.exists(filePath)) {
			var fileBytes : Bytes = File.getBytes(filePath);
			var newMesh = new Mesh();
			return new Model();
		} else {
			throw new FileNotValid("The file does not exist.");
		}
	}
}
