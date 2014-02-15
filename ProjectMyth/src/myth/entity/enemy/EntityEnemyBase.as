package myth.entity.enemy 
{
	import myth.entity.Entity;
	import starling.display.Image;
	import starling.display.Shape;
	import flash.geom.Rectangle;
	import myth.util.Debug;
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
		public var hitArea:Rectangle;
		public var hitDraw:Shape = new Shape();
		public function EntityEnemyBase(_enemyType:int,_image:Image) 
		{
			image = _image;
			enemyType = _enemyType;
			
			addChild(image);
			image.pivotX = image.width / 2;
			image.pivotY = image.height / 2;
			addChild(hitDraw);
			
			hitArea = new Rectangle(image.x-image.pivotX, image.y-image.pivotY, image.width, image.height);
			Debug.test(function():void { 
				hitDraw.graphics.clear();
				hitDraw.graphics.lineStyle(10, 0x00ff00, 0.7);
				hitDraw.graphics.drawRect(hitArea.x, hitArea.y, hitArea.width, hitArea.height);
				hitDraw.graphics.endFill();
				hitDraw.graphics.drawCircle(image.x, image.y, 5);
			}, Debug.DrawArracks);
			
		}
		public function getRect():Rectangle {
			return new Rectangle(hitArea.x+this.x, hitArea.y+this.y, hitArea.width, hitArea.height);
		}
		
	}

}