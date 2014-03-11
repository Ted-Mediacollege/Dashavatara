package myth.gui.game 
{
	import myth.gui.background.GuiBackground;
	import myth.gui.components.GuiText;
	import myth.gui.GuiScreen;
	import myth.gui.components.GuiButton;
	import myth.input.TouchType;
	import myth.graphics.TextureList;
	import starling.display.Image;

	import treefortress.spriter.SpriterClip;
	import starling.core.Starling;
	import flash.display.Loader;
	
	public class GuiMainMenu extends GuiScreen
	{
		public var michealJackson:SpriterClip;
		
		public function GuiMainMenu() 
		{
		}
		
		override public function init():void 
		{ 
			addChild(background);
			
			var logo:Image = new Image(TextureList.assets.getTexture("gui_logo"));
			logo.pivotX = 250;
			logo.x = 630;
			logo.y = 40;
			addChild(logo);
			
			var t:GuiText = new GuiText(50, 50, 400, 60, "left", "top", "GuiMainMenu", 25, 0x000000);
			addChild(t);
	
			michealJackson = TextureList.spriterLoader.getSpriterClip("animLion");
			michealJackson.x = -150;
			michealJackson.y = 770;
			michealJackson.playbackSpeed = 1;
			michealJackson.scaleX = 1;
			michealJackson.scaleY = 1;
			michealJackson.play("ren animatie");
			addChild(michealJackson);
			Starling.juggler.add(michealJackson);
			
			var b1:GuiButton = addButton(new GuiButton(0, TextureList.assets.getTexture("gui_button_default"), screenWidth / 2, screenHeight / 2 - 10, 450, 100, "Play", 25, 0x31407F));
			//var b2:GuiButton = addButton(new GuiButton(1, TextureList.assets.getTexture("gui_button_default"), screenWidth / 2, screenHeight / 2 + 60, 450, 100, "Customize", 25, 0x000000));
			//var b3:GuiButton = addButton(new GuiButton(2, TextureList.assets.getTexture("gui_button_default"), screenWidth / 2, screenHeight / 2 + 110, 450, 100, "Editor", 25, 0x000000));
			var b4:GuiButton = addButton(new GuiButton(3, TextureList.assets.getTexture("gui_button_default"), screenWidth / 2, screenHeight / 2 + 100, 450, 100, "Options", 25, 0x000000));
			var b5:GuiButton = addButton(new GuiButton(4, TextureList.assets.getTexture("gui_button_default"), screenWidth / 2, screenHeight / 2 + 210, 450, 100, "Credits", 25, 0x000000));
		}
		
		override public function tick():void 
		{ 
			background.tick();
			
			michealJackson.x += 10;
			
			if (michealJackson.x > 1400)
			{
				michealJackson.x = -150;
			}
		}
		
		override public function action(b:GuiButton):void 
		{ 
			if (b.buttonID == 0)
			{
				main.switchGui(new GuiLevelSelect());
			}
			else if (b.buttonID == 1)
			{
				main.switchGui(new GuiCustomize());
			}
			else if (b.buttonID == 2)
			{
				main.switchGui(new GuiEditor());
			}
			else if (b.buttonID == 3)
			{
				main.switchGui(new GuiOptions());
			}
			else if (b.buttonID == 4)
			{
				main.switchGui(new GuiCredits());
			}
		}
		
		override public function destroy():void 
		{ 
		}
	}
}