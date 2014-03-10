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
		
		public function GuiLoading() 
		{
			
		}
		
		override public function init():void 
		{ 
			addChild(background);
			
			var t:GuiText = new GuiText(50, 50, 400, 60, "left", "top", "GuiLoading", 25, 0x000000);
			addChild(t);
			
			var KevinIsEenRareEngeVampier:GuiText = new GuiText(screenWidth / 2, screenHeight / 2, 400, 60, "center", "center", "Tap to continue", 25, 0x000000);
			addChild(KevinIsEenRareEngeVampier);
			
			TextureList.preLoad();
		}
		
		override public function tick():void 
		{ 
			background.tick();
		}
		
		override public function input(type:int, data:Vector.<Number>, e:TouchEvent):void 
		{
			main.switchGui(new GuiMainMenu());
		}
	}
}