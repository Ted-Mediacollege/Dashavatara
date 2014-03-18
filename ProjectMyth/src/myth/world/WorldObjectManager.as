package myth.world 
{
	import myth.entity.objects.EntityObjectBase;
	import myth.entity.objects.EntityObjectEndPort;
	import myth.entity.objects.EntityObjectEndPortPart2;
	import myth.entity.objects.EntityObjectPillar;
	import nape.geom.Vec2;
	import nape.phys.Body;
	import nape.phys.Material;
	import nape.shape.Polygon;
	import starling.display.Sprite;
	import myth.entity.objects.ObjectType;
	import nape.phys.BodyType;
	import myth.Main;
	import myth.graphics.Display;
	import myth.graphics.LayerID;
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
			var newBody:Body = new Body(BodyType.KINEMATIC);
			var object :EntityObjectBase;
			var objects :Vector.<EntityObjectBase>;
			
			if(type == ObjectType.Pillar){
				object = new EntityObjectPillar();
			}else if(type == ObjectType.pillar2){
				object = new EntityObjectPillar();
			}else if (type == ObjectType.endPort1) {
				objects = new Vector.<EntityObjectBase>;
				objects[0] = new EntityObjectEndPort();
				objects[1] = new EntityObjectEndPortPart2();
			}
			if (type == ObjectType.Pillar || type == ObjectType.pillar2) {
				newBody.position.setxy(xPos, yPos);
				newBody.shapes.add(new Polygon(Polygon.rect(-object.width/2, -object.height, object.width, object.height)));
				//platform.velocity.x = -Main.world.speed*60;
				//platform.velocity.x = Main.world.distance;
				newBody.space =  Main.world.physicsWorld.physicsSpace;
				//platform.userData.Pivot = new Vec2(0, -90);
				newBody.userData.graphic = object;
				newBody.userData.Pivot = new Vec2(object.width / 2, 0);
				newBody.userData.name = "pillar";
				newBody.setShapeMaterials(groundMaterial);
				Display.add(object,LayerID.GameLevel);
			}else {
				newBody.position.setxy(xPos, yPos);
				newBody.space =  Main.world.physicsWorld.physicsSpace;
				newBody.userData.graphics = new Vector.<EntityObjectBase>;
				newBody.userData.Pivots = new Vector.<Vec2>;
				//part1
				newBody.userData.graphics[0] = objects[0];
				newBody.userData.Pivots[0] = new Vec2(objects[0].width / 2 , 0);
				Display.add(objects[0],LayerID.GameLevelBack);
				//
				//part2
				newBody.userData.graphics[1] = objects[1];
				newBody.userData.Pivots[1] = new Vec2(objects[1].width / 2 , 0);
				Display.add(objects[1],LayerID.GameLevelFront);
				//
				newBody.userData.name = "endPort";
			}
			
			objectList.push(newBody);
		}
		
		private var graphic:starling.display.Sprite;
		private var graphics:Vector.<EntityObjectBase>;
		private function removeObject(number:int):void {
			graphic = objectList[number].userData.graphic;
			graphics = objectList[number].userData.graphics;
			if(graphic!=null){
				objectList[number].userData.graphic.removeFromParent();
			}else {
				for (var i:int = 0; i < graphics.length; i++) 
				{
					objectList[number].userData.graphics[i].removeFromParent();
				}
			}
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