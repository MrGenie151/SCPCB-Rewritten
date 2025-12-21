package engine.renderables;

import raylib.Raylib.*;
import raylib.Types;

class Button extends Renderable2D {
	
	public var text : String;
	public var font : Font;
	public var textsize : Float = 16;
	public var spacing : Float = 10;
	public var color : Color = new Color(255,255,255,255);
	public var size : Vector2;
	
	public function new(text,x = 0,y = 0,xsize = 100, ysize = 500,font = null,textsize = 16) {
		this.text = text;
		this.position = new Vector2(x,y);
		this.font = font;
		this.textsize = textsize;
		size = new Vector2(xsize,ysize);
	}

	override function draw() {
		DrawRectangleV(position,size,BLACK);

		if (font != null)
			DrawTextEx(font,text,position,textsize,spacing,color);
		else
			DrawText(text,Std.int(position.x),Std.int(position.y),Std.int(textsize),color);
	}

}
