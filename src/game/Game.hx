package game;

import game.states.*;
import engine.State;
import raylib.Raylib.*;
import raylib.Types;

class Game {

	static final clearColor : Color = new Color(0,0,0,1);
	public static var currentState(default,null) : State;

	static var CurTime : Int;
	static var PrevTime : Int = 0;
	static var LoopDelay : Int;
	public static var FPSfactor : Float;
	static var FPSfactor2 : Float;
	static var PrevFPSFactor : Float;

	static var CanSave = true;
	
	public static function init() {
		MusicManager.init();
		GameFonts.init();
		currentState = new TestState3D();
	}

	public static function update() {
		CurTime = Std.int(GetTime() * 1000);
		var ElapsedTime : Float = (CurTime - PrevTime) / 1000.0;
		PrevTime = CurTime;
		PrevFPSFactor = FPSfactor;
		FPSfactor = Math.max(Math.min(ElapsedTime * 70, 5.0), 0.2);
		FPSfactor2 = FPSfactor;
		
		MusicManager.update();
		currentState.update(GetFrameTime());
	}

	public static function draw() {
		ClearBackground(RAYWHITE);
		currentState.draw();
	}
}
