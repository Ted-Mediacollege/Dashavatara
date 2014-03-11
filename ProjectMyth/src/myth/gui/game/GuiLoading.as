package myth.gui.game 
{
	import myth.gui.GuiScreen;
	import myth.gui.components.GuiButton;
	import myth.input.TouchType;
	import myth.gui.components.GuiText;
	import myth.gui.background.GuiBackground;
	import starling.events.TouchEvent;
	import myth.graphics.TextureList;
	
	public class GuiLoading extends GuiScreen
	{
		public var ready:Boolean = false;
		public static var progress:Number = 0;
		public static var KevinIsEenRareEngeVampier:GuiText;
		
		public function GuiLoading() 
		{
			
		}
		
		override public function init():void 
		{ 
			addChild(background);
			
			var t:GuiText = new GuiText(50, 50, 400, 60, "left", "top", "GuiLoading", 25, 0x000000);
			addChild(t);
			
			KevinIsEenRareEngeVampier = new GuiText(screenWidth / 2, screenHeight / 2, 400, 60, "center", "center", "Loading 0%", 25, 0x000000);
			addChild(KevinIsEenRareEngeVampier);
			
			TextureList.preLoad();
		}
		
		override public function tick():void 
		{ 
			background.tick();
			
			if (!ready)
			{
				KevinIsEenRareEngeVampier.text.text = "Loading " + Math.floor(progress * 100) + "%";
			}
		}
		
		override public function action(b:GuiButton):void
		{
			if (b == null && !ready)
			{
				ready = true;
				KevinIsEenRareEngeVampier.text.text = "Tap to continue";
			}
		}
		
		override public function input(type:int, data:Vector.<Number>, e:TouchEvent):void 
		{
			if (ready)
			{
				main.switchGui(new GuiMainMenu());
			}
		}
	}
}