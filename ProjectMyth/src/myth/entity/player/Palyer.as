package myth.entity.player 
{
	import starling.display.Image;
	/**
	 * ...
	 * @author Kit van de bunt
	 */
	public interface Player extends Image
	{
		private var canAttack:Boolean;
		private var canSwim:Boolean;
		private var canJump:Boolean;
		
		public function Player(_canAttack:Boolean,_canSwim:Boolean,_canJump:Boolean) {
			
		}
		
		public function Attack() {
			trace("attack");
		}
		
		public function Jump() {
			trace("jump");
		}
		
	}

}