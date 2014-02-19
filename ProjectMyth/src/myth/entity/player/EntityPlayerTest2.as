package myth.entity.player 
{
	import starling.display.MovieClip;
	import starling.core.Starling;
	import myth.graphics.TextureList;
	import myth.input.TouchType;
	import starling.events.TouchEvent;
	
	public class EntityPlayerTest2 extends EntityPlayerBase
	{
		public var animationWalk:MovieClip;
		
		public function EntityPlayerTest2() 
		{
			super();
			
			animationWalk = new MovieClip(TextureList.atlas_fish.getTextures("vis bouncing and jumping"), 30);
			animationWalk.x = 0;
			animationWalk.y = 0;
			animationWalk.loop = true;
			animationWalk.play();
			Starling.juggler.add(animationWalk);
			art.addChild(animationWalk);
			
			art.pivotX = art.width / 2;
			art.pivotY = art.height;
		}
		
		override public function input(type:int, data:Vector.<Number>, e:TouchEvent):void 
		{
			if (type == TouchType.CLICK)
			{
				if (isOnFeet())
				{
					velY = -17;
					onfeet = false;
				}
			}
		}
	}
}