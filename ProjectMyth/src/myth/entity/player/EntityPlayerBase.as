package myth.entity.player 
{
	import flash.geom.Point;
	import myth.entity.Entity;
	import starling.display.Image;
	import starling.events.TouchEvent;
	import myth.input.TouchType;
	import myth.Main;
	import myth.util.MathHelper;
	/**
	 * ...
	 * @author Kit van de bunt
	 */
	public class EntityPlayerBase extends Entity
	{
		private var canAttack:Boolean;
		private var canSwim:Boolean;
		private var canJump:Boolean;
		
		public function EntityPlayerBase(_canAttack:Boolean,_canSwim:Boolean,_canJump:Boolean,_colWidth:int=128,_colHeight:int=200,_pivotX:int=-64,_pivotY:int=-100) {
			super(_colWidth, _colHeight, _pivotX, _pivotY);
			canAttack = _canAttack;
			canSwim = _canSwim;
			canJump = _canJump;
			PosOut = new Point(x, y);
		}
		
		public function input(type:int, data:Vector.<Number>, e:TouchEvent):void {
			
		}
		
		private var drag:Number = 0.1;
		private var gravity:Number = 1;
		private var groundHeight:int = 640;
		private var gravityVelocity:Number = 0;
		private var jumpVelocity:Number = 0;
		private var totalYVelocity:Number = 0;
		private static var PosOut:Point;
		private static var outDirection:Point;
		private static var pos:Point = new Point(0, 0);
			
		override public function tick():void {
			//pillar collision
			gravityVelocity += gravity;
			pos.x = this.x- Main.world.deltaSpeed;
			pos.y = this.y;
			super.tick();
			
			for (var i:int = 0; i < Main.world.objectManager.objectList.length; i++) 
			{
				var collision:Boolean = this.collider.intersect(Main.world.objectManager.objectList[i].collider);
				if (collision) {
					this.x = PosOut.x;
					this.y = PosOut.y;
					gravityVelocity = 0;
				}else {
					if(this.x < 200){
						//this.x += Main.world.deltaSpeed;
					}
				}
			}
			PosOut = new Point(this.x-Main.world.deltaSpeed, this.y);
			//trace(PosOut);
			
			//stop on ground
			if (this.y > groundHeight) {
				this.y = groundHeight;
				gravityVelocity = 0;
			}
			//apply drag
			if (gravityVelocity != 0) {
				if (gravityVelocity > 0) {
					if(gravityVelocity-drag<0){
						gravityVelocity = 0;
					}else { 
						gravityVelocity -= drag;
					}
				}else {
					if(gravityVelocity+drag>0){
						gravityVelocity = 0;
					}else { 
						gravityVelocity += drag;
					}
				}
			}
			
			//move y
			if (jumpVelocity > 0) {
				jumpVelocity = 0;
			}else { 
				jumpVelocity += gravity;
				//trace(jumpVelocity);
				this.y += jumpVelocity;
				//PosOut.y += jumpVelocity;
			}
			
			this.y += gravityVelocity;
		}
		
		
		public function TriggerAttack():void {
			if(canAttack){
				Attack();
			}else {
				Die();
			}
		}
		
		public function TriggerJump():void {
			if(canJump){
				Jump();
			}else {
				Die();
			}
		}
		
		public function TriggerSwim():void {
			if(canSwim){
				Swim();
			}else {
				Die();
			}
		}
		
		public function Swim():void {
			trace("swim");
		}
		
		private function Attack():void {
			trace("attack");
		}
		
		private function Jump():void  {
			trace("jump");
			jumpVelocity -= 20; 
		}
		
		private function Die():void  {
			trace("die");
		}
		
	}

}