package myth.entity.player 
{
	import adobe.utils.CustomActions;
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.geom.Point;
	import myth.graphics.AssetList;
	import nape.geom.Vec2;
	import starling.display.Image;
	import starling.display.QuadBatch;
	import starling.display.Shape;
	import starling.events.TouchEvent;
	import myth.input.TouchType;
	import starling.events.TouchPhase;
	import myth.Main;
	import myth.util.Debug;
	import myth.util.MathHelper;
	import myth.particle.slashPart;
	import pixelpaton.FindSmoothPathBetweenNodes;
	import com.cartogrammar.drawing.CubicBezier;
	import starling.textures.Texture;
	import treefortress.spriter.SpriterClip;
	import starling.core.Starling;
	import myth.util.ScaleHelper;
	//lion
	public class EntityPlayer01v5 extends EntityPlayerBase
	{
		[Embed(source="../../../../lib/textures/Line_1.png")]
		public static var LineTex:Class;
		private static var line_textures:Texture;
		private var lineBatch:QuadBatch = new QuadBatch();
		
		
		public var image:SpriterClip;
		public var startShootRadius:int = 100;
		public var startShootXDisplace:int = -20;
		public var startShootYDisplace:int = -90;
		private var debugShape:Shape = new Shape();
		private var line_image:Image;
		public function EntityPlayer01v5() 
		{
			//line
			//super(true, false, true,128,200,-64,-200 );
			super(false,300,PlayerType.Lion,AssetList.assets.getTexture("gui_icon1"),AssetList.assets.getTexture("gui_icon1_d"));
			line_textures = Texture.fromBitmap(new LineTex());
			line_image = new Image(line_textures);
			line_image.x = 640;
			line_image.y = 383;
			Main.world.attackShape.addChild(lineBatch);
			
			//player art
			image = AssetList.spriterLoader.getSpriterClip("animLion");
			image.playbackSpeed = 1;
			image.scaleX = 0.7;
			image.scaleY = 0.7;
			image.play("ren animatie");
			addChild(image);
			Main.world.gameJuggler.add(image);
			
			artLayer.addChild(image);
			artLayer.addChild(debugShape);
			artLayer.addChild(line_image);
			Debug.test(function():void { 
				//draw start attack circle
				debugShape.graphics.lineStyle(10, 0x00ff00, 0.3);
				debugShape.graphics.drawCircle(startShootXDisplace, startShootYDisplace, startShootRadius);
			}, Debug.DrawArracks);
		}
		
		private var beginX:int;
		private var beginY:int;
		private var currentId:int;
		//private var parts:Vector.<Vector.<slashPart>> = new Vector.<Vector.<slashPart>>();
		private var parts:Vector.<slashPart> = new Vector.<slashPart>();
		private var backgroundAssetData:Vector.<Vector.<int>>;
		private var i:int = 0;
		private var j:int = 0;
		private var k:int = 0;
		private var hit:Boolean;
		private var previousPos:Point = null;
		private var angleVec:Vec2 = new Vec2();
		private var angleVec2:Vec2 = new Vec2();
		
		private var thisSwipeHit:Boolean = false;
		private var secondRegister:Boolean = false;
		private var swipeMaxAngle:Number = (1 / 4) * Math.PI;
		private var previousAngle:Number;
		private var swipeCount:int = 0;
		
		private var delta:Point;
		private var thisPos:Point;
		private var testPoints:Vector.<Point>;
		private var dist:Point;
		private var distNumber:Number;
		private var checks:int;
		private var delta2:Point;
		private var thisAngle:Number;
		private var angelDelta:Number;
		private var part:slashPart;
		private var point:Point;
		
		override public function input(type:int, data:Vector.<Number>, e:TouchEvent):void {
			//trace("touch");
			//data vector = posX, posY, movedX, movedY
			thisPos = new Point(e.touches[0].globalX/ScaleHelper.scaleX, e.touches[0].globalY/ScaleHelper.scaleY);
			testPoints = new Vector.<Point>();
			if (e.touches[0].phase == TouchPhase.BEGAN) {
				//trace("began");
				testPoints[0] = thisPos;
				Debug.test(function():void { 
					//Main.world.debugShape2.graphics.lineStyle(10, 0x00ff00, 0.7);
					//Main.world.debugShape2.graphics.drawCircle(data[0], data[1], 55);
				}, Debug.DrawArracks);
				previousPos = thisPos;
			}else if (e.touches[0].phase == TouchPhase.ENDED) {
				previousPos = null;
				thisSwipeHit = false;
				secondRegister = false;
				Debug.test(function():void { 
					Main.world.debugShape2.graphics.clear();
				}, Debug.DrawArracks);
			}else if (e.touches[0].phase == TouchPhase.MOVED) {
				if (secondRegister) {
					delta2 = previousPos.subtract(thisPos);
					thisAngle = MathHelper.pointToRadian(0, delta2.x, 0, delta2.y);
					angelDelta = thisAngle - previousAngle;
					//trace("---------------------angleDelta: " + angelDelta);
					if (angelDelta > swipeMaxAngle || angelDelta < -swipeMaxAngle) {
						thisSwipeHit = false;
						swipeCount++;
						//trace("newSwipe: "+swipeCount);
					}
				}
				dist = thisPos.subtract(previousPos);
				distNumber = dist.length;
				checks = Math.floor(distNumber / 5);
				for (k = 0; k < checks; k++) 
				{
					point = Point.interpolate(thisPos,previousPos,((checks-k)/checks));
					testPoints.push(point);
					Debug.test(function():void { 
						Main.world.debugShape2.graphics.lineStyle(2, 0xff00ff, 0.7);
						Main.world.debugShape2.graphics.drawCircle(point.x, point.y, 5);
					}, Debug.DrawArracks);
				}
				//trace("[testpoints]: " +testPoints.length);
				Debug.test(function():void { 
					Main.world.debugShape2.graphics.lineStyle(2, 0x990000, 0.7);
					Main.world.debugShape2.graphics.drawCircle(data[0], data[1], 10);
				}, Debug.DrawArracks);
				part = new slashPart(data[0], data[1],12);
				parts.push(part);
				
				//check hit
				//if(thisSwipeHit){
					for (j = Main.world.entityManager.enemyList.length - 1; j > -1; j--) {
						hit = false;
						for (var l:int = 0; l < testPoints.length; l++) {
							if (Main.world.entityManager.enemyList[j].collider.intersectPoint(testPoints[l])) {
								hit = true;
								break;
							}
						}
						if (hit) {
							thisSwipeHit = true;
							//trace("hit:" + Main.world.entityManager.enemyList[j].Healt);
							if (Main.world.entityManager.enemyList[j].lastSwipe != swipeCount) {
								Main.world.entityManager.enemyList[j].lastSwipe = swipeCount;
								if (Main.world.entityManager.enemyList[j].hit( -25)) {
									Main.world.entityManager.killEnemy(Main.world.entityManager.enemyList[j]);
								}
							}
						}
					}
				//}
				if (!secondRegister) {
					secondRegister = true;
				}
				//var  vec:Vec2 = Vec2.weak(0, 0);
				delta = previousPos.subtract(thisPos);
				previousAngle = MathHelper.pointToRadian(0, delta.x, 0, delta.y);
				previousPos = thisPos;
			}
		}
		
		private var rot:Number;
		private var smoothParts:Vector.<slashPart>;
		override public function tick():void {
			//line.
			super.tick();
			//Main.world.attackShape.graphics.clear();
			//trace(parts.length);
			smoothParts = FindSmoothPathBetweenNodes.getArrayOfPoints(parts,false,20);
			//var smoothParts:Vector.<slashPart> = parts;
			
			lineBatch.reset();
			
			for (i = 0; i < smoothParts.length; i++) {
				//lineBatch
				//line_image = new Image(line_textures);
				//trace(smoothParts[i].x + "," + smoothParts[i].y + ","+ smoothParts[i].t);
				line_image.x = smoothParts[i].x;
				line_image.y = smoothParts[i].y;
				line_image.pivotX = line_image.width / 2;;
				line_image.pivotY = line_image.height / 2;;
				line_image.scaleX = smoothParts[i].t/10;
				line_image.scaleY = 12/ 10;
				if (i == smoothParts.length - 1) {
					line_image.rotation = rotation+Math.PI/2;
				}else {
					angleVec.x = smoothParts[i].x;
					angleVec.y = smoothParts[i].y;
					angleVec2.x = smoothParts[i + 1].x;
					angleVec2.y = smoothParts[i + 1].y;
					rot = angleVec.sub(angleVec2).angle;
					//var delta:Point = smoothParts[i].subtract(smoothParts[i + 1]);
					//trace("new:"+MathHelper.pointToRadian(0, delta.x, 0, delta.y- Math.PI / 2));
					//trace("old:" + rotation + Math.PI / 2);
					
					//line_image.rotation = MathHelper.pointToRadian(0,delta.x,0, delta.y)+Math.PI/2;
					line_image.rotation = rot+Math.PI/2;
				}
				lineBatch.addImage(line_image);
				
			}
			
			for (i = 0; i < parts.length; i++) 
			{	
				//Main.world.attackShape.graphics.drawCircle(parts[i].x, parts[i].y, parts[i].t);
				parts[i].t -= 1.1;
				if (parts[i].t < 0) {
					parts.splice(i, 1);
				}
			}
			
		}
	}
}
