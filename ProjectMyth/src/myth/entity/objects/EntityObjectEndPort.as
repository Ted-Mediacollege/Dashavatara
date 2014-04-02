package myth.entity.objects 
{
	import starling.display.Image;
	import myth.graphics.AssetList;
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
			image = new Image(AssetList.assets.getTexture("sky_gate_p1"));
			//image.color = 0x00ffff;
			image.pivotY = image.height;
			artLayer.addChild(image);
		}
		
	}

}