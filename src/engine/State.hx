package engine;

import raylib.Raylib.*;
import raylib.Types;

enum RenderMode {
	RENDERMODE_2D;
	RENDERMODE_3D;
}

class State {

	public var members : List<Renderable>;
	private var rendermode : RenderMode = RENDERMODE_2D;

	public function new() {
		members = new List<Renderable>();
	}

	public function update() {
		
	}

	public function draw() {
		for (member in members) {
			member.draw();
		}
	}

	public function add(member : Renderable, front : Bool = true) {
		if (front)
			members.add(member);
		else
			members.push(member);
	}
}
