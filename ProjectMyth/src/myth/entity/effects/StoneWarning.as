package myth.entity.effects 
{
	import myth.entity.SimpleEntity;
	import starling.display.Image;
	import myth.graphics.AssetList;
	import myth.Main;
	import myth.util.TimeHelper;
	
	public class StoneWarning extends SimpleEntity
	{
		private var image:Image;
		private var scalePhase:int = 0;
		private var scale:Number = 0;
		public function StoneWarning() 
		{
			image = new Image(AssetList.assets.getTexture("warning icon"));
			artLayer.addChild(image);
			
			image.pivotX = image.width / 2;
			image.pivotY = image.height / 2;
			
			image.scaleX = scale;
			image.scaleY = scale;
		}
		
		public function tick():void {
			if (scalePhase == 0 ) {
				scale += 0.025 * TimeHelper.deltaTimeScale;
				image.scaleX = scale;
				image.scaleY = scale;
				if (scale > 1) {
					scalePhase ++;
				}
			}else if (scalePhase == 1) {
				scale += 0.1 * TimeHelper.deltaTimeScale;
				if (scale > 6) {
					scale = 1;
					scalePhase ++;
				}
			}else if (scalePhase == 2) {
				scale -= 0.1 * TimeHelper.deltaTimeScale;
				image.scaleX = scale;
				image.scaleY = scale;
				if (scale < 0) {
					Main.world.entityManager.removeWarning(this);
				}
			}
		}
	}
}