package myth.entity.player 
{
	import myth.graphics.TextureList;
	import starling.display.Image;
	import starling.display.Shape;
	import starling.events.TouchEvent;
	import myth.input.TouchType;
	import starling.events.TouchPhase;
	import myth.Main;
	import myth.util.Debug;
	import myth.util.MathHelper;
	/**
	 * ...
	 * @author Kit van de bunt
	 * 
	 * Lion
	 */
	public class EntityPlayer01 extends EntityPlayerBase
	{
		public var image:Image;
		private var debugShape:Shape = new Shape();
		public function EntityPlayer01() 
		{
			super(true, false, true );
			image = new Image(TextureList.atlas_player.getTexture("player_1"));
			image.pivotX = image.width / 2;
			image.pivotY = image.height / 2;
			addChild(image);
			addChild(debugShape);
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
				var distPlayer:Number = MathHelper.dis2(Main.world.player.x, Main.world.player.y, data[0], data[1]);
				var distDraw:Number = MathHelper.dis2(data[2], data[3], data[0], data[1]);
				if (distPlayer < 50 && distDraw > 100) {
					//Main.world.enemyManager.makeBullet(0,data[0], data[1],data[2],data[3]);
					Main.world.entityManager.makeBullet(0,Main.world.player.x, Main.world.player.y,data[2],data[3]);
				}
			}
		}
	}
}