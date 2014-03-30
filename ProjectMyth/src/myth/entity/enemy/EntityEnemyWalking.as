package myth.entity.enemy 
{
	import starling.display.MovieClip;
	import starling.display.Shape;
	import flash.geom.Rectangle;
	import myth.graphics.TextureList;
	import starling.display.Image;
	import myth.util.Debug;
	import myth.Main;
	import starling.core.Starling;
	import myth.util.MathHelper;
	import myth.util.TimeHelper;
	
	public class EntityEnemyWalking extends EntityEnemyBase
	{
		public function EntityEnemyWalking() 
		{
			super(EnemyType.Walking_01, 100, 170, -50, -170);
			health = 50;
			animationClip = new MovieClip(TextureList.assets.getTextures("RunningEnemy"), 30);
			animationClip.x = 0;
			animationClip.y = 0;
			animationClip.pivotX = animationClip.width / 2;
			animationClip.pivotY = animationClip.height;
			animationClip.loop = true;
			animationClip.play();
			Main.world.gameJuggler.add(animationClip);
			artLayer.addChild(animationClip);
			
			//var image:Image = new Image(TextureList.atlas_player.getTexture("player_3"));
			//artLayer.addChild(image);
			//image.pivotX = image.width / 2;
			//image.pivotY = image.height;
		}
		
		override public function tick():void {
			super.tick();
			move();
		}
		
		private function move():void {
			this.x -= 2*TimeHelper.deltaTimeScale;
		}
	}

}