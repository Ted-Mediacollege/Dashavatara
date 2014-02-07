package myth.gui.game 
{
	import myth.gui.GuiScreen;
	import myth.gui.components.GuiButton;
	import myth.input.TouchType;
	import myth.world.World;

	public class GuiGame extends GuiScreen
	{
		public var world:World;
		
		public function GuiGame() 
		{
			
		}
		
		override public function init():void 
		{ 
			world = new World();
			world.build();
		}
		
		override public function tick():void 
		{ 
			world.tick();
		}
		
		override public function input(type:TouchType, data:Vector.<Number>):void 
		{ 
			
		}
		
		override public function action(id:GuiButton):void 
		{ 
			
		}
		
		override public function destroy():void 
		{ 
			
		}
	}
}