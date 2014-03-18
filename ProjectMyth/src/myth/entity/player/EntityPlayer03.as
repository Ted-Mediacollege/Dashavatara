package myth.entity.player 
{
	import myth.graphics.TextureList;
	import nape.geom.Vec2;
	import starling.display.Image;
	import starling.display.MovieClip;
	import starling.core.Starling;
	import myth.input.TouchType;
	import starling.events.TouchEvent;
	import starling.events.TouchPhase;
	import myth.Main;
	//fluit
	public class EntityPlayer03 extends EntityPlayerBase
	{
		public var image:Image;
		public var animationWalk:MovieClip;
		public function EntityPlayer03() 
		{
			super(false,300,PlayerType.Fluit,TextureList.assets.getTexture("gui_icon1"));
			
			image = new Image(TextureList.atlas_player.getTexture("player_4"));
			image.scaleX = -1;
			image.pivotX = image.width / 2;
			image.pivotY = image.height;
			art.addChild(image);
			
			//animationWalk = new MovieClip(TextureList.atlas_fish.getTextures("vis bouncing and jumping"), 30);
			//animationWalk.pivotY = 378;
			//animationWalk.pivotX = 127;
			//animationWalk.loop = true;
			//animationWalk.play();
			//Starling.juggler.add(animationWalk);
			//addChild(animationWalk);
		}
		
		override public function input(type:int, data:Vector.<Number>, e:TouchEvent):void {
			
			//data vector = posX, posY, movedX, movedY
			if (e.touches[0].phase == TouchPhase.BEGAN) {
				
			}else if (e.touches[0].phase == TouchPhase.ENDED) {
				if (isOnFeet())
				{
					//trace("jump");
					Main.world.physicsWorld.playerBody.applyImpulse(new Vec2(0, -18000));
					velY = -17;
					onfeet = false;
				}
			}
		}
	}
}