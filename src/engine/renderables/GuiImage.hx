package engine.renderables;

import raylib.Raylib.*;
import raylib.Types;

class GuiImage extends Renderable2D {
	var imagePath : String;
	var texture : Texture;

	//public var position : Vector2;
	public var rotation : Float;
	public var scale : Float;
	public var tint : Color = WHITE;
	public var visible : Bool = true;

	public var width(default, null):Int;
	public var height(default, null):Int;

	public function new(newImagePath,x = 0,y = 0,scale = 1.0,rotation = 0.0) {
		imagePath = newImagePath;
		texture = LoadTexture(imagePath);

		position = new Vector2(x,y);
		this.scale = scale;
		this.rotation = rotation;

		width = texture.width;
		height = texture.height;
	}

	override function draw() {
		if (visible)
			DrawTextureEx(texture,position,rotation,scale,tint);
	}
}
