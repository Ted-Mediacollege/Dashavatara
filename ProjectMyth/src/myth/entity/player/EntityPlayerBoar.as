package myth.entity.player 
{
	import adobe.utils.CustomActions;
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.geom.Point;
	import myth.graphics.AssetList;
	import nape.geom.Vec2;
	import starling.display.Image;
	import starling.display.QuadBatch;
	import starling.display.Shape;
	import starling.events.TouchEvent;
	import myth.input.TouchType;
	import starling.events.TouchPhase;
	import myth.Main;
	import myth.util.Debug;
	import myth.util.MathHelper;
	import myth.particle.slashPart;
	import pixelpaton.FindSmoothPathBetweenNodes;
	import com.cartogrammar.drawing.CubicBezier;
	import starling.textures.Texture;
	import treefortress.spriter.SpriterClip;
	import starling.core.Starling;
	import myth.util.TimeHelper;
	//lion
	public class EntityPlayerBoar extends EntityPlayerBase
	{
		public var clip:SpriterClip;
		private var startXpos:Number = 0;
		private var xDisplacment:Number = 0;
		private var sprintTimer:Number = 0;
		private const sprintTime:Number = 2.0;
		public function EntityPlayerBoar() 
		{
			//super(true, false, true,128,200,-64,-200 );
			super(false,100,PlayerType.Boar,AssetList.assets.getTexture("gui_icon2"),AssetList.assets.getTexture("gui_icon2_d"));
			startXpos = 100;
			//player art
			clip = AssetList.spriterLoader.getSpriterClip("animSwine");
			clip.playbackSpeed = 1;
			clip.scaleX = 0.7;
			clip.scaleY = 0.7;
			clip.play("Run");
			//addChild(clip);
			
			Main.world.gameJuggler.add(clip);
			artLayer.addChild(clip);
		}
		
		override public function input(type:int, data:Vector.<Number>, e:TouchEvent):void {
			if (e.touches[0].phase == TouchPhase.BEGAN) {
				
			}else if (e.touches[0].phase == TouchPhase.ENDED) {
				if (Xpos < 1050) {
					xDisplacment += 400;
					if (clip.animation.name == "Run") {
						clip.play("sprint");
						sprintTimer = sprintTime;
					}
				}
			}else if (e.touches[0].phase == TouchPhase.MOVED) {
				
			}
		}
		
		override public function pushBackRock():void {
			clip.play("knockback");
			super.pushBackRock();
		}
		
		override public function tick():void {
			super.tick();
			//Animation
			if (sprintTimer > 0) {
				sprintTimer -= TimeHelper.deltaTime;
			}else if (clip.animation.name == "sprint") {
				clip.play("Run");
			}
			
			//Displaysment
			//trace("displ: "+xDisplacment);
			//trace("xpos : "+Xpos);
			if (xDisplacment > 0) {
				xDisplacment -= 20;
				if (xDisplacment < 0) {
					xDisplacment = 0;
				}
			}else if (xDisplacment < 0){
				xDisplacment += 20;
				if (xDisplacment > 0) {
					xDisplacment = 0;
				}
			}
			Xpos = startXpos + xDisplacment;
		}
		
	}
}
