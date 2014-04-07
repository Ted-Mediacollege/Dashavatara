package myth.gamemode.event 
{
	import myth.gamemode.GameModeEndless;
	import myth.util.MathHelper;
	
	public class EventPillarShort extends EventBase
	{
		public function EventPillarShort(gm:GameModeEndless) 
		{
			super(gm, 340 * gameMode.world.speed);
		}
			
		override public function init():void
		{
			var start:int = 1400;
			gameMode.world.objectManager.makeObject(0, gameMode.world.distance + start, 950);
			gameMode.world.objectManager.makeObject(0, gameMode.world.distance + start + 50 * gameMode.world.speed, 850);
			gameMode.world.objectManager.makeObject(0, gameMode.world.distance + start + (50 * gameMode.world.speed) * 2, 750);
		}
	
		override public function tick():void
		{
			
		}
	}
}