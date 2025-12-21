package engine;

import raylib.Raylib.*;
import raylib.Types;

enum RenderMode {
	RENDERMODE_2D;
	RENDERMODE_3D;
}

class State {

	public var members : List<Renderable2D>;
	private var rendermode : RenderMode = RENDERMODE_2D;
	public var alive(default, null) : Bool = true;

	public function new() {
		members = new List<Renderable2D>();
		create();
	}

	public function create() { // Function so states don't overwrite the new function
		
	}

	public function update(delta) {
		for (member in members) {
			member.update(delta);
		}
	}

	public function draw() {
		for (member in members) {
			member.draw();
		}
	}

	public function add(member : Renderable2D, front : Bool = true) {
		if (front)
			members.add(member);
		else
			members.push(member);
	}

	public function remove(member : Renderable2D) {
		members.remove(member);
	}
}
