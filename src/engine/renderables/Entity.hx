package engine.renderables;

import raylib.Raylib.*;
import raylib.Types;

class Entity extends Renderable {
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

	override public function draw() {
		if (model != null) {
			DrawModel(model,globalPosition,1,RAYWHITE);
			for (child in children) {
				child.draw();
			}
		}
	}

	public function isVisible() {
		return this.visible;
	}

}
