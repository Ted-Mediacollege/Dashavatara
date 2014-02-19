package myth.entity.player 
{
	import starling.display.Image;
	import starling.core.Starling;
	import myth.graphics.TextureList;
	import myth.input.TouchType;
	import starling.events.TouchEvent;
	import myth.util.MathHelper;
	import myth.Main;
	
	public class EntityPlayerTest extends EntityPlayerBase
	{
		public var image:Image;
		public var startShootRadius:int = 100;
		public var startShootXDisplace:int = -20;
		public var startShootYDisplace:int = -90;
		
		public function EntityPlayerTest() 
		{
			super();
			
			image = new Image(TextureList.atlas_player.getTexture("player_3"));
			art.addChild(image);
			
			art.pivotX = art.width / 2;
			art.pivotY = art.height;
		}
		
		override public function input(type:int, data:Vector.<Number>, e:TouchEvent):void 
		{
			if (type == TouchType.CLICK)
			{
				var distPlayerStart:Number = MathHelper.dis2(art.x+startShootXDisplace, art.y+startShootYDisplace, data[0], data[1]);
				var distPlayerEnd:Number = MathHelper.dis2(art.x+startShootXDisplace, art.y+startShootYDisplace, data[2], data[3]);
				var distDraw:Number = MathHelper.dis2(data[2], data[3], data[0], data[1]);
				if (distPlayerStart < startShootRadius && distDraw > 50 && distPlayerEnd > startShootRadius) {
					//Main.world.enemyManager.makeBullet(0,data[0], data[1],data[2],data[3]);
					Main.world.entityManager.makeBullet(0, art.x, art.y-120,data[2],data[3]);
				}
			}
		}
	}
}