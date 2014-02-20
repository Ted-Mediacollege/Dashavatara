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
		public function EntityBulletBase(_speed:Number = 5,_colWidth:int=70,_colHeight:int=114,_pivotX:int=-35,_pivotY:int=-57)
		{
			super(_colWidth, _colHeight, _pivotX, _pivotY);
			speed = _speed;
		}
		
	}

}