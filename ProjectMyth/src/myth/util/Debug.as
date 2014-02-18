package myth.util 
{
	/**
	 * ...
	 * @author Kit van de Bunt
	 */
	public class Debug
	{
		//example

		/*Debug.test(function():void { 
			//draw stuff
			drawStuff();
			//print info
			trace("info");
		} , Debug.DrawArracks);*/

		public static const DrawArracks:int = 0;
		private static const OFF:int = 2;
		private static var USER:Vector.<int> = new <int>[OFF]; //enter all user u want to print for

		public static function test(func:Function,user:int):Function 
		{
			for (var i:int = 0; i < USER.length; i++) 
			{
				if (USER[i]== user){
					return func();
					break;
				}
			}
			return null;
		}
	}
}