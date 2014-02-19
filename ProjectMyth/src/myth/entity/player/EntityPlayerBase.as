package myth.entity.player 
{
	import flash.geom.Point;
	import myth.entity.Entity;
	import starling.display.Image;
	import starling.events.TouchEvent;
	import myth.input.TouchType;
	import myth.Main;
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
		}
		
		public function input(type:int, data:Vector.<Number>, e:TouchEvent):void {
			
		}
		
		private var drag:Number = 0.1;
		private var gravity:Number = 1;
		private var groundHeight:int = 640;
		private var yVelocity:Number = 0;
			
		override public function tick():void {
			super.tick();
			for (var i:int = 0; i < Main.world.objectManager.objectList.length; i++) 
			{
				var collision:Boolean = this.collider.intersect(Main.world.objectManager.objectList[i].collider);
				if(collision) {
					this.x -= Main.world.deltaSpeed;
				}
			}
			
			//trace(yVelocity);
			yVelocity += gravity;
			this.y += yVelocity;
			
			//stop on ground
			if (this.y > groundHeight) {
				this.y = groundHeight;
				yVelocity = 0;
			}
			//apply drag
			if (yVelocity != 0) {
				if (yVelocity > 0) {
					if(yVelocity-drag<0){
						yVelocity = 0;
					}else { 
						yVelocity -= drag;
					}
				}else {
					if(yVelocity+drag>0){
						yVelocity = 0;
					}else { 
						yVelocity += drag;
					}
				}
			}
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
			yVelocity -= 20;
		}
		
		private function Die():void  {
			trace("die");
		}
		
	}

}