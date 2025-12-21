package game.states;

import engine.State3D;
import raylib.Raylib.*;
import raylib.Types;

class TestState3D extends State3D {
	
	override function create() {
		DisableCursor();
	}

	//override function draw() {
	//	BeginMode3D(camera);
	//	DrawGrid(10,1.0);
	//	DrawCircle3D(new Vector3(0,0,10),5.0,new Vector3(0,0,0),0,WHITE);
	//	EndMode3D();
	//}

	override function custom3DDraw() {
		DrawGrid(10,1.0);
		DrawCircle3D(new Vector3(0,0,0),5.0,new Vector3(0,0,0),0,WHITE);
	}

	override function update(delta:Single) {
		super.update(delta);
		UpdateCamera(camera,CAMERA_FREE);
		//trace(camera.position);
		if (IsKeyDown(KEY_ESCAPE))
			CloseWindow();
	}

}
