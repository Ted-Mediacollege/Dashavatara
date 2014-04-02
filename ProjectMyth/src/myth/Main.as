package myth 
{
	import flash.events.Event;
	import myth.gui.game.GuiLoading;
	import myth.gui.game.GuiMainMenu;
	import myth.gui.GuiScreen;
	import myth.input.KeyInput;
	import myth.world.World;
	import starling.display.Image;
	import starling.display.Sprite;
	import myth.input.TouchInput;
	import starling.events.EnterFrameEvent;
	import starling.events.KeyboardEvent;
	import starling.events.Touch;
	import starling.events.TouchEvent;
	import myth.util.TimeHelper;
	import myth.util.ScaleHelper;
	import starling.textures.Texture;
	import myth.sound.SoundPlayer;
	import myth.graphics.AssetList;
	
	public class Main extends Sprite
	{
		public static var gui:GuiScreen;
		public static var world:World;
		
		public var input:TouchInput;
		public var keyboard:KeyInput;
		
		public static var fade:Sprite;
		public static var fadeImg:Image;
		public static var fadeTex:Texture;
		private static var gameLayer:Sprite;
		private static var fadeLayer:Sprite;
		private static var fadeNum:Number = 1;
		private static var fadeOut:Boolean = false;
		private static var newGui:GuiScreen;
		private static var bg:Boolean;
		private static var menuState:int = 0;
		private static var inTransision:Boolean = false;
		
		public function Main() 
		{
			fadeImg = new Image(Texture.fromColor(5,3,0xff000000));
			fade = new Sprite();
			fade.addChild(fadeImg);
			fadeImg.scaleX = 256;
			fadeImg.scaleY = 256;
			
			gameLayer = new Sprite();
			fadeLayer = new Sprite();
			fadeLayer.touchable = false;
			addChild(gameLayer);
			addChild(fadeLayer);
			
			this.scaleX = ScaleHelper.scaleX;
			this.scaleY = ScaleHelper.scaleY;
			
			SoundPlayer.init();
			AssetList.load();
			
			input = new TouchInput();
			addEventListener(TouchEvent.TOUCH, input.onMouse);
			
			keyboard = new KeyInput();
			addEventListener(KeyboardEvent.KEY_DOWN, keyboard.onKeyDown);
			addEventListener(KeyboardEvent.KEY_UP, keyboard.onKeyUp);
			
			addEventListener(EnterFrameEvent.ENTER_FRAME, tick);
			
			switchGui(new GuiLoading());
		}
		
		public function tick(e:EnterFrameEvent):void
		{
			if (gui != null)
			{
				//if(fadeNum == 0){
					gui.tick();
				//}
			}
			//fadein
			if(fade.parent != null){
				if(fadeOut){
					fadeNum -= 0.05;
					if (fadeNum < 0) {
						fadeNum = 0;
						fadeLayer.removeChild(fade);
					}
					fade.alpha = fadeNum;
				}else {//fadeout
					if (fade.parent != null) {
						fadeLayer.addChild(fade);
					}
					fadeNum += 0.05;
					if (fadeNum > 1) {
						if (gui != null)
						{	
							fade.alpha = fadeNum;
							gui.destroy();
							gameLayer.removeChild(gui);
						}
						fadeOut = true;
						fadeNum = 1;
						gui = newGui;
						gameLayer.addChild(gui);
						gui.preInit(this, bg);
						gui.init();
					}
					fade.alpha = fadeNum;
					inTransision = false;
				}
			}
			TimeHelper.tick();
		}
		
		public function switchGui(_newgui:GuiScreen, _bg:Boolean = false):void
		{
			if (!inTransision) {
				newGui = _newgui;
				bg = _bg;
				if (menuState < 1) 
				{
					menuState++;				
					gameLayer.addChild(newGui);
					gui = newGui;
					gui.preInit(this, bg);
					gui.init();
				}else 
				{
					inTransision = true;
					fadeOut = false;
					fadeLayer.addChild(fade);
				}
			}
		}
		
		public static function onDeactivate(e:Event):void
		{
		}
	}
}