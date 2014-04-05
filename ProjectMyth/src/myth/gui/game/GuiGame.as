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
	import myth.gamemode.GameMode;
	import myth.gui.components.GuiButton;
	import myth.gui.components.GuiButtonToggle;
	import myth.gui.components.GuiText;
	import myth.gui.GuiScreen;
	import myth.Main;
	import myth.world.World;
	import myth.graphics.AssetList;
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
	import myth.PreLoader;
	import myth.data.GameData;
	import myth.lang.Lang;
	
	public class GuiGame extends GuiScreen 
	{
		private var bg:Image;
		private var pauseScreen:Boolean = false;
		
		private var puaseButton:GuiButtonToggle;
		private var b1:GuiButtonToggle;
		private var b2:GuiButtonToggle;
		private var b3:GuiButtonToggle;
		private var pauseb1:GuiButton;
		private var pauseb2:GuiButton;
		private var pauseb3:GuiButton;
		
		private var help_text_temp:GuiText;
		private var help_fade:int;
		private var help_visible:Boolean;
		private var gameLayer:Sprite;
		
		private var gamemode:GameMode;
		private var gameScreen:Sprite = new Sprite();
		
		public function GuiGame(gm:GameMode) 
		{
			gamemode = gm;
		}	
		
		override public function init():void
		{
			if (GameData.DEVELOPMENT)
			{
				PreLoader.starling.showStats = true;
			}
			
			addChild(gameScreen);
			Display.InitGameLayers(gameScreen);
			
			Main.world = new World(this, gamemode);
			Main.world.init();
			
			puaseButton = new GuiButtonToggle(
				13, AssetList.assets.getTexture("gui_button_pause"),
				AssetList.assets.getTexture("gui_button_pause_d"),
				1280 - (114 / 2) - 10, 10 + (114 / 2), 114, 114, "",false
			);
			addButton(puaseButton);
			
			help_text_temp = new GuiText(40, 700, 1200, 100, "left", "top", "Swipe to slash", 40, 0x000000, "Arial");
			addChild(help_text_temp);
			help_visible = true;
			help_fade = 100;
			help_text_temp.alpha = 1;
		}
		
		private function createPauseButtons():void 
		{
			pauseb2 = addButton(new GuiButton(0, AssetList.assets.getTexture("gui_button_default"), screenWidth / 2, screenHeight / 2 -90, 450, 100, Lang.trans(Lang.MENU, "main.back"), 45, 0xf1d195, "GameFont"));
			pauseb3 = addButton(new GuiButton(1, AssetList.assets.getTexture("gui_button_default"), screenWidth / 2, screenHeight / 2 +30, 450, 100, Lang.trans(Lang.INGAME, "menu.restart"), 45, 0xf1d195, "GameFont"));
			pauseb1 = addButton(new GuiButton(2, AssetList.assets.getTexture("gui_button_default"), screenWidth / 2, screenHeight / 2 +150, 450, 100, Lang.trans(Lang.INGAME, "menu.resume"), 45, 0xf1d195, "GameFont"));
		}
		
		private function removePauseButtons():void
		{
			removeButton(pauseb1);
			removeButton(pauseb2);
			removeButton(pauseb3);
		}
		
		override public function action(button:GuiButton):void
		{
			if (button.buttonID == 13 ||button.buttonID == 2) 
			{
				gamemode.onPause();
				
				if (!Main.inTransision)
				{
					if (pauseScreen)
					{
						puaseButton.setState(false);
						pauseScreen = false;
						removePauseButtons();
						b1.freez = false;
						b2.freez = false;
						b3.freez = false;
					}
					else
					{
						puaseButton.setState(true);
						createPauseButtons();
						pauseScreen = true;
						b1.freez = true;
						b2.freez = true;
						b3.freez = true;
					}
				}
			}
			else if (button.buttonID == 1)
			{
				gamemode.onRestart();
			}
			else if (button.buttonID == 0)
			{
				main.switchGui(new GuiMainMenu(), true);
			}
			else if (button.buttonID > 9)
			{
				if (!pauseScreen)
				{
					if (button.buttonID == 10) {
						b1.setState(true);
						b2.setState(false);
						b3.setState(false);
					}else if (button.buttonID == 11) {
						b1.setState(false);
						b2.setState(true);
						b3.setState(false);
					}else if (button.buttonID == 12) {
						b1.setState(false);
						b2.setState(false);
						b3.setState(true);
					}
					Main.world.playerHolder.switchAvatar(button.buttonID - 10);
					
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
		}
		
		override public function tick():void
		{	
			super.tick();
			if (help_fade > 0 && !help_visible)
			{
				help_fade--;
				help_text_temp.alpha = Number(help_fade) / 100.0;
			}
			
			if (!pauseScreen)
			{
				Main.world.tick();
			}
		}
		
		public function build():void 
		{
			b1 = new GuiButtonToggle(
				10,
				Main.world.playerHolder.players[0].playerTexture,
				Main.world.playerHolder.players[0].playerTextureDown,
				100, 80, 194, 142, "", false
			);
			addButton(b1, false);
			
			b2 = new GuiButtonToggle(
				11, Main.world.playerHolder.players[1].playerTexture,
				Main.world.playerHolder.players[1].playerTextureDown,
				300, 80, 194, 142, "", true
			);
			addButton(b2,false);
			b3 = new GuiButtonToggle(
				12, Main.world.playerHolder.players[2].playerTexture,
				Main.world.playerHolder.players[2].playerTextureDown,
				500, 80, 194, 142, "", false
			)
			addButton(b3,false);
			Display.add(b1,LayerID.GameGui);
			Display.add(b2,LayerID.GameGui);
			Display.add(b3,LayerID.GameGui);
		}
		
		override public function input(type:int, data:Vector.<Number>, e:TouchEvent):void 
		{
			if (!pauseScreen)
			{
				Main.world.input(type, data, e);
			}
			if (help_visible)
			{
				help_visible = false;
				help_fade = 100;
			}
		}
		
		override public function destroy():void
		{
			PreLoader.starling.showStats = false;
			
			//removeChild(Main.world);
			Main.world.onRemove();
			Main.world = null;
		}
	}
}