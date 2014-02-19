package myth.world 
{
	import myth.entity.objects.EntityObjectBase;
	import myth.entity.objects.EntityObjectPillar;
	import starling.display.Sprite;
	import myth.entity.objects.ObjectType;
	/**
	 * XML File
	 * "objects":[
			{
				"type":0,
				"x":1000,
				"y":500
			}
		],
	 */
	public class WorldObjectManager extends WorldManagerBase
	{
		private var data:Vector.<Vector.<int>>;
		public var objectList:Vector.<EntityObjectBase> = new Vector.<EntityObjectBase>;
		private var spawnPos:int = 1400;
		public function WorldObjectManager(_data:Vector.<Vector.<int>> = null):void 
		{
			data = _data;
			build();
		}
		
		private function build():void {
			if (data.length > 0) {
				while(data[0][1] < spawnPos) {
					makeObject(data[0][0], data[0][1], data[0][2]);
					data.splice(0, 1);
					if (data.length < 1) {
						break;
					}
				}
			}
		}
		
		public function makeObject( type:int,xPos:int,yPos:int) :void
		{
			var object :EntityObjectBase;
			if(type == ObjectType.Pillar){
				object = new EntityObjectPillar();
			}else if(type == ObjectType.pillar2){
				object = new EntityObjectPillar();
			}
			object.x = xPos;
			object.y = yPos;
			objectList.push(object);
			addChild(object);
		}
		
		private function removeObject(number:int):void {
			removeChild(objectList[number]);
			objectList.splice(number , 1);
		}
		
		override public function tick(speed:Number , dist:Number):void {
			//spawn objects
			if (data.length > 0) {
				while(data[0][1] < dist+spawnPos) {
					makeObject(data[0][0], spawnPos, data[0][2]);
					data.splice(0, 1);
					if (data.length < 1) {
						break;
					}
				}
			}
			
			for (var i:int = objectList.length-1; i >= 0; i--) {
				
				//remove objects on exit screen
				if (objectList[i].x < -200) {
					removeObject(i);
				}else{//move objects
					objectList[i].x -= speed;
					objectList[i].tick();
				}
			}
		};
		
	}

}