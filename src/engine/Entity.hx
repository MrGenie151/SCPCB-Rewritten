package engine;

import raylib.Raylib.*;
import raylib.Types;

class Entity {
	private var visible : Bool = true;
	private var name : String = "Entity";
	private var model : Model;

	private var parent : Entity;
	private var children : List<Entity> = new List<Entity>();
	public static var orphans : List<Entity> = new List<Entity>();

	private var globalPosition : Vector3 = new Vector3(0,0,0);

	public function new( ?parent : Entity ) {
		if (parent != null)
			this.parent = parent;
	}

	public function render() {
		if (model != null) {
			DrawModel(model,globalPosition,1,RAYWHITE);
			for (child in children) {
				child.render();
			}
		}
	}

	public function isVisible() {
		return this.visible;
	}

}
