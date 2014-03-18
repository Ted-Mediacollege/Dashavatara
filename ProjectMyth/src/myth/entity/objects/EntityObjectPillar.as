package myth.entity.objects 
{
	import myth.graphics.TextureList;
	import starling.display.Image;
	/**
	 * ...
	 * @author Kit van de Bunt
	 */
	public class EntityObjectPillar extends EntityObjectBase
	{
		
		public var image:Image;
		public function EntityObjectPillar() 
		{
			image = new Image(TextureList.assets.getTexture("sky_pilar"));
			image.pivotY = image.height;
			artLayer.addChild(image);
		}
		
	}

}