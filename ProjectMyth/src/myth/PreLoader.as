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
	import flash.system.Capabilities;
	import myth.data.GameData;
	import flash.display.StageQuality;
	import myth.data.SaveData;
	import myth.lang.Lang;
	
	public class PreLoader extends Sprite
	{
		public static var starling:Starling;
		
		[Embed(source="../../lib/embed/loadingscreen.png")]
		public static var texture_screen:Class;
		private var screen:Bitmap;
		
		public function PreLoader() 
		{		
			GameData.ISCOMPUTER = isOperatorComputer();
			GameData.SYSTEM_LANG_ID = getLanguageID();

			SaveData.init();
			
			stage.quality = StageQuality.LOW;
			screen = new texture_screen();
			screen.scaleX = stage.fullScreenWidth / 1280;
			screen.scaleY = stage.fullScreenHeight / 768;
			addChild(screen);
			
			stage.scaleMode = StageScaleMode.NO_SCALE;
			stage.align = StageAlign.TOP_LEFT;
			stage.addEventListener(flash.events.Event.DEACTIVATE, deactivate);
			
			ScaleHelper.init(stage.fullScreenWidth, stage.fullScreenHeight);
			starling = new Starling(Main, stage, new Rectangle(0, 0, stage.fullScreenWidth, stage.fullScreenHeight));
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
			SaveData.save();
			
			if (!GameData.ISCOMPUTER)
			{
				NativeApplication.nativeApplication.exit();
			}
		}
		
		public function getLanguageID():int
		{
			var lang:String = Capabilities.language;
			switch(lang)
			{
				case "nl": return 1;
				default: return 0;
			}
		}
		
		public function isOperatorComputer():Boolean
		{
			var os:String = Capabilities.os;
			
			if (os == null)
			{
				return false;
			}
			
			if (os.indexOf("Windows") > -1)
			{
				if (os == "Windows Mobile" || os == "Windows SmartPhone" || os == "Windows PocketPC" || os == "Windows CEPC")
				{
					return false;
				}
				return true;
			}
			else if (os.indexOf("Mac OS") > -1 || os.indexOf("Linux") > -1)
			{
				return true;
			}
			else
			{
				return false;
			}
		}
	}
}