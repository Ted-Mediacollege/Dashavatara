package myth.graphics 
{
	import starling.display.Sprite;
	
	public class DisplayLayer extends Sprite
	{
		private static var privateLayerName:LayerID;
		public function DisplayLayer(_layerName:LayerID) 
		{
			privateLayerName = _layerName;
		}
		
		public function get layerName():LayerID 
		{ 
			return privateLayerName; 
		} 
	}

}