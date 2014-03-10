package myth.world 
{
	import myth.entity.objects.EntityObjectBase;
	import myth.entity.objects.EntityObjectPillar;
	import nape.geom.Vec2;
	import nape.phys.Body;
	import nape.phys.Material;
	import nape.shape.Polygon;
	import starling.display.Sprite;
	import myth.entity.objects.ObjectType;
	import nape.phys.BodyType;
	import myth.Main;
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
		public var objectList:Vector.<Body> = new Vector.<Body>;
		private var spawnPos:int = 1400;
		private var groundMaterial:Material;
		
		public function WorldObjectManager(_data:Vector.<Vector.<int>> = null):void 
		{
			data = _data;
			groundMaterial = new Material(0, 0, 0, 1, 0);
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
			
			var platform:Body = new Body(BodyType.KINEMATIC);
			platform.position.setxy(xPos, yPos);
			platform.shapes.add(new Polygon(Polygon.rect(-object.width/2, -object.height, object.width, object.height)));
			//platform.velocity.x = -Main.world.speed*60;
			//platform.velocity.x = Main.world.distance;
			platform.space =  Main.world.physicsSpace;
			//platform.userData.Pivot = new Vec2(0, -90);
			platform.userData.graphic = object;
			platform.userData.Pivot = new Vec2(object.width / 2, 0);
			platform.userData.name = "pillar";
			platform.setShapeMaterials(groundMaterial);
			
			objectList.push(platform);
			addChild(object);
		}
		
		private function removeObject(number:int):void {
			removeChild(objectList[number].userData.graphic);
			objectList.splice(number , 1);
		}
		
		override public function tick(speed:Number , dist:Number):void {
			//spawn objects
			if (data.length > 0) {
				while(data[0][1] < dist+spawnPos) {
					makeObject(data[0][0], spawnPos+dist, data[0][2]);
					data.splice(0, 1);
					if (data.length < 1) {
						break;
					}
				}
			}
			//trace("l:"+objectList.length);
			//for (var i:int = objectList.length - 1; i >= 0; i--) {
				//trace(" Y: "+objectList[i].userData.graphic.x+" X: "+objectList[i].userData.graphic.y);
			//}
			/*
			for (var i:int = objectList.length-1; i >= 0; i--) {
				
				//remove objects on exit screen
				if (objectList[i].x < -200) {
					removeObject(i);
				}else{//move objects
					objectList[i].x -= speed;
					objectList[i].tick();
				}
			}
			*/
		};
		
	}

}