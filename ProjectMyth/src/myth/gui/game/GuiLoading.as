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
	import myth.data.Theme;
	import starling.display.BlendMode;
	import starling.filters.ColorMatrixFilter;
	import starling.filters.FragmentFilter;
	
	public class GuiLoading extends GuiScreen
	{
		public static var ready:int = 0;
		public static var progress:Number = 0;
		public static var KevinIsEenRareEngeVampier:GuiText;
		
		private var filler:Shape;
		private var screen:Image;
		private var screen2:Image;
		
		public function GuiLoading() 
		{
			
		}
		
		override public function init():void 
		{ 
			ready = 0;
			progress = 0;
			
			filler = new Shape();
			addChild(filler);
			
			screen2 = Image.fromBitmap(new PreLoader.texture_screen2());
			screen2.x = 362;
			screen2.y = 498;
			addChild(screen2);
			
			filler = new Shape();
			addChild(filler);
			
			screen = Image.fromBitmap(new PreLoader.texture_screen1());
			addChild(screen);
			
			KevinIsEenRareEngeVampier = new GuiText(screenWidth / 2, screenHeight / 2 + 90, 500, 200, "center", "center", "Loading Textures...", 55, 0xFFFFFF, "GameFont");
			addChild(KevinIsEenRareEngeVampier);
			
			AssetList.preLoad(Theme.MENU_THEME);
		}
		
		override public function tick():void 
		{ 		
			super.tick();
			filler.graphics.clear();
			filler.graphics.lineStyle(0, 0x000000);
			filler.graphics.beginFill(0x000000);
			filler.graphics.drawRect(362 + progress * 555, 498, 555 - progress * 555, 130);
			
			if (ready < 2)
			{
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
			removeChild(screen2);
			screen2 = null;
			PreLoader.texture_screen1 = null;
			PreLoader.texture_screen2 = null;
		}
	}
}