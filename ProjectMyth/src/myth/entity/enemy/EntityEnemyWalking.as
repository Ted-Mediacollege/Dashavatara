package myth.entity.enemy 
{
	import starling.display.Shape;
	import flash.geom.Rectangle;
	import myth.graphics.TextureList;
	import starling.display.Image;
	import myth.util.Debug;
	import myth.Main;
	/**
	 * ...
	 * @author Kit van de Bunt
	 */
	public class EntityEnemyWalking extends EntityEnemyBase
	{
		
		private var image:Image;
		public function EntityEnemyWalking() 
		{
			super(EnemyType.Walking_01,128,200,-64,-200);
			var image:Image = new Image(TextureList.atlas_player.getTexture("player_3"));
			artLayer.addChild(image);
			image.pivotX = image.width / 2;
			image.pivotY = image.height;
		}
	}

}