package myth.entity.enemy 
{
	import starling.display.Shape;
	import flash.geom.Rectangle;
	import myth.graphics.TextureList;
	import starling.display.Image;
	import myth.Main;
	import myth.util.MathHelper
	
	public class EntityEnemyFlying extends EntityEnemyBase
	{
		public function EntityEnemyFlying() 
		{
			var img:Image = new Image(TextureList.atlas_player.getTexture("player_1"));
			super(EnemyType.Flying_01,img);
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
			this.x += MathHelper.RadianToDirection(this.rotation, 3).x;
			this.y += MathHelper.RadianToDirection(this.rotation, 3).y;
		}
	}

}