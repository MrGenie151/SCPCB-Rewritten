package run;

import haxe.io.Path;
import sys.io.File;
import sys.io.Process;
import sys.FileSystem;
import run.ConvertRMesh;

class Tools {
	static function recursiveLoopForFileType(directory:String = "path/to/",fileType : String) {
		var foundFiles : Array<String> = [];
		if (sys.FileSystem.exists(directory)) {
			//trace("directory found: " + directory);
			for (file in sys.FileSystem.readDirectory(directory)) {
				var path = haxe.io.Path.join([directory, file]);
				var properPath = new Path(path);
				if (!sys.FileSystem.isDirectory(path)) {
					//trace("file found: " + path);
					if (properPath.ext == fileType)
						foundFiles.push(path);
					// do something with file
				} else {
					var directory = haxe.io.Path.addTrailingSlash(path);
					//trace("directory found: " + directory);
					var otherfoundFiles : Array<String> = recursiveLoopForFileType(directory,fileType);
					for (otherfile in otherfoundFiles) {
						foundFiles.push(otherfile);
					}
				}
			}
		} else {
			trace('"$directory" does not exists');
		}
		return foundFiles;
	}

	static function main() {
		var args = Sys.args();

		if (args[0] == "convert-rmeshes") {
			var rmeshes = recursiveLoopForFileType("assets/GFX/","rmesh");
			for (mesh in rmeshes) {
				ConvertRMesh.convertRMesh(mesh);
			}
		}
	}
}
