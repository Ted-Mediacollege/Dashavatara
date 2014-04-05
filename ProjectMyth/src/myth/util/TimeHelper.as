package myth.util 
{
	/**
	 * ...
	 * @author Kit van de Bunt
	 */
	public class TimeHelper
	{
		public static var deltaTime:Number;
		public static var deltaTimeScale:Number = 1;
		private static var frameIntPrivate:int = 0;
		private static var oldTime:Number = 0;
		private static var newTime:Number = 0;
		private static var CurrentDateTime:Date;
		
		public static function tick():void
		{
			frameIntPrivate++;
			CurrentDateTime = new Date();
			oldTime = newTime;
			newTime = CurrentDateTime.time;
			deltaTime = (newTime -oldTime)/1000;
			deltaTimeScale = (newTime -oldTime) * 0.06;
			if (deltaTimeScale > 3) {
				deltaTimeScale = 3;
				deltaTime = 3 * 0.001;
			}else if (deltaTimeScale < 0) {
				deltaTimeScale = 0;
				deltaTime = 0;
			}
		}
		
		public static function get frameInt():int {return frameIntPrivate;}
	}

}