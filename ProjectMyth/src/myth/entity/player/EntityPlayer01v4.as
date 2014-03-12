package myth.entity.player 
{
	import adobe.utils.CustomActions;
	import flash.geom.Point;
	import myth.graphics.TextureList;
	import nape.geom.Vec2;
	import starling.display.Image;
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
	import starling.utils.Line;
	//lion
	public class EntityPlayer01v4 extends EntityPlayerBase
	{
		public var image:Image;
		public var startShootRadius:int = 100;
		public var startShootXDisplace:int = -20;
		public var startShootYDisplace:int = -90;
		private var debugShape:Shape = new Shape();
		private var line:Line = new Line();
		public function EntityPlayer01v4() 
		{
			//super(true, false, true,128,200,-64,-200 );
			super(false,300);
			addChild(line);
			
			image = new Image(TextureList.atlas_player.getTexture("player_3"));
			image.scaleX = -1;
			image.pivotX = image.width / 2;
			image.pivotY = image.height;
			artLayer.addChild(image);
			artLayer.addChild(debugShape);
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
		private var hit:Boolean;
		override public function input(type:int, data:Vector.<Number>, e:TouchEvent):void {
			//trace("touch");
			//data vector = posX, posY, movedX, movedY
			if (e.touches[0].phase == TouchPhase.BEGAN) {
				//trace("began");
				Debug.test(function():void { 
					//Main.world.debugShape2.graphics.lineStyle(10, 0x00ff00, 0.7);
					//Main.world.debugShape2.graphics.drawCircle(data[0], data[1], 55);
				}, Debug.DrawArracks);
			}else if (e.touches[0].phase == TouchPhase.ENDED) {
				Debug.test(function():void { 
					Main.world.debugShape2.graphics.clear();
				}, Debug.DrawArracks);
			}else if (e.touches[0].phase == TouchPhase.MOVED) {
				Debug.test(function():void { 
					Main.world.debugShape2.graphics.lineStyle(2, 0x990000, 0.7);
					Main.world.debugShape2.graphics.drawCircle(data[0], data[1], 10);
				}, Debug.DrawArracks);
				var part:slashPart = new slashPart(data[0], data[1],12);
				parts.push(part);
				
				for (j = Main.world.entityManager.enemyList.length - 1; j > -1; j--) {
					hit = false;
					if (Main.world.entityManager.enemyList[j].collider.intersectPoint(new Point(data[0],data[1]))) {
						hit = true;
					}
					if (hit) {
						Main.world.entityManager.removeChild(Main.world.entityManager.enemyList[j]);
						Main.world.entityManager.enemyList.splice(j , 1);
					}
				}
			}
		}
		
		override public function tick():void {
			//line.
			super.tick();
			Main.world.attackShape.graphics.clear();
			//trace(parts.length);
			var smoothParts:Vector.<slashPart> = FindSmoothPathBetweenNodes.getArrayOfPoints(parts);
			//var smoothParts:Vector.<slashPart> = parts;
			
			//trace("s L:" + smoothParts.length);
			for (i = 0; i < smoothParts.length; i++) {
				Main.world.attackShape.graphics.lineStyle(smoothParts[i].t, 0x0022ee, 0.7);
				Main.world.attackShape.graphics.beginFill(0x0022ee, 0.7);
				if (i == 0) {
					Main.world.attackShape.graphics.moveTo(smoothParts[i].x, smoothParts[i].y);
				}else if (smoothParts.length - 1) {
					Main.world.attackShape.graphics.lineTo(smoothParts[i].x, smoothParts[i].y);
				}else {
					var distPreviousThis:Number = smoothParts[i].subtract(smoothParts[i - 1]).length;
					Main.world.attackShape.graphics.lineTo(smoothParts[i].x, smoothParts[i].y);
				}
			}
			
			for (i = 0; i < parts.length; i++) 
			{	
				//Main.world.attackShape.graphics.drawCircle(parts[i].x, parts[i].y, parts[i].t);
				parts[i].t -= 1.3;
				if (parts[i].t < 0) {
					parts.splice(i, 1);
				}
			}
			
		}
	}
}
