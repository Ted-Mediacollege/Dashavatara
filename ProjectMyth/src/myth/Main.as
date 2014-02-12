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
	import starling.events.EnterFrameEvent;
	import starling.events.KeyboardEvent;
	import starling.events.Touch;
	import starling.events.TouchEvent;
	import myth.util.TimeHelper;
	
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
			
			addEventListener(EnterFrameEvent.ENTER_FRAME, tick);
			
			switchGui(new GuiMainMenu());
		}
		
		public function tick(e:EnterFrameEvent):void
		{
			if (world != null)
			{
				world.tick();
			}
			else if (gui != null)
			{
				gui.tick();
			}
			TimeHelper.tick();
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
			
			world = new World(this);
			addChild(world);
			//world.build();
		}
		
		public function destroyWorld(newgui:GuiScreen):void
		{
			removeChild(world);
			world = null;
			
			switchGui(newgui);
		}
		
		public static function input(type:int, data:Vector.<Number>):void
		{
			if (world != null)
			{
				world.input(type, data);
			}
			else if (gui != null)
			{
				gui.touch(type, data);
			}
		}
		
		public static function onDeactivate(e:Event):void
		{
		}
	}
}