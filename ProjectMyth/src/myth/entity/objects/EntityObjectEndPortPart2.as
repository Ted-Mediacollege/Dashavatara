package myth.entity.objects 
{
	import starling.display.Image;
	import myth.graphics.TextureList;
	/**
	 * ...
	 * @author Kit van de Bunt
	 */
	public class EntityObjectEndPortPart2 extends EntityObjectBase
	{
		
		public var image:Image;
		public function EntityObjectEndPortPart2() 
		{
			super(171, 425, 0, -425);
			image = new Image(TextureList.assets.getTexture("sky_gate_p2"));
			//image.color = 0x00ffff;
			image.pivotY = image.height;
			artLayer.addChild(image);
		}
		
	}

}