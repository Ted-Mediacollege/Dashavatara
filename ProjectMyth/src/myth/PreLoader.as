package myth 
{
	import flash.display.Bitmap;
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import starling.core.Starling;
	import flash.display.StageScaleMode;
	import flash.display.StageAlign;
	import flash.events.Event;
	import flash.desktop.NativeApplication;
	import flash.geom.Rectangle;
	import myth.util.ScaleHelper;
	import treefortress.spriter.SpriterClip;
	import starling.events.Event;
	
	public class PreLoader extends Sprite
	{
		private var starling:Starling;
		
		[Embed(source="../../lib/embed/loadingscreen.png")]
		public static var texture_screen:Class;
		private var screen:Bitmap;
		
		public function PreLoader() 
		{			
			screen = new texture_screen();
			screen.scaleX = stage.fullScreenWidth / 1280;
			screen.scaleY = stage.fullScreenHeight / 768;
			addChild(screen);
			
			stage.scaleMode = StageScaleMode.NO_SCALE;
			stage.align = StageAlign.TOP_LEFT;
			stage.addEventListener(flash.events.Event.DEACTIVATE, deactivate);
			
			ScaleHelper.init(stage.fullScreenWidth, stage.fullScreenHeight);
			
			starling = new Starling(Main, stage, new Rectangle(0, 0, stage.fullScreenWidth, stage.fullScreenHeight));
			starling.showStats = true;
			starling.start();
			
			starling.addEventListener(starling.events.Event.CONTEXT3D_CREATE, onStarlingLoadComplete);
		}
		
		public function onStarlingLoadComplete(e:starling.events.Event):void
		{
			removeChild(screen);
			screen = null;
		}
		
		private function deactivate(e:flash.events.Event):void 
		{
			Main.onDeactivate(e);
			NativeApplication.nativeApplication.exit();
		}
	}
}