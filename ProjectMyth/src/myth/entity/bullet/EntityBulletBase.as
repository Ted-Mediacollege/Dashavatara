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
		public function EntityBulletBase(_speed:Number = 5,_colWidth:int=30,_colHeight:int=30,_pivotX:int=-15,_pivotY:int=-15)
		{
			super(_colWidth, _colHeight, _pivotX, _pivotY);
			speed = _speed;
		}
		
	}

}