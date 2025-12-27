package game.states;

import engine.renderables.Text;
import engine.renderables.GuiImage;
import engine.State;
import raylib.Raylib.*;
import raylib.Types;

// This is the main menu.
class MenuState extends State {

	public var MenuScale : Float;
	public var MenuBack : GuiImage;
	public var MenuText : GuiImage;
	public var MenuWhite : GuiImage;
	public var MenuStr : Text;

	public static var MainMenuOpen : Bool = true;
	public static var MenuOpen : Float;
	public static var StopHidingTimer : Int;
	public static var InvOpen : Float;
	//static var OtherOpen.Items = Null // No idea what the deal is with this variable yet, but it has to stay in the code.

	public static var SelectedEnding : String;
	public static var EndingScreen : Float;
	public static var EndingTimer : Int;

	public static var MsgTimer : Int;
	public static var Msg : String;
	public static var DeathMSG : String;

	public static var AccessCode : Float;
	public static var KeypadInput : String;
	public static var KeypadTimer : Int;
	public static var KeypadMSG : String;

	public static var DrawHandIcon : Float;

	public static var RandomSeed : Int;

	public static var SavePath : String = "Saves/";

	public static var MainMenuTab : Float = 0;

	override function create() {
		MenuScale = (GetScreenHeight() / 1024.0);
		MenuBack = new GuiImage("menu/back.jpg",0,0,MenuScale);
		MenuText = new GuiImage("menu/scptext.jpg",0,0,MenuScale);
		MenuWhite = new GuiImage("menu/menuwhite.jpg",0,0,MenuScale);
		MenuStr = new Text("Secure. Contain. Protect.",0,0,GameFonts.Font1);
		MenuStr.size = 50 * (GetScreenHeight() / 1024.0);
		//SetTextureWrap(MenuWhite,TEXTURE_WRAP_REPEAT);
		add(MenuBack);
		add(MenuText);
		add(MenuStr);
	}

	override function update(delta) {
		super.update(delta);
		var GraphicWidth = GetScreenWidth();
		var GraphicHeight = GetScreenHeight();

		ShowCursor();
		//DrawTextureEx(MenuBack,new Vector2(0,0),0,MenuScale,WHITE);
		//DrawTextureEx(MenuText,new Vector2(GetScreenWidth() / 2 - MenuText.width / 2, GetScreenHeight() - 20 * MenuScale - MenuText.height),0,MenuScale,WHITE);
		MenuText.position.x = GetScreenWidth() / 2 - MenuText.width / 2;
		MenuText.position.y = GetScreenHeight() - 20 * MenuScale - MenuText.height;

		if (GetScreenWidth() > 1240 * MenuScale) {
			//DrawTexturePro(MenuWhite, new Rectangle(0,5,512, 7 * MenuScale),new Rectangle(0,0,(GraphicWidth - 1240 * MenuScale) + 300, 7 * MenuScale),new Vector2(985.0 * MenuScale, 407.0 * MenuScale),0,WHITE);
		}
	}

}
