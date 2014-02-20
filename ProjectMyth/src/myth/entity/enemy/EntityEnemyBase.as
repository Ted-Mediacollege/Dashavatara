package myth.entity.enemy 
{
	import myth.entity.Entity;
	import starling.display.Image;
	import starling.display.Shape;
	import myth.graphics.TextureList;
	
	/**
	 * ...
	 * @author Kit van de Bunt
	 */
	public class EntityEnemyBase extends Entity
	{
		public var damage:int  = 10;
		public var enemyType:int;
		
		public function EntityEnemyBase(_enemyType:int,_colWidth:int=80,_colHeight:int=80,_pivotX:int=-40,_pivotY:int=-40) 
		{
			super(_colWidth, _colHeight, _pivotX, _pivotY);
			
			enemyType = _enemyType;
			
			
		}
		
	}

}