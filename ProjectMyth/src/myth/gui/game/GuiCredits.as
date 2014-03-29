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
	import myth.gui.game.GuiCredits;
	
	public class GuiCredits extends GuiScreen
	{
		public var easterEggCount:int = 0;
		
		public function GuiCredits() 
		{
			
		}
		
		override public function init():void 
		{ 
			addChild(background);
			
			var credits1:GuiText = new GuiText(0, 50, 590, 400, "right", "top", Lang.trans(Lang.MENU, "credits.pro") + ": \nKit van de Bunt \nTed de vos", 45, 0x000000, "GameFont");
			var credits2:GuiText = new GuiText(screenWidth / 2 + 50, 50, 600, 400, "left", "top", Lang.trans(Lang.MENU, "credits.art") + ": \nAaron Ligthart \nLieske Timmermans \nIris van der Velde \nSanne Oudshoorn", 45, 0x000000, "GameFont");
			var credits3:GuiText = new GuiText(0, 320, 590, 400, "right", "top", Lang.trans(Lang.MENU, "credits.man") + ": \nMerel van der Velde\nPriscilla Schaap \nPim Van Ballegoijen de Jong", 45, 0x000000, "GameFont");
			addChild(credits1);
			addChild(credits2);
			addChild(credits3);

			var b:GuiButton = addButton(new GuiButton(0, TextureList.assets.getTexture("gui_button_default"), screenWidth / 2, screenHeight / 2 + 330, 450, 100, Lang.trans(Lang.MENU, "main.back"), 45, 0x000000, "GameFont"));
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