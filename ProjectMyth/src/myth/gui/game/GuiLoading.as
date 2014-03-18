package myth.gui.game 
{
	import myth.gui.GuiScreen;
	import myth.gui.components.GuiButton;
	import myth.input.TouchType;
	import myth.gui.components.GuiText;
	import myth.gui.background.GuiBackground;
	import starling.display.Image;
	import starling.events.TouchEvent;
	import myth.graphics.TextureList;
	import myth.Main;
	import myth.PreLoader;
	import myth.util.ScaleHelper;
	
	public class GuiLoading extends GuiScreen
	{
		public static var ready:int = 0;
		public static var progress:Number = 0;
		public static var KevinIsEenRareEngeVampier:GuiText;
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
			
			KevinIsEenRareEngeVampier = new GuiText(screenWidth / 2, screenHeight / 2, 400, 60, "center", "center", "Loading 0%", 25, 0x000000);
			addChild(KevinIsEenRareEngeVampier);
			
			TextureList.preLoad();
		}
		
		override public function tick():void 
		{ 
			if (ready < 2)
			{
				KevinIsEenRareEngeVampier.text.text = "Loading " + Math.floor(progress * 100) + "%";
			}
			else
			{
				KevinIsEenRareEngeVampier.text.text = "Tap to continue";
			}
		}
		
		override public function input(type:int, data:Vector.<Number>, e:TouchEvent):void 
		{
			if (ready > 1)
			{
				main.switchGui(new GuiMainMenu());
			}
		}		
		
		override public function preInit(m:Main):void
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