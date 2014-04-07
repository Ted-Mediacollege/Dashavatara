package myth.entity 
{
	import starling.display.Sprite;
	public class SimpleEntity extends Sprite
	{
		public var artLayer:Sprite = new Sprite();
		public var inUse = false;
		public function SimpleEntity() 
		{
			addChild(artLayer);
		}
		
	}

}