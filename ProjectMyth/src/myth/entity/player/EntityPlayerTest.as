package myth.entity.player 
{
	import starling.display.MovieClip;
	import starling.core.Starling;
	import myth.graphics.TextureList;
	import myth.input.TouchType;
	import starling.events.TouchEvent;
	
	public class EntityPlayerTest extends EntityPlayerBase
	{
		public var animationWalk:MovieClip;
		
		public function EntityPlayerTest() 
		{
			super();
			
			animationWalk = new MovieClip(TextureList.atlas_fish.getTextures("vis bouncing and jumping"), 30);
			animationWalk.pivotY = 378;
			animationWalk.pivotX = 127;
			animationWalk.loop = true;
			animationWalk.play();
			Starling.juggler.add(animationWalk);
			art.addChild(animationWalk);
		}
		
		override public function input(type:int, data:Vector.<Number>, e:TouchEvent):void 
		{
			if (type == TouchType.CLICK)
			{
				if (isOnFeet())
				{
					velY = -3;
					onfeet = false;
				}
			}
		}
	}
}