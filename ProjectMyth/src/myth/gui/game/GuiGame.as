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
	import myth.input.TouchType;
	import starling.events.TouchPhase;
	import myth.input.TouchInput;
	import starling.textures.Texture;
	import myth.util.MathHelper;
	
	public class GuiGame extends GuiScreen 
	{
		private var bg:Image;
		private var pauseScreen:Boolean = false;
		
		public var puaseButton:GuiButtonToggle;
		public var b1:GuiButtonToggle;
		public var b2:GuiButtonToggle;
		public var b3:GuiButtonToggle;
		private var pauseb1:GuiButton;
		private var pauseb2:GuiButton;
		private var pauseb3:GuiButton;
		
		private var gameLayer:Sprite;
		
		private var gamemode:GameMode;
		private var gameScreen:Sprite = new Sprite();
		
		public static var restartText:String;
		
		private var loadSprite:Sprite;
		private var loadImg:Image;
		public var loading:Boolean;
		public var waiting:int;
		private var loadCircle:Image;
		
		public function GuiGame(gm:GameMode) 
		{
			gamemode = gm;
		}	
		
		override public function init():void
		{	
			loading = true;
			waiting = -999;
			
			
			restartText = Lang.trans(Lang.INGAME, "menu.restart");
			
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
			
			TouchInput.inputEnabled = false;
			loadSprite = new Sprite();
			loadImg = new Image(Texture.fromColor(5, 3, 0xff000000));
			loadImg.scaleX = 256;
			loadImg.scaleY = 256;
			loadSprite.addChild(loadImg);
			addChild(loadSprite);			
			loadCircle = new Image(AssetList.assets.getTexture("hoofd"));
			loadSprite.addChild(loadCircle);
			loadCircle.x = 1140;
			loadCircle.y = 640;
			loadCircle.pivotX = loadCircle.width / 2 + 15;
			loadCircle.pivotY = loadCircle.height / 2 + 15;
		}
		
		private function createPauseButtons():void 
		{
			pauseb2 = addButton(new GuiButton(0, AssetList.assets.getTexture("gui_button_default"), screenWidth / 2, screenHeight / 2 -90, 450, 100, Lang.trans(Lang.MENU, "main.back"), 45, 0xf1d195, "GameFont"));
			pauseb3 = addButton(new GuiButton(1, AssetList.assets.getTexture("gui_button_default"), screenWidth / 2, screenHeight / 2 +30, 450, 100, restartText, 45, 0xf1d195, "GameFont"));
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
					b1.setState(button.buttonID == 10 ? true : false);
					b2.setState(button.buttonID == 11 ? true : false);
					b3.setState(button.buttonID == 12 ? true : false);

					Main.world.playerHolder.switchAvatar(button.buttonID - 10);
				}
			}
		}
		
		override public function tick():void
		{	
			super.tick();
			
			if (waiting > -50)
			{
				waiting--;
				if (waiting == 0)
				{
					loading = false;
					TouchInput.inputEnabled = true;
					loadSprite.removeChild(loadCircle);
				}
				
				if (waiting > 0)
				{
					loadCircle.rotation += 0.15;
				}
				
				if (waiting < 0)
				{
					loadSprite.alpha = (waiting / 50) + 1;

					if (waiting == -50)
					{
						waiting = -999;
						removeChild(loadSprite);
						loadImg = null;
						loadSprite = null;
					}
				}
			}
			
			if (!pauseScreen && !loading)
			{
				Main.world.tick();
			}
		}
		
		public function build():void 
		{
			waiting = 60;
			
			b1 = new GuiButtonToggle(
				10,
				Main.world.playerHolder.players[0].playerTexture,
				Main.world.playerHolder.players[0].playerTextureDown,
				100, 80, 194, 142, "", true
			);
			addButton(b1, false);
			
			b2 = new GuiButtonToggle(
				11, Main.world.playerHolder.players[1].playerTexture,
				Main.world.playerHolder.players[1].playerTextureDown,
				300, 80, 194, 142, "", false
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
		}
		
		override public function destroy():void
		{
			Main.world.onRemove();
			Main.world = null;
		}
		
		override public function touch(type:int, data:Vector.<Number>, e:TouchEvent):void
		{
			var i:int = 0;
			if (type == TouchType.CLICK)
			{
				for (i = 0; i < buttonList.length; i++ )
				{
					if (buttonList[i].enabled &&
						data[0] > buttonList[i].posX - buttonList[i].posWidth / 2 && 
						data[1] > buttonList[i].posY - buttonList[i].posHeight / 2 && 
						data[2] > buttonList[i].posX - buttonList[i].posWidth / 2 && 
						data[3] > buttonList[i].posY - buttonList[i].posHeight / 2 && 
						data[0] < buttonList[i].posX + buttonList[i].posWidth / 2 && 
						data[1] < buttonList[i].posY + buttonList[i].posHeight / 2 &&
						data[2] < buttonList[i].posX + buttonList[i].posWidth / 2 && 
						data[3] < buttonList[i].posY + buttonList[i].posHeight / 2
						)
					{
						gamemode.onButtonPress(buttonList[i].buttonID);
						buttonList[i].click();
						AssetList.soundCommon.playSound("button");
						action(buttonList[i]);
						break;
					}
				}
			}
			if (e.touches[0].phase == TouchPhase.BEGAN) 
			{
				for (i = 0; i < buttonList.length; i++ )
				{
					if (buttonList[i].enabled &&
						e.touches[0].getLocation(Main.gui).x > buttonList[i].posX - buttonList[i].posWidth / 2 && 
						e.touches[0].getLocation(Main.gui).y > buttonList[i].posY - buttonList[i].posHeight / 2 && 
						e.touches[0].getLocation(Main.gui).x < buttonList[i].posX + buttonList[i].posWidth / 2 && 
						e.touches[0].getLocation(Main.gui).y < buttonList[i].posY + buttonList[i].posHeight / 2
						)
					{
						buttonTouched = true;
						break;
					}
				}
			}
			if (e.touches[0].phase == TouchPhase.ENDED) 
			{
				buttonTouched = false;
			}
			if (!buttonTouched)
			{
				input(type, data, e);
			}
		}
	}
}