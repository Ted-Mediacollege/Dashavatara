package myth 
{
	import starling.core.Starling;
	import flash.display.StageScaleMode;
	import flash.display.StageAlign;
	import flash.events.Event;
	import flash.desktop.NativeApplication;
	
	public class Loader 
	{
		private var starling:Starling;
		
		public function Loader() 
		{
			stage.scaleMode = StageScaleMode.NO_SCALE;
			stage.align = StageAlign.TOP_LEFT;
			stage.addEventListener(Event.DEACTIVATE, deactivate);
			
			starling = new Starling(Main, stage, new Rectangle(0, 0, stage.fullScreenWidth, stage.fullScreenHeight));
			starling.start();
		}
		
		private function deactivate(e:Event):void 
		{
			Main.onDeactivate(e);
			NativeApplication.nativeApplication.exit();
		}
	}
}