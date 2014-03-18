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
	import treefortress.spriter.SpriterClip;
	
	//fluit
	public class EntityPlayer03 extends EntityPlayerBase
	{
		public var image:SpriterClip;
		public var animationWalk:MovieClip;
		public var jumping:Boolean;
		public var cooldownFix:int;
		
		public function EntityPlayer03() 
		{
			super(false,300,PlayerType.Fluit,TextureList.assets.getTexture("gui_icon1"));
			
			image = TextureList.spriterLoader.getSpriterClip("animFlute");
			image.playbackSpeed = 1;
			image.scaleX = 1;
			image.scaleY = 1;
			image.play("running1");
			addChild(image);
			Starling.juggler.add(image);
			jumping = false;
			
			/*image = new Image(TextureList.atlas_player.getTexture("player_4"));
			image.scaleX = -1;
			image.pivotX = image.width / 2;
			image.pivotY = image.height;
			art.addChild(image);*/
			
			//animationWalk = new MovieClip(TextureList.atlas_fish.getTextures("vis bouncing and jumping"), 30);
			//animationWalk.pivotY = 378;
			//animationWalk.pivotX = 127;
			//animationWalk.loop = true;
			//animationWalk.play();
			//Starling.juggler.add(animationWalk);
			//addChild(animationWalk);
		}
		
		override public function tick():void
		{
			super.tick();
			
			cooldownFix--;
			if (jumping && cooldownFix < 0 && isOnFeet())
			{
				jumping = false;
				image.play("running1");
			}
		}
		
		override public function input(type:int, data:Vector.<Number>, e:TouchEvent):void {
			
			//data vector = posX, posY, movedX, movedY
			if (e.touches[0].phase == TouchPhase.BEGAN) {
				
			}else if (e.touches[0].phase == TouchPhase.ENDED) {
				if (isOnFeet())
				{
					//trace("jump");
					Main.world.physicsWorld.playerBody.applyImpulse(new Vec2(0, -18000));
					onfeet = false;
					image.play("jump");
					jumping = true;
					cooldownFix = 20;
				}
			}
		}
	}
}