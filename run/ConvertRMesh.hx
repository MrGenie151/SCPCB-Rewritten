package run;

import haxe.io.Path;
//import engine.Exceptions;
//import raylib.Types;
import sys.io.File;
import sys.FileSystem;

class Vector2 {
	public var x : Float;
	public var y : Float;

	public function new(ax,ay) {
		x = ax;
		y = ay;
	}
}

class Vector3 extends Vector2 {
	public var z : Float;

	public function new(ax,ay,az) {
		super(ax,ay);
		z = az;
	}
}

class Materials {
	public var mainMaterial : String;
	public var lightmapMaterial : String;

	public function new() {
		
	}
}

class ConvertRMesh {
	static var readPos = 0;

	static function readPascalString(bytes : haxe.io.Bytes) {
		try {
			var length = read32(bytes);
			var str = bytes.getString(readPos,length);
			readPos += length;
			return str;
		} catch(e) {
			trace("ack");
			trace(e.message);
			return "";
		}
	}

	static function read32(bytes : haxe.io.Bytes) {
		var int = bytes.getInt32(readPos);
		readPos += 4;
		return int;
	}

	static function read8(bytes : haxe.io.Bytes) {
		var int = bytes.get(readPos);
		readPos += 1;
		return int;
	}

	static function readFloat(bytes : haxe.io.Bytes) {
		var int = bytes.getFloat(readPos);
		readPos += 4;
		return int;
	}

	static function createTriIndiciesPairs(verticies : Array<Vector3>, indicies : Array<Int>,data : Array<Array<Vector2>>) {
		var pairs : Map<Int,Array<Dynamic>> = new Map<Int,Array<Dynamic>>();
		var correctArrayPos = -1;

		for (i in 0...indicies.length) {
			correctArrayPos += 1;
			if (!pairs.exists(indicies[i])) {
				pairs[indicies[i]] = new Array<Dynamic>();
				pairs[indicies[i]].push(verticies[correctArrayPos]);
				if (data != null && data.length > 0) {
					for (j in data) {
						pairs[indicies[i]].push(j[correctArrayPos]);
					}
				}
			} else {
				correctArrayPos--;
			}
		}

		return pairs;
	}

	static function expandVector3Array(arr : Array<Vector3>) {
		var newArray = [];
		for (thing in arr) {
			newArray.push(thing.x);
			newArray.push(thing.y);
			newArray.push(thing.z);
		}
		return newArray;
	}
	static function expandVector2Array(arr : Array<Vector2>) {
		var newArray = [];
		for (thing in arr) {
			newArray.push(thing.x);
			newArray.push(thing.y);
		}
		return newArray;
	}
	
	public static function convertRMesh(file) {
		readPos = 0;
		
		if (!FileSystem.exists(file)) return;

		var fileBytes = File.getBytes(file);
		var isRmesh = readPascalString(fileBytes);
		trace(isRmesh);

		if (isRmesh != "RoomMesh" && isRmesh != "RoomMesh.HasTriggerBox") {
			trace("File is not an RMesh file.");
			return;
		}
			//throw new IncorrectFormat("File is not an RMesh file.");

		var texCount = read32(fileBytes);
		trace(texCount);

		//var surfaceMap : Map<String, String> = new Map<String, String>();
		//var usedTextures : Array<String> = new Array<String>();

		var verticies = new Array<Vector3>();
		var texUVs = new Array<Vector2>();
		var lmUVs = new Array<Vector2>();
		var faces = new Array<Vector3>();
		var faceMaterials = new Array<String>();
		var materials : Map<String,Materials> = new Map<String,Materials>();

		//var meshs = new Array<Mesh>();

		for (i in 0...texCount) {

			var matName = "mesh" + i;

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
			materials[matName] = new Materials();
			materials[matName].mainMaterial = texName;
			materials[matName].lightmapMaterial = lmName;

			var vertIndicies = new Array<Int>();
			var vertexCount = read32(fileBytes);
			for (v in 0...vertexCount) {
				var vert = new Vector3(0,0,0);
				vert.x = readFloat(fileBytes);
				vert.y = readFloat(fileBytes);
				vert.z = -readFloat(fileBytes);

				verticies.push(vert);
				vertIndicies.push(verticies.length);

				var texUV = new Vector2(0,0);
				var lmUV = new Vector2(0,0);
				texUV.x = readFloat(fileBytes);
				texUV.y = 1.0 - readFloat(fileBytes);
				lmUV.x = readFloat(fileBytes);
				lmUV.y = 1.0 - readFloat(fileBytes);

				texUVs.push(texUV);
				lmUVs.push(lmUV);
				readPos += 3;
			}

			var triCount = read32(fileBytes);
			var triIndicies = new Array<Int>();
			for (t in 0...triCount) {
				var ind1 = read32(fileBytes);
				var ind2 = read32(fileBytes);
				var ind3 = read32(fileBytes);
				var newFace = new Vector3(vertIndicies[ind1],vertIndicies[ind2],vertIndicies[ind3]);
				faces.push(newFace);
				faceMaterials.push(matName);
			}

		}

		// TODO: Add entity support, for loading point entities.

		var realpath = Path.withoutExtension(file);
		var objPath = realpath + ".obj";
		var mtlPath = realpath + ".mtl";
		var mtlName = Path.withoutDirectory(realpath);
		
		var mtlOutput = File.write(mtlPath,false);
		mtlOutput.writeString("# Exported from RMESH with dual textures\n");
		for (name => material in materials) {
			mtlOutput.writeString("newmtl "+ name +"\n");
			mtlOutput.writeString("Kd 1.000 1.000 1.000\n");
			mtlOutput.writeString("Ka 1.000 1.000 1.000\n");
			mtlOutput.writeString("Ks 0.000 0.000 0.000\n");
			if (material.mainMaterial.length > 0)
				mtlOutput.writeString("map_Kd "+ material.mainMaterial +"\n");
			if (material.lightmapMaterial.length > 0)
				mtlOutput.writeString("map_Ka "+ material.lightmapMaterial +"\n");
		}
		mtlOutput.close();

		var objOutput = File.write(objPath,false);
		objOutput.writeString("# Converted from RMESH\n");
		objOutput.writeString("mtllib " + mtlName + "\n");
		for (v in verticies) {
			var x = v.x;
			var y = v.y;
			var z = v.z;
			objOutput.writeString('v $x $y $z\n');
		}
		
		for (uv in texUVs) {
			var u = uv.x;
			var v = uv.y;
			objOutput.writeString('vt $u $v\n');
		}

		var currentMaterial : Null<String> = null;
		for (i in 0...faces.length) {
			var face = faces[i];
			var mat = faceMaterials[i];

			if (mat != currentMaterial) {
				objOutput.writeString('usemtl $mat\n');
				currentMaterial = mat;
			}

			var f1 = face.x;
			var f2 = face.y;
			var f3 = face.z;

			objOutput.writeString('f $f1/$f1 $f3/$f3 $f2/$f2\n');
		}
		objOutput.close();
	}
}