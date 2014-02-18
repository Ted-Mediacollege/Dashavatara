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
		public function EntityEnemyWalking() 
		{
			var img:Image = new Image(TextureList.atlas_player.getTexture("player_3"));
			super(EnemyType.Walking_01,img,128,200,-64,-100);
		}
	}

}