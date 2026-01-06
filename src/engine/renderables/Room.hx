package engine.renderables;

import cpp.Pointer;
import haxe.io.Path;
import engine.Exceptions;
import raylib.Types;
import raylib.Raylib.*;
import raylib.Raymath.*;
import sys.io.File;
import sys.FileSystem;

typedef SurfaceData = {
	var indicies:Array<Int>;
	var pairs:Map<Int,Array<Dynamic>>;
}

class Room extends Renderable3D {

	var readPos = 0;
	var model : Model;

	public function new(rmeshFile : String) {
		var realPath = Path.withoutExtension(rmeshFile) + ".obj";
		position = new Vector3(0,0,0);
		rotation = new Vector3(0,0,0);
		model = LoadModel(realPath);
		for (i in 0...model.materialCount) {
			var material = model.materials[i];
			var texture = material.maps[MATERIAL_MAP_ALBEDO.toInt()].texture;
			SetTextureFilter(texture, TEXTURE_FILTER_BILINEAR);
		}
	}

	override function update(delta:Single) {
		super.update(delta);

		rotation.x += .1;
		model.transform = MatrixRotateXYZ(new Vector3(0,45 * DEG2RAD,0));
	}

	override function draw() {
		super.draw();

		DrawModel(model,position,1,WHITE);
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

	function createTriIndiciesPairs(verticies : Array<Vector3>, indicies : Array<Int>,data : Array<Array<Vector2>>) {
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

	function expandVector3Array(arr : Array<Vector3>) {
		var newArray = [];
		for (thing in arr) {
			newArray.push(thing.x);
			newArray.push(thing.y);
			newArray.push(thing.z);
		}
		return newArray;
	}
	function expandVector2Array(arr : Array<Vector2>) {
		var newArray = [];
		for (thing in arr) {
			newArray.push(thing.x);
			newArray.push(thing.y);
		}
		return newArray;
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

			//var meshs = new Array<Mesh>();

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
				if (!usedTextures.contains(texName))
					usedTextures.push(texName);

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

				//trace("Triangle Indicies: " + triIndicies.toString());
				//var surfaceMesh = new Mesh();
				//surfaceMesh.triangleCount = triCount;
				//surfaceMesh.vertexCount = vertexCount;
				//var vertexPointerArray = SinglePointer.fromValue(expandVector3Array(verticies));
				//surfaceMesh.vertices = vertexPointerArray;
				//var uvPointerArray = SinglePointer.fromValue(expandVector2Array(texUVs));
				//surfaceMesh.texcoords = uvPointerArray;

				//UploadMesh(surfaceMesh,true);
				//meshs.push(surfaceMesh);

			}
		} else {
			throw new FileNotValid("The file does not exist.");
		}
	}

}
