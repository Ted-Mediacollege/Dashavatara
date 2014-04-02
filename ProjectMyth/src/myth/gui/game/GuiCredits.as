package myth.gui.game 
{
	import myth.gui.GuiScreen;
	import myth.gui.components.GuiButton;
	import myth.input.TouchType;
	import myth.gui.components.GuiText;
	import myth.graphics.AssetList;
	import myth.gui.background.GuiBackground;
	import myth.util.ScaleHelper;
	import myth.input.TouchType;
	import myth.lang.Lang;
	import starling.events.TouchEvent;
	import myth.gui.game.GuiCredits;
	
	public class GuiCredits extends GuiScreen
	{
		public var text_list:Vector.<GuiText>;
		
		public var easterEggCount:int = 0;
		
		public function GuiCredits() 
		{
			
		}
		
		override public function init():void 
		{ 
			addChild(background);
			
			text_list = new Vector.<GuiText>();
			
			var credits1:GuiText = new GuiText(200, 840, 600, 400, "left", "top", Lang.trans(Lang.MENU, "credits.pro") + ": \nKit van de Bunt \nTed de vos", 45, 0x000000, "GameFont");
			var credits2:GuiText = new GuiText(200, 400, 600, 400, "left", "top", Lang.trans(Lang.MENU, "credits.art") + ": \nAaron Ligthart \nLieske Timmermans \nIris van der Velde \nSanne Oudshoorn", 45, 0x000000, "GameFont");
			var credits3:GuiText = new GuiText(200, 1120, 600, 300, "left", "top", Lang.trans(Lang.MENU, "credits.man") + ": \nMerel van der Velde\nPriscilla Schaap \nPim Van Ballegoijen de Jong", 45, 0x000000, "GameFont");
			var credits4:GuiText = new GuiText(200, 1480, 900, 2000, "left", "top", "Special Thanks: \n", 45, 0x000000, "GameFont");
			
			addChild(credits1);
			addChild(credits2);
			addChild(credits3);
			addChild(credits4);
			
			text_list.push(credits2);
			text_list.push(credits1);
			text_list.push(credits3);
			//text_list.push(credits4);

			var b:GuiButton = addButton(new GuiButton(0, AssetList.assets.getTexture("gui_button_default"), screenWidth - 250, screenHeight / 2 + 330, 450, 100, Lang.trans(Lang.MENU, "main.back"), 45, 0x000000, "GameFont"));
		}
		
		override public function input(type:int, data:Vector.<Number>, e:TouchEvent):void 
		{
			/*if (type == TouchType.CLICK)
			{
				if (data[0] > 1100 && data[1] < 100)
				{
					easterEggCount++;
					if (easterEggCount > 9)
					{
						Lang.setLanguage(99);
						main.switchGui(new GuiCredits());
					}
				}
			}*/
		}
		
		override public function tick():void 
		{ 
			super.tick();
			background.tick();
			
			for (var i:int = 0; i < text_list.length; i++ )
			{
				text_list[i].y -= 2;
			}
			
			if (text_list[text_list.length - 1].y + text_list[text_list.length - 1].height < 0)
			{
				var l:Number = -text_list[0].y + 1280;
				for (var j:int = 0; j < text_list.length; j++ )
				{
					text_list[j].y += l;
				}
			}
		}
		
		override public function action(b:GuiButton):void 
		{ 
			main.switchGui(new GuiMainMenu(), true);
		}
		
		override public function destroy():void 
		{ 
			
		}
	}
}