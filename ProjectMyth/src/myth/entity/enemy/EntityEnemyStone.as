package myth.entity.enemy 
{
	import myth.entity.Entity;
	public class EntityEnemyStone extends Entity
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
		
		private var image:Image;
		public function EntityEnemyStone() {
			super(EnemyType.Stone_01);
			image = new Image(TextureList.assets.getTexture("rock_fallingdown"));
			artLayer.addChild(image);
			
			image.pivotX = image.width / 2;
			image.pivotY = image.height / 2;
			//image.rotation = Math.PI / 2;
		}
		
		override public function tick():void {
			super.tick();
			if(this.y <600){
				move();
			}
		}
		
		private function move():void {
			//this.x += MathHelper.RadianToDirection(this.rotation, 3*TimeHelper.deltaTimeScale).x;
			this.y += 20*TimeHelper.deltaTimeScale;
		}
	}
}