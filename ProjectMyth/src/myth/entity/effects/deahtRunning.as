package myth.entity.effects 
{
	import myth.entity.SimpleEntity
	import starling.display.Sprite;
	import treefortress.spriter.SpriterClip;
	import myth.graphics.AssetList;
	import starling.core.Starling;
	import myth.Main
	import treefortress.spriter.AnimationSet;
	import myth.entity.SpriterClipPool;
	
	public class deahtRunning extends SimpleEntity
	{
		private var image:SpriterClip;
		public function deahtRunning() 
		{
			//player art
			//image = AssetList.spriterLoader.getSpriterClip("");
			image = SpriterClipPool.getClip();
			image.playbackSpeed = 1;
			//image.scaleX = 0.7;
			//image.scaleY = 0.7;
			image.play("running_death");
			addChild(image);
			Main.world.gameJuggler.add(image);
			image.animationComplete.add(
				function(clip:SpriterClip):void
				{
					remove();
				}
			);
			
			artLayer.addChild(image);
		}
		
		private function remove():void {
			SpriterClipPool.returnClip(image);
			removeFromParent();
		}
		
	}

}