package myth.gui.game 
{
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.filters.DisplacementMapFilter;
	import flash.filters.DisplacementMapFilterMode;
	import flash.geom.Matrix;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	import flash.display.BitmapDataChannel;
	import myth.gui.components.GuiButton;
	import myth.gui.components.GuiText;
	import myth.gui.GuiScreen;
	import myth.Main;
	import myth.world.World;
	import myth.graphics.TextureList;
	import myth.gui.background.GuiBackground;
	import myth.util.ScaleHelper;
	import starling.core.RenderSupport;
	import starling.display.DisplayObject;
	import starling.display.Sprite;
	import starling.display.Image;
	import starling.display.Stage;
	import starling.events.TouchEvent;
	import starling.display.BlendMode;
	import starling.filters.BlurFilter;
	import starling.filters.ColorMatrixFilter;
	import starling.filters.FragmentFilterMode;
	import starling.textures.RenderTexture;
	import starling.core.Starling;
	
	
	
	public class GuiGame extends GuiScreen 
	{
		private var bg:Image;
		private var levelName:String;
		private var pause:Boolean = false;
		private var pauseScreen:Boolean = false;
		
		private var b1:GuiButton;
		private var b2:GuiButton;
		
		private var help_text_temp:GuiText;
		private var help_fade:int;
		private var help_visible:Boolean;
		private var pauseFilter:BlurFilter;
		private var pauseFilter2:ColorMatrixFilter;
		private var gameLayer:Sprite;
		private var pauseScreenTexture:RenderTexture;
		private var pauseScreenImage:Image;
		private var pauseScreenImage2:Image;
		private var pauseBitmapData:BitmapData;
		private var pauseBitmap:Bitmap;
		private var pauseFade:Number = 0;
		
		public function GuiGame(_levelName:String) 
		{
			levelName = _levelName;
		}	
		
		override public function init():void
		{
			background = null;
			gameLayer = new Sprite();
			Main.world = new World(this, levelName);
			Main.world.init();
			addChild(gameLayer);
			gameLayer.addChild(Main.world);
			
			addButton(new GuiButton(10, TextureList.assets.getTexture("gui_icon1"), 100, 80, 194, 142, ""));
			addButton(new GuiButton(11, TextureList.assets.getTexture("gui_icon2"), 300, 80, 194, 142, ""));
			addButton(new GuiButton(12, TextureList.assets.getTexture("gui_icon3"), 500, 80, 194, 142, ""));
			addButton(new GuiButton(13, TextureList.assets.getTexture("gui_button_pause"), 1280 - (114 / 2) - 10, 10 + (114 / 2), 114, 114, ""));
			
			help_text_temp = new GuiText(40, 700, 1200, 100, "left", "top", "Swipe to slash", 40, 0x000000, "Arial");
			addChild(help_text_temp);
			help_visible = true;
			help_fade = 100;
			help_text_temp.alpha = 1;
			
			pauseFilter = new BlurFilter(0, 0, 0);
			pauseFilter2 = new ColorMatrixFilter();
			//pauseFilter2.adjustHue(1.0);
			//pauseFilter2.adjustSaturation(2.0);
			//pauseFilter2.adjustContrast(0.8);
		}
		
		private function createPauseButtons():void 
		{
			b1 = addButton(new GuiButton(0, TextureList.assets.getTexture("gui_button_default"), screenWidth / 2, screenHeight / 2 -50, 450, 100, "Resume", 25, 0x000000));
			b2 = addButton(new GuiButton(1, TextureList.assets.getTexture("gui_button_default"), screenWidth / 2, screenHeight / 2	+60, 450, 100, "Menu", 25, 0x000000));
		}
		
		private function removePauseButtons():void
		{
			removeButton(b1);
			removeButton(b2);
		}
		
		private function unPause():void {
			gameLayer.addChild(Main.world);
			gameLayer.removeChild(pauseScreenImage);
			gameLayer.removeChild(pauseScreenImage2);
			//pauseScreenTexture.dispose();
			pauseScreenTexture = null;
			pauseScreenImage = null;
			pauseScreenImage2 = null;
			pause = false;
			removePauseButtons();
		}
		override public function action(button:GuiButton):void
		{
			if (button.buttonID == 13 ||button.buttonID == 0) 
			{
				//trace(pause + " " +pauseScreen);
				if (pause)
				{
					if(pauseScreen){
						pauseScreen = false;
					}else {
						pauseScreen = true;
					}
					//Main.world.unflatten();
					//Main.world.filter = null;
					
				}
				else if(pauseScreenImage==null)
				{
					//game screen to 1280X768 image
					pauseScreenTexture = new RenderTexture(ScaleHelper.phoneX, ScaleHelper.phoneY);
					var drawMatrix:Matrix = new Matrix();
					drawMatrix.scale(ScaleHelper.scaleX, ScaleHelper.scaleY);
					pauseScreenTexture.draw(Main.world,drawMatrix);
					
					//var textureDisplacement:Image = Image.fromBitmap(
					
					if (false) {
						var perlingDisplacement:BitmapData = new BitmapData(1280, 768);
						perlingDisplacement.perlinNoise(5, 5, 2, 30, false, true);
						var pauseScreenTempImage:Image = new Image(pauseScreenTexture);
						pauseBitmapData = copyToBitmap(pauseScreenTempImage, 1);
						var filter:flash.filters.BlurFilter = new flash.filters.BlurFilter(10,10,1);
						
						var displacementFilter:DisplacementMapFilter = new DisplacementMapFilter(perlingDisplacement, new Point(), BitmapDataChannel.RED, BitmapDataChannel.GREEN, 20, 20, DisplacementMapFilterMode.WRAP);
						pauseBitmapData.applyFilter(pauseBitmapData, new Rectangle(0, 0, 1280, 768), new Point(0, 0), displacementFilter);
						//pauseBitmapData.applyFilter(pauseBitmapData, new Rectangle(0,0,1280,768), new Point(0, 0), filter);
						pauseBitmap = new Bitmap(pauseBitmapData);
						pauseScreenImage = Image.fromBitmap(pauseBitmap);
						pauseBitmap = null;
						pauseBitmapData = null;
						pauseScreenImage.width = 1280;
						pauseScreenImage.height = 768;
						gameLayer.addChild(pauseScreenImage);
					}else {
						//pauseScreenTexture.draw(Main.world);
						pauseScreenImage = new Image(pauseScreenTexture);
						//pauseScreenImage.blendMode = BlendMode.MULTIPLY;
						pauseScreenImage.width = 1280;
						pauseScreenImage.height = 768;
						pauseScreenImage.filter = pauseFilter;
						//pauseFilter.mode = FragmentFilterMode.ABOVE;
						pauseFilter.cache();
						
						pauseScreenImage2 = new Image(pauseScreenTexture);
						//pauseScreenImage2.blendMode = BlendMode.NONE;
						pauseScreenImage2.width = 1280;
						pauseScreenImage2.height = 768;
						
						//pauseFilter2.mode = FragmentFilterMode.ABOVE;
						pauseScreenImage2.filter = pauseFilter2;
						pauseFilter2.cache();
						gameLayer.addChild(pauseScreenImage2);
						gameLayer.addChild(pauseScreenImage);
					}
					
					gameLayer.removeChild(Main.world);
					
					pauseScreen = true;
					createPauseButtons();
				}
			}
			else if (button.buttonID == 1)
			{
				main.switchGui(new GuiMainMenu());
			}
			else if (button.buttonID > 9 && !pause)
			{
				Main.world.switchAvatar(button.buttonID - 10);
				
				help_visible = true;
				help_fade = 100;
				help_text_temp.alpha = 1;
				switch(button.buttonID - 10)
				{
					case 0: help_text_temp.text.text = "Tap to Jump."; break;
					case 1: help_text_temp.text.text = "Swipe to slash"; break;
					case 2: help_text_temp.text.text = "Tap repeatedly to sprint."; break;
				}
			}
		}
		
		public static function copyToBitmap(disp:DisplayObject, scl:Number=1.0):BitmapData
		{
			var rc:Rectangle = new Rectangle();
			disp.getBounds(disp, rc);
		 
			var stage:Stage= Starling.current.stage;
			var rs:RenderSupport = new RenderSupport();
		 
			rs.clear();
			rs.scaleMatrix(scl, scl);
			rs.setOrthographicProjection(0, 0, stage.stageWidth, stage.stageHeight);
			rs.translateMatrix(-rc.x, -rc.y); // move to 0,0
			disp.render(rs, 1.0);
			rs.finishQuadBatch();
		 
			var outBmp:BitmapData = new BitmapData(rc.width*scl, rc.height*scl, true);
			Starling.context.drawToBitmapData(outBmp);
		 
			return outBmp;
		}

		override public function tick():void
		{	
			if (help_fade > 0 && !help_visible)
			{
				help_fade--;
				help_text_temp.alpha = Number(help_fade) / 100.0;
			}
			
			//trace(pauseFade);
			if (!pauseScreen)
			{
				if (pauseFade >= 0.01) {
					pauseFade-= 0.01;
					pauseFilter.blurX = pauseFade * 20;
					pauseFilter.blurY = pauseFade * 20;
					pauseFilter.resolution =  0.2;
					pauseFilter.cache();
					if (pauseFade <= 0.02 || pauseScreen) {
						unPause();
					}
				}else {
					Main.world.tick();
				}
			}else {
				if (pauseFade <= 0.49) {
					pauseFade+= 0.01;
					pauseFilter.blurX = pauseFade * 20;
					pauseFilter.blurY = pauseFade * 20;
					pauseFilter.resolution = 0.2;
					pauseFilter.cache();
					if (pauseFade >= 0.49) {
						pause = true;
					}
				}
			}
		}
		
		override public function input(type:int, data:Vector.<Number>, e:TouchEvent):void 
		{
			Main.world.input(type, data, e);
			
			if (help_visible)
			{
				help_visible = false;
				help_fade = 100;
			}
		}
		
		override public function destroy():void
		{
			removeChild(Main.world);
			Main.world.onRemove();
			Main.world = null;
		}
	}
}