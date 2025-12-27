package engine.renderables;

import haxe.ds.Vector;
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

	function readFloat(bytes : haxe.io.Bytes) {
		var int = bytes.getFloat(readPos);
		readPos += 4;
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

				var texName = readPascalString(fileBytes);
				trace(texName);

				var texUVs = new Array<Vector2>();
				var lmUVs = new Array<Vector2>();

				var verticies = new Array<Vector3>();
				var vertexCount = read32(fileBytes);
				for (v in 0...vertexCount) {
					var vert = new Vector3(0,0,0);
					vert.x = readFloat(fileBytes);
					vert.y = readFloat(fileBytes);
					vert.z = -readFloat(fileBytes);

					verticies.push(vert);

					var texUV = new Vector2(0,0);
					var lmUV = new Vector2(0,0);
					texUV.x = readFloat(fileBytes);
					texUV.y = readFloat(fileBytes);
					lmUV.x = readFloat(fileBytes);
					lmUV.y = readFloat(fileBytes);

					texUVs.push(texUV);
					lmUVs.push(lmUV);
					readPos += 3;
				}

				var triCount = read32(fileBytes);
				var triIndicies = new Array<Int>();
				for (t in 0...triCount*3) {
					triIndicies.push(read32(fileBytes));
				}

			}
		} else {
			throw new FileNotValid("The file does not exist.");
		}
	}

}
