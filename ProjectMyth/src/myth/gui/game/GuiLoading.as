package myth.gui.game 
{
	import myth.gui.GuiScreen;
	import myth.gui.components.GuiButton;
	import myth.input.TouchType;
	import myth.gui.components.GuiText;
	import myth.gui.background.GuiBackground;
	import starling.display.Image;
	import starling.display.Shape;
	import starling.events.TouchEvent;
	import myth.graphics.AssetList;
	import myth.Main;
	import myth.PreLoader;
	import myth.util.ScaleHelper;
	import myth.lang.Lang;
	import myth.data.GameData;
	
	public class GuiLoading extends GuiScreen
	{
		public static var ready:int = 0;
		public static var progress:Number = 0;
		public static var KevinIsEenRareEngeVampier:GuiText;
		
		private var filler:Shape;
		private var screen:Image;
		
		public function GuiLoading() 
		{
			
		}
		
		override public function init():void 
		{ 
			ready = 0;
			progress = 0;
			
			screen = Image.fromBitmap(new PreLoader.texture_screen());
			addChild(screen);
			
			filler = new Shape();
			addChild(filler);
			
			KevinIsEenRareEngeVampier = new GuiText(screenWidth / 2, screenHeight / 2 + 70, 400, 200, "center", "center", "Loading Animations...", 45, 0x000000, "GameFont");
			addChild(KevinIsEenRareEngeVampier);
			
			AssetList.preLoad();
		}
		
		override public function tick():void 
		{ 		
			super.tick();
			filler.graphics.clear();
			filler.graphics.lineStyle(0, 0x8890D3);
			filler.graphics.beginFill(0x8890D3);
			filler.graphics.drawRect(425, 480, progress * 450, 100);
			
			if (ready < 2)
			{
				switch(GameData.LANG)
				{
					case 0: KevinIsEenRareEngeVampier.text.text = "Loading Textures...";
					case 1: KevinIsEenRareEngeVampier.text.text = "Loading Textures...";
				}
			}
			else
			{
				KevinIsEenRareEngeVampier.text.text = Lang.trans(Lang.MENU, "loading.tap");
			}
		}
		
		override public function input(type:int, data:Vector.<Number>, e:TouchEvent):void 
		{
			if (ready > 1)
			{
				main.switchGui(new GuiMainMenu(), true);
			}
		}		
		
		override public function preInit(m:Main, bg:Boolean):void
		{
			main = m;
			buttonList = new Vector.<GuiButton>();
		}
		
		override public function destroy():void
		{
			removeChild(screen);
			screen = null;
			PreLoader.texture_screen = null;
		}
	}
}