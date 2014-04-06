package myth.gamemode.event 
{
	import myth.gamemode.GameModeEndless;
	
	public class EventBase 
	{
		public var gameMode:GameModeEndless;
		public var distLeft:Number = 0;
		
		public function EventBase(gm:GameModeEndless, d:Number) 
		{
			gameMode = gm;
			distLeft = d;
		}
			
		public function init():void
		{
			
		}
	
		public function tick():void
		{
			
		}
	}
}