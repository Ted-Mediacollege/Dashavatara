package myth.world.worldZones.zone 
{
	import myth.world.worldZones.ZoneType;
	public class SpeedZone extends Zone
	{
		internal var privateDeltaSpeed:Number;
		internal var privateWidth:Number;
		public function SpeedZone(_x:int,_deltaSpeed:Number,_width:int) 
		{
			super(_x,ZoneType.Speed);
			privateDeltaSpeed = _deltaSpeed;
			privateWidth = _width;
		}
		
		public function get deltaSpeed():int { return privateDeltaSpeed };
		public function get width():int { return privateWidth };
		public function get xExit():int {return x+privateWidth};
	}

}