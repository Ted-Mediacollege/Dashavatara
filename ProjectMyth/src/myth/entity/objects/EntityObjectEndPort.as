package myth.entity.objects 
{
	import starling.display.Image;
	import myth.graphics.TextureList;
	/**
	 * ...
	 * @author Kit van de Bunt
	 */
	public class EntityObjectEndPort extends EntityObjectBase
	{
		
		public var image:Image;
		public function EntityObjectEndPort() 
		{
			super(171, 425, 0, -425);
			image = new Image(TextureList.atlas_level.getTexture("pillar_1"));
			image.color = 0x00ffff;
			image.pivotY = image.height;
			artLayer.addChild(image);
		}
		
	}

}