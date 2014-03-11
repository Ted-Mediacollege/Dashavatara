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

		public static const DrawNape:int = 0;
		public static const DrawArracks:int = 2;
		public static const DrawRectsColliders:int = 1;
		private static const OFF:int = -1;
		public static var USER:Vector.<int> = new <int>[1,0,0]; //enter all user u want to print for

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