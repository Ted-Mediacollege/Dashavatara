package myth.gui.game 
{
	import myth.gui.GuiScreen;
	import myth.Main;
	import myth.world.World;
	
	public class GuiGame extends GuiScreen 
	{
		public function GuiGame() 
		{
			
		}	
		
		override public function init():void
		{
			Main.world = new World(this, "level_1");
			addChild(Main.world);
		}
		
		override public function tick():void
		{
			Main.world.tick();
		}
		
		override public function destroy():void
		{
			removeChild(Main.world);
			Main.world.onRemove();
			Main.world = null;
		}
	}
}