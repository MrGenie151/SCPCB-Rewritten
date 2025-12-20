package engine.renderables;

import raylib.Raylib.*;
import raylib.Types;

class Text extends Renderable2D {

	public var text : String;
	public var font : Font;
	public var size : Float = 16;
	public var spacing : Float = 10;
	public var color : Color = new Color(255,255,255,255);
	
	public function new(text,x = 0,y = 0,font = null,size = 16) {
		this.text = text;
		this.position = new Vector2(x,y);
		this.font = font;
		this.size = size;
	}

	override function draw() {
		if (font != null)
			DrawTextEx(font,text,position,size,spacing,color);
		else
			DrawText(text,Std.int(position.x),Std.int(position.y),Std.int(size),color);
	}

}
