package myth.entity.player 
{
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
	//lion
	public class EntityPlayer01v3 extends EntityPlayerBase
	{
		public var image:Image;
		public var startShootRadius:int = 100;
		public var startShootXDisplace:int = -20;
		public var startShootYDisplace:int = -90;
		private var debugShape:Shape = new Shape();
		public function EntityPlayer01v3() 
		{
			//super(true, false, true,128,200,-64,-200 );
			super(false,300);
			
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
		override public function input(type:int, data:Vector.<Number>, e:TouchEvent):void {
			
			//data vector = posX, posY, movedX, movedY
			if (e.touches[0].phase == TouchPhase.BEGAN) {
				
			}else if (e.touches[0].phase == TouchPhase.ENDED) {
				
			}
			if (type == TouchType.CLICK)
			{
				var distDraw:Number = MathHelper.dis2(data[2], data[3], data[0], data[1]);
				var distDrawInt:int = Math.floor(distDraw)/20;
				var pos1:Point = new Point(data[0], data[1]);
				var pos2:Point = new Point(data[2], data[3]);
				var dist:Point = pos1.subtract(pos2);
				Debug.test(function():void { 
					//data vector = posX, posY, movedX, movedY
					//trace("swipe  posX" + data[0] + " posY" + data[1] + " - moveX" + data[2] + " moveY" + data[3]);
					Main.world.debugShape2.graphics.clear();
					Main.world.debugShape2.graphics.lineStyle(10, 0x00ff00, 0.7);
					Main.world.debugShape2.graphics.drawCircle(data[0], data[1], 15);
					
					for (var i:int = 0; i < distDrawInt; i++) {
						Main.world.debugShape2.graphics.drawCircle(pos1.x+(dist.x*-(i/distDrawInt)), pos1.y+(dist.y*-(i/distDrawInt)), 5);
					}
					
					Main.world.debugShape2.graphics.drawCircle(data[2], data[3],15);
					Main.world.debugShape2.graphics.endFill();
				}, Debug.DrawArracks);
				//spawn bullet
				var distPlayerStart:Number = MathHelper.dis2(Main.world.player.x+startShootXDisplace, Main.world.player.y+startShootYDisplace, data[0], data[1]);
				var distPlayerEnd:Number = MathHelper.dis2(Main.world.player.x+startShootXDisplace, Main.world.player.y+startShootYDisplace, data[2], data[3]);
				
				var i:int;
				var j:int;
				for (j = Main.world.entityManager.enemyList.length-1; j > -1; j--) 
				{
					var hit:Boolean = false;
					Main.world.debugShape2.graphics.drawCircle(data[0], data[1], 15);
						for (i = 0; i < distDrawInt; i++) {
							Main.world.debugShape2.graphics.drawCircle(pos1.x+(dist.x*-(i/distDrawInt)), pos1.y+(dist.y*-(i/distDrawInt)), 5);
						}
					Main.world.debugShape2.graphics.drawCircle(data[2], data[3], 15);
					
					if (Main.world.entityManager.enemyList[j].collider.intersectPoint(pos1)) {
						hit = true;
					}else if (Main.world.entityManager.enemyList[j].collider.intersectPoint(pos2)) {
						hit = true;
					}else {
						for (i = 0; i < distDrawInt; i++) {
							var point:Point = new Point(pos1.x + (dist.x * -(i / distDrawInt)), pos1.y + (dist.y * -(i / distDrawInt)));
							if (Main.world.entityManager.enemyList[j].collider.intersectPoint(point)) {
								hit = true;
								break;
							}
						}
					}
					if (hit) {
						Main.world.entityManager.removeChild(Main.world.entityManager.enemyList[j]);
						Main.world.entityManager.enemyList.splice(j , 1);
					}
				}
				
				/*if (distPlayerStart < startShootRadius && distDraw > 50 && distPlayerEnd > startShootRadius) {
					Main.world.entityManager.makeBullet(0,Main.world.player.x, Main.world.player.y-120,data[2],data[3]);
				}*/
				
				
			}
		}
	}
}
