package myth.util 
{
	/**
	 * ...
	 * @author Kit van de Bunt
	 */
	public class TimeHelper
	{
		public static var deltatime:Number = 1/60;
		private static var oldTime:Number = 0;
		private static var newTime:Number = 0;
		private static var CurrentDateTime:Date;
		
		public static function tick():void
		{
			CurrentDateTime = new Date();
			oldTime = newTime;
			newTime = CurrentDateTime.time;
			deltatime = (newTime -oldTime)/1000;
		}
		
	}

}