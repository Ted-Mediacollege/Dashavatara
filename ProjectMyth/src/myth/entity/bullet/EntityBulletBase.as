package myth.entity.bullet 
{
	import myth.entity.Entity;
	/**
	 * ...
	 * @author Kit van de Bunt
	 */
	public class EntityBulletBase extends Entity
	{
		public var speed:Number;
		public function EntityBulletBase(_speed:Number = 5) 
		{
			speed = _speed;
		}
		
	}

}