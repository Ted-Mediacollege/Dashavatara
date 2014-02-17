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
		public var image:Image = new Image(TextureList.atlas_player.getTexture("player_3"));
		public function EntityEnemyBase(_enemyType:int,_image:Image,_colWidth:int=80,_colHeight:int=80,_pivotX:int=-40,_pivotY:int=-40) 
		{
			super(_colWidth, _colHeight, _pivotX, _pivotY);
			image = _image;
			enemyType = _enemyType;
			
			artLayer.addChild(image);
			image.pivotX = image.width / 2;
			image.pivotY = image.height / 2;
			
		}
		
	}

}