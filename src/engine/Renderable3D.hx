package engine;

import raylib.Types;
import raylib.Raymath.DEG2RAD;

class Renderable3D extends Renderable {

	public var position : Vector3;
	public var rotation : Vector3;

	final DEG2RADVec = new Vector3(DEG2RAD,DEG2RAD,DEG2RAD);
	
}
