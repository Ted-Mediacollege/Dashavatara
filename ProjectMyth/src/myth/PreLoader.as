package myth 
{
	import flash.display.Sprite;
	import starling.core.Starling;
	import flash.display.StageScaleMode;
	import flash.display.StageAlign;
	import flash.events.Event;
	import flash.desktop.NativeApplication;
	import flash.geom.Rectangle;
	import myth.util.ScaleHelper;
	
	public class PreLoader extends Sprite
	{
		private var starling:Starling;
		
		public function PreLoader() 
		{
			stage.scaleMode = StageScaleMode.NO_SCALE;
			stage.align = StageAlign.TOP_LEFT;
			stage.addEventListener(Event.DEACTIVATE, deactivate);
			
			ScaleHelper.init(stage.fullScreenWidth, stage.fullScreenHeight);
			
			starling = new Starling(Main, stage, new Rectangle(0, 0, stage.fullScreenWidth, stage.fullScreenHeight));
			starling.showStats = true;
			starling.start();
		}
		
		private function deactivate(e:Event):void 
		{
			Main.onDeactivate(e);
			NativeApplication.nativeApplication.exit();
		}
	}
}