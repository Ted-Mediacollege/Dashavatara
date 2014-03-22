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
	import myth.graphics.Display;
	import myth.graphics.LayerID;
	
	
	public class GuiGame extends GuiScreen 
	{
		private var bg:Image;
		private var levelName:String;
		private var pause:Boolean = false;
		private var pauseScreen:Boolean = false;
		
		private var b1:GuiButton;
		private var b2:GuiButton;
		private var b3:GuiButton;
		private var pauseb1:GuiButton;
		private var pauseb2:GuiButton;
		
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
		
		private var editorTesting:Boolean = false;
		public static var editorString:String = "";
		
		public function GuiGame(_levelName:String, _editorString:String = null) 
		{
			levelName = _levelName;
			editorTesting = false;
			editorString = "";
			
			if (_editorString != null)
			{
				editorTesting = true;
				editorString = _editorString;
			}
		}	
		
		private var gameScreen:Sprite = new Sprite();
		override public function init():void
		{
			addChild(gameScreen);
			Display.InitGameLayers(gameScreen);
			
			background = null;
			
			if (editorTesting)
			{
				Main.world = new World(this, levelName, editorTesting, editorString);
			}
			else
			{
				Main.world = new World(this, levelName);
			}
			Main.world.init();
			//Display.add(Main.world,LayerID.GameLevel);
			
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
			pauseb1 = addButton(new GuiButton(0, TextureList.assets.getTexture("gui_button_default"), screenWidth / 2, screenHeight / 2 -50, 450, 100, "Resume", 25, 0x000000));
			pauseb2 = addButton(new GuiButton(1, TextureList.assets.getTexture("gui_button_default"), screenWidth / 2, screenHeight / 2	+60, 450, 100, "Menu", 25, 0x000000));
		}
		
		private function removePauseButtons():void
		{
			removeButton(pauseb1);
			removeButton(pauseb2);
		}
		
		private function unPause():void {
			Display.layerVisible(true,LayerID.GameLevel);
			Display.layerVisible(true,LayerID.GameGui);
			gameScreen.removeChild(pauseScreenImage);
			gameScreen.removeChild(pauseScreenImage2);
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
				if (button.buttonID == 13 && editorTesting)
				{
					main.switchGui(new GuiEditor(editorString));
				}
				
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
					pauseScreenTexture.draw(gameScreen,drawMatrix);
					
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
					gameScreen.addChild(pauseScreenImage2);
					gameScreen.addChild(pauseScreenImage);
					
					Display.layerVisible(false,LayerID.GameLevel);
					Display.layerVisible(false,LayerID.GameGui);
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
		
		public function build():void {
			b1 = addButton(new GuiButton(10, Main.world.players[0].playerTexture, 100, 80, 194, 142, ""),false);
			b2 = addButton(new GuiButton(11, Main.world.players[1].playerTexture, 300, 80, 194, 142, ""),false);
			b3 = addButton(new GuiButton(12, Main.world.players[2].playerTexture, 500, 80, 194, 142, ""),false);
			Display.add(b1,LayerID.GameGui);
			Display.add(b2,LayerID.GameGui);
			Display.add(b3,LayerID.GameGui);
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
			//removeChild(Main.world);
			Main.world.onRemove();
			Main.world = null;
		}
	}
}