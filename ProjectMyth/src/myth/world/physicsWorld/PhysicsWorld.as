package myth.world.physicsWorld 
{
	import starling.core.Starling;
	import myth.util.TimeHelper;
	import myth.util.ScaleHelper;
	import myth.Main;
	import flash.display.Sprite;
	import starling.display.Sprite;
	import nape.util.Debug;
	import nape.phys.Body;
	import nape.phys.BodyType;
	import nape.shape.Polygon;
	import nape.phys.Material;
	import nape.space.Space;
	import nape.geom.Vec2;
	import nape.util.ShapeDebug;
	import nape.geom.Mat23;
	public class PhysicsWorld 
	{
		
		public var physicsSpace:Space;
		public var debug:Debug;
		public var shape:flash.display.Sprite;
		public var playerBody:Body;
		private var groundMaterial:Material;
		
		public function PhysicsWorld() 
		{
			groundMaterial = new Material(0, 0, 0, 1, 0);
			//create space
			physicsSpace = new Space(new Vec2(0, 2200));
			//physicsSpace.worldLinearDrag = 0.5;
			//debug
			myth.util.Debug.test(function():void { 
				debug = new ShapeDebug(1280, 768, 0x666666);
				//debug = new BitmapDebug(1280, 768, 3355443, false);
				debug.drawShapeDetail = true;
				shape = new flash.display.Sprite();
				shape.alpha = 0.5;
				shape.scaleX = ScaleHelper.scaleX;
				shape.scaleY = ScaleHelper.scaleY;
				shape.addChild(debug.display);
				Starling.current.nativeOverlay.addChild(shape);
			}, myth.util.Debug.DrawArracks);
			
			//ground physics body
			var floor:Body = new Body(BodyType.STATIC);
			floor.shapes.add(new Polygon(Polygon.rect(0-200, 640, 1280+400 +100000, 100)));
			floor.space = physicsSpace; 
			floor.userData.Pivot = new Vec2(0, 0);
			floor.userData.name = "ground";
			floor.setShapeMaterials(groundMaterial);
			
			//player physics body
			playerBody = new Body(BodyType.DYNAMIC,new Vec2(200,200) );
			playerBody.shapes.add(new Polygon(Polygon.box(100,180)));
			playerBody.position.setxy(200,639);
			playerBody.space = physicsSpace;
			playerBody.userData.Pivot = new Vec2(0, -90);
			playerBody.userData.name = "player";
			playerBody.allowRotation = false;
			
			for (var i:int = 0; i < 0; i++) 
			{
				var cube:Body = new Body(BodyType.DYNAMIC,new Vec2(200,200) );
				cube.shapes.add(new Polygon(Polygon.box(28,28)));
				cube.position.setxy(200+Math.random(),200+Math.random());
				cube.space = physicsSpace;
			}
		}
		
		public function tick():void {
			physicsSpace.step(TimeHelper.deltaTime);
				
			myth.util.Debug.test(function():void {
				var debugMatrix:Mat23 = new Mat23();
				debugMatrix.tx = -Main.world.distance;
				debug.transform = debugMatrix;
				debug.clear();
				debug.draw(physicsSpace);
				debug.flush();
			}, myth.util.Debug.DrawArracks);
			//physicsSpace.bodies.foreach( move );
			moveGraphics();
		}
		
		private var graphic:starling.display.Sprite;
		private function moveGraphics():void 
		{
			for (var i:int = 0; i < physicsSpace.bodies.length; i++) 
			{
				var body:Body = physicsSpace.bodies.at(i);
				graphic = body.userData.graphic;
				if(body.userData.Pivot!=null && graphic!=null){
					graphic.x = body.position.x - body.userData.Pivot.x - Main.world.distance;
					graphic.y = body.position.y - body.userData.Pivot.y ;
					graphic.rotation = body.rotation;
				}
			}
		}
		
	}
}