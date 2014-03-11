package myth.gui.game 
{
	import myth.gui.GuiScreen;
	import myth.gui.components.GuiButton;
	import myth.input.TouchType;
	import myth.gui.components.GuiText;
	import myth.graphics.TextureList;
	import myth.gui.background.GuiBackground;
	import myth.util.ScaleHelper;
	
	public class GuiCredits extends GuiScreen
	{
		
		public function GuiCredits() 
		{
			
		}
		
		override public function init():void 
		{ 
			addChild(background);
			
			var t:GuiText = new GuiText(50, 50, 400, 60, "left", "top", "GuiCredits", 25, 0x000000);
			addChild(t);
			
			var lol:GuiText = new GuiText(screenWidth / 2, screenHeight / 2 - 200, 800, 250, "center", "center", "Dit spel is gemaakt door de oppermachtige programmeur ted.", 45, 0x000000);
			addChild(lol);
			
			var lolbb2:GuiText = new GuiText(screenWidth / 2 + 295, screenHeight / 2 - 148, 900, 200, "center", "center", "===", 40, 0xFF0000);
			addChild(lolbb2);
			
			var lol2:GuiText = new GuiText(screenWidth / 2 + 220, screenHeight / 2 - 105, 900, 200, "center", "center", "EDIT: kit heeft alles gedaan.", 40, 0xFF0000);
			addChild(lol2);
			
			var lol3:GuiText = new GuiText(screenWidth / 2 + 20, screenHeight / 2 + 45, 600, 200, "center", "center", "Met dank aan: kevin \"vampier\" krol, Djarno, faberjan, kewim dusdat en jeriMAYA. voor totaal niks doen en ons van het werk afhouden. Mike staat boven coen en rick. Coen en rick zijn hele b0ze jongens OEHEHOEHOHE, Bedankt aan de jorden voor het schreeuwen tijdens het testen. Gekke jopppe eehhh vieze jongetjes.", 25, 0x000000);
			addChild(lol3);
			
			var lol4:GuiText = new GuiText(screenWidth / 2 + 20, screenHeight / 2 - 300, 600, 200, "center", "center", "Aaron, sanne, iris en lieske hebben art gemaakt enzo maar de programmeurs zijn het koelsts", 25, 0x000000);
			addChild(lol4);
			
			var b:GuiButton = addButton(new GuiButton(0, TextureList.assets.getTexture("gui_button_default"), screenWidth / 2, screenHeight / 2 + 330, 450, 100, "Main Menu", 25, 0x000000));
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