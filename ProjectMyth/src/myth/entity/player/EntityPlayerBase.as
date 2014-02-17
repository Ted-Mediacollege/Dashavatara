package myth.entity.player 
{
	import flash.geom.Point;
	import myth.entity.Entity;
	import starling.display.Image;
	import starling.events.TouchEvent;
	import myth.input.TouchType;
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
		}
		
		public function input(type:int, data:Vector.<Number>, e:TouchEvent):void {
			
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
		
		public function Attack():void {
			trace("attack");
		}
		
		public function Jump():void  {
			trace("jump");
		}
		
		public function Die():void  {
			trace("die");
		}
		
	}

}