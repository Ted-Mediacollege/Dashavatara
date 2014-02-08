package myth 
{
	import flash.events.Event;
	import myth.gui.game.GuiGame;
	import myth.gui.game.GuiMainMenu;
	import myth.gui.GuiScreen;
	import myth.input.KeyInput;
	import starling.display.Sprite;
	import myth.input.TouchInput;
	import myth.textures.TextureList;
	import starling.events.KeyboardEvent;
	import starling.events.Touch;
	import starling.events.TouchEvent;
	
	public class Main extends Sprite
	{
		public static var gui:GuiScreen;
		
		public var input:TouchInput;
		public var keyboard:KeyInput;
		
		public function Main() 
		{
			TextureList.load();
			
			input = new TouchInput();
			addEventListener(TouchEvent.TOUCH, input.onMouse);
			
			keyboard = new KeyInput();
			addEventListener(KeyboardEvent.KEY_DOWN, keyboard.onKeyDown);
			addEventListener(KeyboardEvent.KEY_UP, keyboard.onKeyUp);
			
			switchGui(new GuiMainMenu());
		}
		
		public function switchGui(newgui:GuiScreen):void
		{
			if (gui != null)
			{
				gui.destroy();
				removeChild(gui);
			}
			
			gui = newgui;
			addChild(newgui);
			gui.preInit(this);
			gui.init();
		}
		
		public static function onDeactivate(e:Event):void
		{
		}
	}
}