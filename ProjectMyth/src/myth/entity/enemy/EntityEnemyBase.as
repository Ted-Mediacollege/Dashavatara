package myth.entity.enemy 
{
	import myth.util.RGB;
	import starling.display.MovieClip;
	import myth.entity.Entity;
	import starling.display.Image;
	import starling.display.Shape;
	import myth.graphics.AssetList;
	
	
	public class EntityEnemyBase extends Entity
	{
		public var animationClip:MovieClip;
		
		public var damage:int  = 10;
		internal var health:int = 100;
		public var enemyType:int;
		public var lastSwipe:int;
		
		private var knockColor:int = 255;
		private var hitApply:Boolean;
		
		private var colorRGB:RGB;
		
		public function EntityEnemyBase(_enemyType:int,_colWidth:int=80,_colHeight:int=80,_pivotX:int=-40,_pivotY:int=-40) 
		{
			super(_colWidth, _colHeight, _pivotX, _pivotY);
			enemyType = _enemyType;
			colorRGB = new RGB(255, 255, 255);
		}
		
		public function hit(change:int):Boolean {
			//trace("hit: "+health);
			knockback();
			var dead:Boolean = false;
			health += change;
			if (health < 0) {
				dead = true;
			}
			return dead;
		}
		
		override public function tick():void {
			if(hitApply){
				if (knockColor > 0) {
					knockColor -= 50;
					if (knockColor < 0) {
						knockColor = 0;
					}
					colorRGB.b = knockColor;
					colorRGB.g = knockColor;
				}else {
					hitApply = false;
				}
			}else {
				if (knockColor < 250) {
					knockColor+=5;
					colorRGB.b = knockColor;
					colorRGB.g = knockColor;
				}
			}
			animationClip.color = RGB.rgbToHex(colorRGB);
			super.tick();
		}
		
		public function get Healt():int {
			return health;
		}
		
		public function knockback():void {
			hitApply = true;
		}
	}

}