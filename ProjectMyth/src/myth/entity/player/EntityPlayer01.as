package myth.entity.player 
{
	import myth.graphics.TextureList;
	import starling.display.Image;
	import starling.display.Shape;
	import starling.events.TouchEvent;
	import myth.input.TouchType;
	import starling.events.TouchPhase;
	import myth.Main;
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
				//beginX = data[0];
				//beginY = data[1];
				//trace("swipe begin");
			}else if (e.touches[0].phase == TouchPhase.ENDED) {
				//beginX = data[2];
				//beginY = data[3];
				//Main.world.debugShape2.graphics.clear();
				//Main.world.debugShape2.graphics.moveTo(beginX, beginY);
				//Main.world.debugShape2.graphics.lineTo(data[2], data[3]);
				//trace("swipe end X:" +data[2]+" end Y: "+data[3]);
			}
			if (type == TouchType.CLICK)
			{
				//data vector = posX, posY, movedX, movedY
				if (e.touches[0].phase == TouchPhase.ENDED) {
					trace("swipe  posX" + data[0] + " posY" + data[1] + " - moveX" + data[2] + " moveY" + data[3]);
					//Main.world.debugShape2.graphics.clear();
					Main.world.touchZone.graphics.lineStyle(10, 0x00ff00, 0.7);
					Main.world.touchZone.graphics.moveTo(data[0], data[1]);
					Main.world.touchZone.graphics.lineTo(data[2], data[3]);
					Main.world.touchZone.graphics.endFill();
				}
			}
		}
	}

}