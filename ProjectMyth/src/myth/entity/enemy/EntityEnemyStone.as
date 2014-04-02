package myth.entity.enemy 
{
	import myth.entity.Entity;
	import starling.display.MovieClip;
	import starling.display.Shape;
	import flash.geom.Rectangle;
	import myth.graphics.AssetList;
	import starling.display.Image;
	import myth.Main;
	import myth.util.MathHelper;
	import myth.util.TimeHelper;
	import starling.core.Starling;
	
	public class EntityEnemyStone extends Entity
	{
		private var image:Image;
		private var spawnDelay:Number = 1.5;
		public var spawnd:Boolean = false;
		public var onGround:Boolean = false;
		
		public function EntityEnemyStone() {
			super(120, 120, -60, -60);
			image = new Image(AssetList.assets.getTexture("rock_fallingdown"));
			artLayer.addChild(image);
			
			image.pivotX = image.width / 2;
			image.pivotY = image.height / 2;
			//image.rotation = Math.PI / 2;
		}
		
		override public function tick():void {
			super.tick();
			if(spawnDelay>0){
				spawnDelay -= TimeHelper.deltaTime;
			}else {
				if (!spawnd) {
					spawnd = true;
				}
				if(this.y <600){
					move();
				}else {
					if (!onGround) {
						onGround = true;
						image.texture = AssetList.assets.getTexture("rock_down");
						image.readjustSize();
						image.pivotX = image.width / 2;
						image.pivotY = image.height / 2;
					}
				}
			}
		}
		
		private function move():void {
			//this.x += MathHelper.RadianToDirection(this.rotation, 3*TimeHelper.deltaTimeScale).x;
			this.y += 20*TimeHelper.deltaTimeScale;
		}
	}
}