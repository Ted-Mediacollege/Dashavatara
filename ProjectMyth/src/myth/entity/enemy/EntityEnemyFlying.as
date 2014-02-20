package myth.entity.enemy 
{
	import starling.display.Shape;
	import flash.geom.Rectangle;
	import myth.graphics.TextureList;
	import starling.display.Image;
	import myth.Main;
	import myth.util.MathHelper;
	import myth.util.TimeHelper;
	
	public class EntityEnemyFlying extends EntityEnemyBase
	{
		private var image:Image;
		public function EntityEnemyFlying() 
		{
			super(EnemyType.Flying_01);
			var image:Image = new Image(TextureList.atlas_player.getTexture("player_1"));
			artLayer.addChild(image);
			image.pivotX = image.width / 2;
			image.pivotY = image.height / 2;
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