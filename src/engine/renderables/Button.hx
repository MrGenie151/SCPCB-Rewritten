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

	public var clicked = false;
	
	public function new(text,x = 0,y = 0,xsize = 100, ysize = 500,font = null,textsize = 16.0) {
		this.text = text;
		this.position = new Vector2(x,y);
		this.font = font;
		this.textsize = textsize;
		size = new Vector2(xsize,ysize);
	}

	override function draw() {
		DrawRectangleV(position,size,BLACK);

		var textSizeish = MeasureTextEx(font,text,textsize,spacing);
		var textPosition = new Vector2((size.x / 2) - (textSizeish.x / 2), (size.y / 2) - (textSizeish.y / 2));

		if (font != null)
			DrawTextEx(font,text,textPosition,textsize,spacing,color);
		else
			DrawText(text,Std.int(textPosition.x),Std.int(textPosition.y),Std.int(textsize),color);
	}

	override function update(delta) {
		var rect = new Rectangle(position.x,position.y,size.x,size.y);
		var mousePos = GetMousePosition();
		if (CheckCollisionPointRec(mousePos,rect) && IsMouseButtonPressed(MOUSE_BUTTON_LEFT))
			clicked = true;
		else
			clicked = false;
	}

}
