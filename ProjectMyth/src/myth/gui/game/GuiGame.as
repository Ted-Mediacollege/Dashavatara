package myth.gui.game 
{
	import myth.gui.GuiScreen;
	import myth.Main;
	import myth.world.World;
	import starling.events.TouchEvent;
	import myth.gui.background.GuiBackground;
	
	public class GuiGame extends GuiScreen 
	{
		public function GuiGame() 
		{
			
		}	
		
		override public function init():void
		{
			var bg:GuiBackground = new GuiBackground();
			addChild(bg);
			
			Main.world = new World(this, "level_1");
			addChild(Main.world);
		}
		
		override public function tick():void
		{
			Main.world.tick();
		}
		
		override public function input(type:int, data:Vector.<Number>, e:TouchEvent):void 
		{
			Main.world.input(type, data, e);
		}
		
		override public function destroy():void
		{
			removeChild(Main.world);
			Main.world.onRemove();
			Main.world = null;
		}
	}
}