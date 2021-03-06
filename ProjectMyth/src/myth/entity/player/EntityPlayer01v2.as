package myth.entity.player 
{
	import flash.geom.Point;
	import myth.graphics.AssetList;
	import starling.display.Image;
	import starling.display.Shape;
	import starling.events.TouchEvent;
	import myth.input.TouchType;
	import starling.events.TouchPhase;
	import myth.Main;
	import myth.util.Debug;
	import myth.util.MathHelper;
	import treefortress.spriter.SpriterClip;
	import starling.core.Starling;
	//lion
	public class EntityPlayer01v2 extends EntityPlayerBase
	{
		public var image:SpriterClip;
		public var startShootRadius:int = 100;
		public var startShootXDisplace:int = -20;
		public var startShootYDisplace:int = -90;
		private var debugShape:Shape = new Shape();
		
		public function EntityPlayer01v2() 
		{
			//super(true, false, true,128,200,-64,-200 );
			super(false,300);
			
			image = AssetList.spriterLoader.getSpriterClip("animLion");
			image.playbackSpeed = 1;
			image.scaleX = 0.7;
			image.scaleY = 0.7;
			image.play("ren animatie");
			addChild(image);
			Starling.juggler.add(image);
			
			//image = new Image(TextureList.atlas_player.getTexture("player_3"));
			//image.scaleX = -1;
			//image.pivotX = image.width / 2;
			//image.pivotY = image.height;
			//artLayer.addChild(image);
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
				
				Debug.test(function():void { 
					//data vector = posX, posY, movedX, movedY
					//trace("swipe  posX" + data[0] + " posY" + data[1] + " - moveX" + data[2] + " moveY" + data[3]);
					Main.world.debugShape2.graphics.clear();
					Main.world.debugShape2.graphics.lineStyle(10, 0x00ff00, 0.7);
					Main.world.debugShape2.graphics.moveTo(data[0], data[1]);
					Main.world.debugShape2.graphics.lineTo(data[2], data[3]);
					Main.world.debugShape2.graphics.endFill();
				}, Debug.DrawArracks);
				//spawn bullet
				var distPlayerStart:Number = MathHelper.dis2(Main.world.player.x+startShootXDisplace, Main.world.player.y+startShootYDisplace, data[0], data[1]);
				var distPlayerEnd:Number = MathHelper.dis2(Main.world.player.x+startShootXDisplace, Main.world.player.y+startShootYDisplace, data[2], data[3]);
				var distDraw:Number = MathHelper.dis2(data[2], data[3], data[0], data[1]);
				if (distPlayerStart < startShootRadius && distDraw > 50 && distPlayerEnd > startShootRadius) {
					//Main.world.enemyManager.makeBullet(0,data[0], data[1],data[2],data[3]);
					Main.world.entityManager.makeBullet(0,Main.world.player.x, Main.world.player.y-120,data[2],data[3]);
				}
			}
		}
	}
}
