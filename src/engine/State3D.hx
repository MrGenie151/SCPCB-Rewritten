package engine;

import raylib.Raylib.*;
import raylib.Types;

class State3D extends State {

	public var guiMembers : List<Renderable2D> = new List<Renderable2D>();
	public var camera : Camera3D = new Camera3D();
	
	public function new() {
		super();
	}

	public function custom3DDraw() {
		// Function that states can override for custom 3D drawing
	}

	override function draw() {
		BeginMode3D(camera);
		super.draw();
		custom3DDraw();
		EndMode3D();

		for (member in guiMembers) {
			member.draw();
		}
	}

	public function add2D(member : Renderable2D, front : Bool = true) {
		if (front)
			guiMembers.add(member);
		else
			guiMembers.push(member);
	}

	public function remove2D(member : Renderable2D) {
		guiMembers.remove(member);
	}

}
