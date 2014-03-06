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
		public function EntityBulletBase(_speed:Number = 5,_colWidth:int=114,_colHeight:int=70,_pivotX:int=-57,_pivotY:int=-35)
		{
			super(_colWidth, _colHeight, _pivotX, _pivotY);
			speed = _speed;
		}
		
	}

}