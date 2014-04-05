package myth.gamemode 
{
	import myth.world.World;
	
	public class GameMode 
	{
		public var world:World;
		
		public function GameMode() 
		{
		}
		
		public function preInit(w:World):void
		{
			world = w;
		}
		
		public function init():void
		{
		}
		
		public function build():void
		{
		}
		
		public function tick():void
		{
		}
		
		public function onRestart():void
		{
		}
		
		public function onPause():void
		{
		}
		
		public function onDeath():void
		{
		}
		
		public function onWin():void
		{
		}
		
		public function tutorialBuild():void
		{
		}		
		
		public function tutorialEnemyRemoved(killed:Boolean):void
		{
		}
		
		public function onClick(type:int, data:Vector.<Number>):void
		{
		}
		
		public function onButtonPress(buttonID:int):void
		{
		}
	}
}