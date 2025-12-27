package engine.renderables;

import engine.Exceptions;
import raylib.Types;
import sys.io.File;
import sys.FileSystem;

class Room extends Renderable3D {

	var readPos = 0;

	public function new(rmeshFile : String) {
		loadRMesh(rmeshFile);
	}

	function readPascalString(bytes : haxe.io.Bytes) {
		var length = read32(bytes);
		var str = bytes.getString(readPos,length);
		readPos += length;
		return str;
	}

	function read32(bytes : haxe.io.Bytes) {
		var int = bytes.getInt32(readPos);
		readPos += 4;
		return int;
	}

	function read8(bytes : haxe.io.Bytes) {
		var int = bytes.get(readPos);
		readPos += 1;
		return int;
	}
	
	function loadRMesh(file) {
		if (FileSystem.exists(file)) {
			var fileBytes = File.getBytes(file);
			var isRmesh = readPascalString(fileBytes);
			trace(isRmesh);

			if (isRmesh != "RoomMesh" && isRmesh != "RoomMesh.HasTriggerBox")
				throw new IncorrectFormat("File is not an RMesh file.");

			var texCount = read32(fileBytes);
			trace(texCount);

			var surfaceMap : Map<String, String> = new Map<String, String>();
			var usedTextures : Array<String> = new Array<String>();

			for (i in 0...texCount) {

				var lmFlag = read8(fileBytes);
				trace(lmFlag);
				var lmName = "";

				if (lmFlag == 2)
					lmName = readPascalString(fileBytes);
				else
					read32(fileBytes);
				trace(lmName);

				var texflag = read8(fileBytes);
				trace(texflag);
			}
		} else {
			throw new FileNotValid("The file does not exist.");
		}
	}

}
