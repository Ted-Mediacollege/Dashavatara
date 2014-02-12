package myth.entity.enemy 
{
	import myth.entity.Entity;
	/**
	 * ...
	 * @author Kit van de Bunt
	 */
	public class EntityEnemyBase extends Entity
	{
		public var damage:int  = 10;
		public var enemyType:int;
		public function EntityEnemyBase(_enemyType:int) 
		{
			enemyType = _enemyType;
		}
		
	}

}