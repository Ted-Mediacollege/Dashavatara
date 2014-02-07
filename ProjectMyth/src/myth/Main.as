package myth 
{
	import flash.events.Event;
	import myth.gui.game.GuiGame;
	import myth.gui.game.GuiMainMenu;
	import myth.gui.GuiScreen;
	import myth.input.KeyInput;
	import starling.display.Sprite;
	import flash.events.TouchEvent;
	import myth.input.TouchInput;
	import starling.events.KeyboardEvent;
	
	public class Main extends Sprite
	{
		public static var gui:GuiScreen;
		
		public var mouse:TouchInput;
		public var keyboard:KeyInput;
		
		public function Main() 
		{
			input = new TouchInput();
			addEventListener(TouchEvent.TOUCH, input.onMouse);
			
			keyboard = new KeyInput();
			addEventListener(KeyboardEvent.KEY_DOWN, keyboard.onKeyDown);
			addEventListener(KeyboardEvent.KEY_UP, keyboard.onKeyUp);
			
			switchGui(new GuiGame());
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