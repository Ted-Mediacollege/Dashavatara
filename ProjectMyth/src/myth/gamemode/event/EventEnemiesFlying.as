package myth.gamemode.event 
{
	import myth.gamemode.GameModeEndless;
	import myth.util.MathHelper;
	
	public class EventEnemiesFlying extends EventBase
	{
		public function EventEnemiesFlying(gm:GameModeEndless) 
		{
			super(gm, 420 * gm.world.speed);
		}
			
		override public function init():void
		{
			gameMode.world.entityManager.makeEnemy(2, 1400, 200);
			gameMode.world.entityManager.makeEnemy(2, 1600, 300);
			gameMode.world.entityManager.makeEnemy(2, 1800, 400);
		}
	
		override public function tick():void
		{
			
		}
	}
}