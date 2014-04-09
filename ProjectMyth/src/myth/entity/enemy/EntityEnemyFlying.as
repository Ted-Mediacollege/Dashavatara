package myth.entity.enemy 
{
	import starling.display.MovieClip;
	import starling.display.Shape;
	import flash.geom.Rectangle;
	import myth.graphics.AssetList;
	import starling.display.Image;
	import myth.Main;
	import myth.util.MathHelper;
	import myth.util.TimeHelper;
	import starling.core.Starling;
	
	public class EntityEnemyFlying extends EntityEnemyBase
	{
		public function EntityEnemyFlying() 
		{
			super(EnemyType.Flying_01,"enemyFlyHit2");
			health = 50;
			animationClip = new MovieClip(AssetList.assets.getTextures("FlyingEnemy"), 30);
			animationClip.x = 0;
			animationClip.y = 0;
			animationClip.loop = true;
			animationClip.play();
			Main.world.gameJuggler.add(animationClip);
			artLayer.addChild(animationClip);
			
			animationClip.pivotX = animationClip.width / 2;
			animationClip.pivotY = animationClip.height / 2;
			animationClip.rotation = Math.PI / 2;
			AssetList.soundCommon.playSound("enemyFlyHit");
			AssetList.setVolume();
		}
		
		override public function knockback():void {
			super.knockback();
		}
		
		override public function tick():void {
			super.tick();
			rotateToPlayer();
			moveToPlayer();
		}
		
		private function rotateToPlayer():void {
			if(this.x>Main.world.player.x){
				this.rotation = MathHelper.pointToRadian(this.x, Main.world.player.x, this.y, Main.world.player.y);
			}else {
				if(this.rotation > (-Math.PI/2+.25)){
					this.rotation = this.rotation - 0.05;
				}else if (this.rotation < (-Math.PI/2-.25)) {
					this.rotation = this.rotation + 0.05;
				}
			}
		}
		
		private function moveToPlayer():void {
			this.x += MathHelper.RadianToDirection(this.rotation, 3*TimeHelper.deltaTimeScale).x;
			this.y += MathHelper.RadianToDirection(this.rotation, 3*TimeHelper.deltaTimeScale).y;
		}
	}

}