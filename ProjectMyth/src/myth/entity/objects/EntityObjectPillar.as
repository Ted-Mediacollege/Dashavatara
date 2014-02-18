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
			image = new Image(TextureList.atlas_level.getTexture("pillar_1"));
			image.pivotY = image.height;
			artLayer.addChild(image);
		}
		
	}

}