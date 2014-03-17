package myth.graphics 
{
	import starling.display.DisplayObject;
	import myth.graphics.DisplayLayer;
	import starling.display.Sprite;
	
	public class Display
	{
		private static var layers:Vector.<DisplayLayer>;
		public static function InitGameLayers(parent:Sprite):void{
			layers = new Vector.<DisplayLayer>;
			layers.push(new DisplayLayer(LayerID.GameLevelBack));
			layers.push(new DisplayLayer(LayerID.GameLevel));
			layers.push(new DisplayLayer(LayerID.GamePlayer));
			layers.push(new DisplayLayer(LayerID.GameGui));
			layers.push(new DisplayLayer(LayerID.PauseGui));
			layers.push(new DisplayLayer(LayerID.PauseGui));
			
			for (var i:int = 0; i < layers.length; i++) {
				parent.addChild(layers[i]);
			}
		}
		
		public static function clearGameLayers(parent:Sprite):void{
			for (var i:int = 0; i < layers.length; i++) {
				layers[i].removeChildren(0, layers[i].numChildren);
			}
		}
		
		public static function add(add:DisplayObject, layerName:LayerID):void {
			for (var i:int = 0; i < layers.length; i++) {
				if(layerName == layers[i].layerName){
					layers[i].addChild(add);
					break;
				}
			}
		}
		
		public static function layerVisible(visible:Boolean, layerName:LayerID):void {
			for (var i:int = 0; i < layers.length; i++) {
				if(layerName == layers[i].layerName){
					layers[i].visible = visible;
					break;
				}
			}
		}
		
		private static function getLayer(layerName:LayerID):DisplayLayer {
			var returnLayer:DisplayLayer;
			for (var i:int = 0; i < layers.length; i++) {
				if(layerName == layers[i].layerName){
					returnLayer = layers[i];
					break;
				}
			}
			return returnLayer;
		}
	}

}