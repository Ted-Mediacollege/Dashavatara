package myth.world.player 
{
	import starling.display.Image;
	/**
	 * ...
	 * @author Kit van de bunt
	 */
	public interface Player extends Image
	{
		
		public function Player() {
			
		}
		
		public function Attack() {
			trace("attack");
		}
		
		public function Attack() {
			trace("jump");
		}
		
	}

}