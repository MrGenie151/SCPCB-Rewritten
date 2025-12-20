package;

import game.Game;
import raylib.Raylib.*;
import raylib.Types;

class Main
{
	static final version : String = "0.0.1a";
    //------------------------------------------------------------------------------------
    // Program main entry point
    //------------------------------------------------------------------------------------
    public static function main():Void
    {
        // Initialization
        //--------------------------------------------------------------------------------------
        final screenWidth:Int = 1280;
        final screenHeight:Int = 720;
		final clearColor : Color = new Color(0,0,0,1);

        InitWindow(screenWidth, screenHeight, "SCP: Containment Breach v" + version);

        SetTargetFPS(60); // Set our game to run at 60 frames-per-second
		Game.init();
        //--------------------------------------------------------------------------------------

        // Main game loop
        while (!WindowShouldClose()) // Detect window close button or ESC key
        {
            // Update
            Game.update();

            // Draw
            //----------------------------------------------------------------------------------
            BeginDrawing();

            Game.draw();

            EndDrawing();
            //----------------------------------------------------------------------------------
        }

        // De-Initialization
        //--------------------------------------------------------------------------------------
        CloseWindow(); // Close window and OpenGL context
        //--------------------------------------------------------------------------------------
    }
}