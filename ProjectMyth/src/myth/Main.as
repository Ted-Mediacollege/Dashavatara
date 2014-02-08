package myth 
{
	import flash.events.Event;
	import myth.gui.game.GuiMainMenu;
	import myth.gui.GuiScreen;
	import myth.input.KeyInput;
	import myth.world.World;
	import starling.display.Sprite;
	import myth.input.TouchInput;
	import myth.graphics.TextureList;
	import starling.events.KeyboardEvent;
	import starling.events.Touch;
	import starling.events.TouchEvent;
	
	public class Main extends Sprite
	{
		public static var gui:GuiScreen;
		public static var world:World;
		
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
		
		public function createWorld():void
		{
			if (gui != null)
			{
				gui.destroy();
				removeChild(gui);
				gui = null;
			}
			
			world = new World();
			addChild(world);
		}
		
		public function destroyWorld(newgui:GuiScreen):void
		{
			removeChild(world);
			world = null;
			
			switchGui(newgui);
		}
		
		public static function onDeactivate(e:Event):void
		{
			//saving
		}
	}
}