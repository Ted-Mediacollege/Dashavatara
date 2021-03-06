package myth.entity.player 
{
	import starling.display.MovieClip;
	import starling.core.Starling;
	import myth.graphics.AssetList;
	import myth.input.TouchType;
	import starling.events.TouchEvent;
	//fish
	public class EntityPlayer02v2 extends EntityPlayerBase
	{
		public var animationWalk:MovieClip;
		
		public function EntityPlayer02v2() 
		{
			super(true,200);
			
			animationWalk = new MovieClip(AssetList.atlas_fish.getTextures("FishAvatar"), 30);
			animationWalk.x = 0;
			animationWalk.y = 0;
			animationWalk.loop = true;
			animationWalk.play();
			Main.world.gameJuggler.add(animationWalk);
			art.addChild(animationWalk);
			
			art.pivotX = art.width / 2;
			art.pivotY = art.height;
		}
		
		override public function input(type:int, data:Vector.<Number>, e:TouchEvent):void 
		{
			if (type == TouchType.CLICK)
			{
			}
		}
	}
}