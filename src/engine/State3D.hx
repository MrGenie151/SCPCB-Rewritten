package engine;

import raylib.Raylib.*;
import raylib.Types;

class State3D extends State {

	public var members3D : List<Renderable3D> = new List<Renderable3D>();
	public var camera : Camera3D = new Camera3D();
	
	public function new() {
		super();
		camera.projection = CameraProjection.CAMERA_PERSPECTIVE;
		camera.fovy = 70;
		camera.position = new Vector3(0,0,0);
		camera.target = new Vector3(0.0, 0.0, 0.0); // Camera looking at point
		camera.up = new Vector3(0.0, 1.0, 0.0); // Camera up vector (rotation towards target)
	}

	public function custom3DDraw() {
		// Function that states can override for custom 3D drawing
	}

	override function draw() {
		super.draw();
		BeginMode3D(camera);
		for (member in members3D) {
			member.draw();
		}
		custom3DDraw();
		EndMode3D();

	}

	public function add2D(member : Renderable3D, front : Bool = true) {
		if (front)
			members3D.add(member);
		else
			members3D.push(member);
	}

	public function remove2D(member : Renderable3D) {
		members3D.remove(member);
	}

}
