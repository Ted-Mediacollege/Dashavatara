package myth.world.worldZones.zone 
{
	public class Zone 
	{
		internal var privateZoneType:int;
		internal var privateX;
		public function Zone(_x:int,_zoneType:int) 
		{
			privateX = _x;
			privateZoneType = _zoneType;
		}
		
		public function get zoneType():int {return privateZoneType};
		public function get x():int {return privateX};
	}

}