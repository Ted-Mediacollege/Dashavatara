package myth.entity.effects 
{
	import myth.entity.SimpleEntity
	import starling.display.Sprite;
	import treefortress.spriter.SpriterClip;
	import myth.graphics.AssetList;
	import starling.core.Starling;
	import myth.Main
	import treefortress.spriter.AnimationSet;
	public class deahtRunning extends SimpleEntity
	{
		private var image:SpriterClip;
		public function deahtRunning() 
		{
			//player art
			//image = AssetList.spriterLoader.getSpriterClip("");
			image = new SpriterClip(new AnimationSet(AssetList.assets.getXml("enemydeaths")), AssetList.assets.getTextureAtlas("common"));
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
			removeFromParent();
		}
		
	}

}