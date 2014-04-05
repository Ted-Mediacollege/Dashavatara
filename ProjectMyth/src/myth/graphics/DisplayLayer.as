package myth.graphics 
{
	import starling.display.Sprite;
	
	public class DisplayLayer extends Sprite
	{
		private var privateLayerName:int;
		public function DisplayLayer(_layerName:int, _touchable:Boolean ) 
		{
			privateLayerName = _layerName;
			this.touchable = _touchable;
		}
		
		public function get layerName():int 
		{ 
			return privateLayerName; 
		} 
	}

}