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
	import starling.display.Image;
	import starling.events.TouchEvent;
	import myth.gui.game.GuiCredits;
	import myth.data.GameData;
	import myth.PreLoader;
	import starling.filters.ColorMatrixFilter;
	
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
			
			var credits1:GuiText = new GuiText(100, 840, 600, 400, "left", "top", Lang.trans(Lang.MENU, "credits.pro") + ": \nKit van de Bunt \nTed de vos", 45, 0x000000, "GameFont");
			var credits2:GuiText = new GuiText(100, 400, 600, 400, "left", "top", Lang.trans(Lang.MENU, "credits.art") + ": \nAaron Ligthart \nLieske Timmermans \nIris van der Velde \nSanne Oudshoorn", 45, 0x000000, "GameFont");
			var credits3:GuiText = new GuiText(100, 1120, 600, 300, "left", "top", Lang.trans(Lang.MENU, "credits.man") + ": \nMerel van der Velde\nPriscilla Schaap \nPim Van Ballegoijen de Jong", 45, 0x000000, "GameFont");
			var credits4:GuiText = new GuiText(100, 1480, 900, 2000, "left", "top", "Special Thanks: \n", 45, 0x000000, "GameFont");
			
			addChild(credits1);
			addChild(credits2);
			addChild(credits3);
			addChild(credits4);
			
			text_list.push(credits2);
			text_list.push(credits1);
			text_list.push(credits3);
			//text_list.push(credits4);
			
			if (GameData.EASTEREGG_MODE)
			{
				var hoofd:Image = Image.fromBitmap(new PreLoader.hetHoofd());
				addChild(hoofd);
				hoofd.x = 1140;
				hoofd.y = 100;
				hoofd.pivotX = hoofd.width / 2;
				hoofd.pivotY = hoofd.height / 2;
			}

			var b:GuiButton = addButton(new GuiButton(0, AssetList.assets.getTexture("gui_button_default"), screenWidth / 2, screenHeight / 2 + 330, 450, 100, Lang.trans(Lang.MENU, "main.back"), 45, 0xf1d195, "GameFont"));
		}
		
		override public function input(type:int, data:Vector.<Number>, e:TouchEvent):void 
		{
			trace(easterEggCount);
			
			if (type == TouchType.CLICK)
			{
				if (easterEggCount == 0 && data[0] < 200 && data[1] < 200)
				{
					easterEggCount++;
				}
				else if (easterEggCount == 1 && data[0] > 1080 && data[1] < 200)
				{
					easterEggCount++;
				}
				else if (easterEggCount == 2 && data[0] > 1080 && data[1] > 500)
				{
					easterEggCount++;
				}
				else if (easterEggCount == 3 && data[0] < 200 && data[1] > 500)
				{
					easterEggCount++;
				}
				else if (easterEggCount == 4 && data[0] < 200 && data[1] < 200)
				{
					easterEggCount++;
				}
				else if (easterEggCount == 5 && data[0] > 1080 && data[1] < 200)
				{
					easterEggCount++;
				}
				else if (easterEggCount == 6 && data[0] > 1080 && data[1] > 500)
				{
					easterEggCount++;
				}
				else if (easterEggCount == 7 && data[0] < 200 && data[1] > 500)
				{
					GameData.EASTEREGG_MODE = true;
					Lang.setLanguage(666);
					main.switchGui(new GuiCredits(), true);
					
					var hoofd:Image = Image.fromBitmap(new PreLoader.hetHoofd());
					addChild(hoofd);
					hoofd.x = 1140;
					hoofd.y = 100;
					hoofd.pivotX = hoofd.width / 2;
					hoofd.pivotY = hoofd.height / 2;
					
					var f:ColorMatrixFilter = new ColorMatrixFilter();
					f.invert();
					main.filter = f;
				}
			}
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