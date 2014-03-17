package myth.graphics 
{
	import starling.display.Sprite;
	
	public class DisplayLayer extends Sprite
	{
		private var privateLayerName:int;
		public function DisplayLayer(_layerName:int) 
		{
			privateLayerName = _layerName;
		}
		
		public function get layerName():int 
		{ 
			return privateLayerName; 
		} 
	}

}