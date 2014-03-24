package myth.gui.game 
{
	import myth.gui.GuiScreen;
	import myth.gui.components.GuiButton;
	import myth.input.TouchType;
	import myth.gui.components.GuiText;
	import myth.graphics.TextureList;
	import myth.gui.background.GuiBackground;
	import myth.util.ScaleHelper;
	import myth.input.TouchType;
	import myth.lang.Lang;
	import starling.events.TouchEvent;
	
	public class GuiCredits extends GuiScreen
	{
		public var easterEggCount:int = 0;
		
		public function GuiCredits() 
		{
			
		}
		
		override public function init():void 
		{ 
			addChild(background);
			
			var t:GuiText = new GuiText(50, 50, 400, 60, "left", "top", "GuiCredits", 25, 0x000000);
			addChild(t);
			
			var lol:GuiText = new GuiText(screenWidth / 2, screenHeight / 2 - 200, 800, 250, "center", "center", "Ted is de programmeur die het laadscherm heeft gemaakt in paint", 45, 0x000000);
			addChild(lol);

			var b:GuiButton = addButton(new GuiButton(0, TextureList.assets.getTexture("gui_button_default"), screenWidth / 2, screenHeight / 2 + 330, 450, 100, Lang.trans(Lang.MENU, "main.back"), 25, 0x000000));
		}
		
		override public function input(type:int, data:Vector.<Number>, e:TouchEvent):void 
		{
			if (type == TouchType.CLICK)
			{
				if (data[0] > 1100 && data[1] > 650)
				{
					easterEggCount++;
					if (easterEggCount > 9)
					{
						Lang.setLanguage(99);
						main.switchGui(new GuiCredits());
					}
				}
			}
		}
		
		override public function tick():void 
		{ 
			background.tick();
		}
		
		override public function action(b:GuiButton):void 
		{ 
			main.switchGui(new GuiMainMenu());
		}
		
		override public function destroy():void 
		{ 
			
		}
	}
}