package myth.entity.player 
{
	import myth.graphics.TextureList;
	import starling.display.Image;
	/**
	 * ...
	 * @author Kit van de Bunt
	 */
	public class EntityPlayer02 extends EntityPlayerBase
	{
		public var image:Image;
		public function EntityPlayer02() 
		{
			super(true, false, true );
			image = new Image(TextureList.atlas_player.getTexture("player_2"));
			image.pivotX = image.width / 2;
			image.pivotY = image.height / 2;
			addChild(image);
		}
		
	}

}