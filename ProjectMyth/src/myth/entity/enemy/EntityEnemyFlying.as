package myth.entity.enemy 
{
	import starling.display.MovieClip;
	import starling.display.Shape;
	import flash.geom.Rectangle;
	import myth.graphics.TextureList;
	import starling.display.Image;
	import myth.Main;
	import myth.util.MathHelper;
	import myth.util.TimeHelper;
	import starling.core.Starling;
	
	public class EntityEnemyFlying extends EntityEnemyBase
	{
		private var flyAnimation:MovieClip;
		public function EntityEnemyFlying() 
		{
			super(EnemyType.Flying_01);
			health = 50;
			flyAnimation = new MovieClip(TextureList.atlas_enemy.getTextures("FlyingEnemy"), 30);
			flyAnimation.x = 0;
			flyAnimation.y = 0;
			flyAnimation.loop = true;
			flyAnimation.play();
			Starling.juggler.add(flyAnimation);
			artLayer.addChild(flyAnimation);
			
			flyAnimation.pivotX = flyAnimation.width / 2;
			flyAnimation.pivotY = flyAnimation.height / 2;
			flyAnimation.rotation = Math.PI / 2;
		}
		
		override public function tick():void {
			super.tick();
			rotateToPlayer();
			moveToPlayer();
		}
		
		private function rotateToPlayer():void {
			this.rotation = MathHelper.pointToRadian(this.x, Main.world.player.x, this.y, Main.world.player.y);
		}
		
		private function moveToPlayer():void {
			this.x += MathHelper.RadianToDirection(this.rotation, 3*TimeHelper.deltaTimeScale).x;
			this.y += MathHelper.RadianToDirection(this.rotation, 3*TimeHelper.deltaTimeScale).y;
		}
	}

}