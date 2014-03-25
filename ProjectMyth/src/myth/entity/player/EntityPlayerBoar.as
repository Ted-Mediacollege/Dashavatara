package myth.entity.player 
{
	import adobe.utils.CustomActions;
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.geom.Point;
	import myth.graphics.TextureList;
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
	//lion
	public class EntityPlayerBoar extends EntityPlayerBase
	{
		
		public var image:SpriterClip;
		public function EntityPlayerBoar() 
		{
			//super(true, false, true,128,200,-64,-200 );
			super(false,300,PlayerType.Boar,TextureList.assets.getTexture("gui_icon2"));
			
			//player art
			image = TextureList.spriterLoader.getSpriterClip("animSwine");
			image.playbackSpeed = 1;
			image.scaleX = 0.7;
			image.scaleY = 0.7;
			image.play("Run");
			addChild(image);
			Main.world.gameJuggler.add(image);
			
			artLayer.addChild(image);
		}
		
		override public function input(type:int, data:Vector.<Number>, e:TouchEvent):void {
			
		}
		
	}
}
