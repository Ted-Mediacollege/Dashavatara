package myth.entity.player 
{
	import myth.graphics.AssetList;
	import nape.geom.Vec2;
	import starling.display.Image;
	import starling.display.MovieClip;
	import starling.core.Starling;
	import myth.input.TouchType;
	import starling.events.TouchEvent;
	import starling.events.TouchPhase;
	import myth.Main;
	import treefortress.spriter.SpriterClip;
	import myth.util.TimeHelper;
	
	//fluit
	public class EntityPlayer03 extends EntityPlayerBase
	{
		public var image:SpriterClip;
		public var animationWalk:MovieClip;
		public var jumping:Boolean;
		public var cooldownFix:int;
		private var canjump:Boolean = false;
		
		public function EntityPlayer03() 
		{
			super(false,300,PlayerType.Fluit,AssetList.assets.getTexture("gui_icon3"),AssetList.assets.getTexture("gui_icon3_d"),"playerHitFluit");
			
			image = AssetList.spriterLoader.getSpriterClip("animFlute");
			image.playbackSpeed = 1;
			image.scaleX = 1;
			image.scaleY = 1;
			image.play("running1");
			addChild(image);
			Main.world.gameJuggler.add(image);
			jumping = false;
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
			if(canjump) {
				jump();
			}
		}
		private function jump():void {
			if (Main.world.physicsWorld.playerBody.velocity.y > -10 && isOnFeet()){
				AssetList.soundCommon.playSound("jump");
				Main.world.physicsWorld.playerBody.applyImpulse(new Vec2(0, -18000));
				onfeet = false;
				image.play("jump");
				jumping = true;
				cooldownFix = 20;
			}
		}
		
		override public function switchPlayer():void {
			super.switchPlayer();
			canjump = false;
		}
		
		override public function input(type:int, data:Vector.<Number>, e:TouchEvent):void {
			//data vector = posX, posY, movedX, movedY
			
			if (!levelComplete) {
				if (e.touches[0].phase == TouchPhase.ENDED) {
					canjump = false;
				}
				if (e.touches[0].phase == TouchPhase.BEGAN || e.touches[0].phase == TouchPhase.MOVED || e.touches[0].phase == TouchPhase.STATIONARY) {
					canjump = true;
				}
			}else {
				canjump = false;
			}
		}
	}
}