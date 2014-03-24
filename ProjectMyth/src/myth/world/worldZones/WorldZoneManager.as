package myth.world.worldZones 
{
	import myth.Main;
	import myth.world.worldZones.zone.SpeedZone;
	import myth.world.worldZones.zone.Zone;
	public class WorldZoneManager 
	{
		private var data:Vector.<Vector.<int>>;
		private var zones:Vector.<Zone> = new Vector.<Zone>;
		private var currentSpeedZones:Vector.<SpeedZone> = new Vector.<SpeedZone>;
		
		public function WorldZoneManager(_data:Vector.<Vector.<int>> = null):void{
			data = _data;
			//type,xpos,deltaspeed,zonewidth
			//data = new Vector.<Vector.<int>> (2);
			//data[0] = new <int>[0,1000,4,1000];
			//data[1] = new <int>[0,4000,-4,200];
			build();
		}
		
		public function build():void {
			for (var i:int = 0; i < data.length; i++) 
			{
				if (data[i][0] == ZoneType.Speed) {
					zones.push(new SpeedZone(data[i][1], data[i][2], data[i][3]));
				}
			}
		}
		
		public function tick():void {
			//trace(Main.world.speed+" P:"+Main.world.distance);
			checkEnterZone();
			updateZone();
		}
		private function checkEnterZone():void {
			var dist:Number = Main.world.distance;
			if(zones.length > 0){
				if (dist > zones[0].x) {
					if(zones[0].zoneType == ZoneType.Speed){
						currentSpeedZones.push(zones[0]);
						trace("enterZone pos: "+Main.world.distance+" speed: "+Main.world.speed);
					}
					zones.splice(0, 1);
				}
			}
		}
		
		private function updateZone():void {
			for (var i:int = 0; i < currentSpeedZones.length; i++) {
				if (Main.world.distance > currentSpeedZones[i].xExit) {
					currentSpeedZones.splice(i, 1);
					trace("exitZone pos: "+Main.world.distance+" speed: "+Main.world.speed);
				}else {
					Main.world.speed = Main.world.speed +  ((Main.world.deltaSpeed/currentSpeedZones[i].width)*currentSpeedZones[i].deltaSpeed);
				}
				
			}
			
		}
	}

}