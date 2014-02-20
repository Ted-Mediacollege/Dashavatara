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
		
		private var image:Image;
		public var animationWalk:MovieClip;
			
		public function EntityEnemyWalking() 
		{
			super(EnemyType.Walking_01, 100, 170, -50, -170);
			
			animationWalk = new MovieClip(TextureList.atlas_enemyRunning.getTextures("RunningEnemy"), 30);
			animationWalk.x = 0;
			animationWalk.y = 0;
			animationWalk.pivotX = animationWalk.width / 2;
			animationWalk.pivotY = animationWalk.height;
			animationWalk.loop = true;
			animationWalk.play();
			Starling.juggler.add(animationWalk);
			artLayer.addChild(animationWalk);
			
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