package myth.entity.enemy 
{
	import myth.graphics.TextureList;
	import starling.display.Image;
	/**
	 * ...
	 * @author Kit van de Bunt
	 */
	public class EntityEnemyWalking extends EntityEnemyBase
	{
		public var image:Image;
		public function EntityEnemyWalking() 
		{
			super(EnemyType.Walking_01);
			image = new Image(TextureList.atlas_player.getTexture("player_1"));
			addChild(image);
		}
		
	}

}