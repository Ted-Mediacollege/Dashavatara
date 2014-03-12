package myth.gui.game 
{
	import myth.gui.components.GuiButton;
	import myth.gui.components.GuiText;
	import myth.gui.GuiScreen;
	import myth.Main;
	import myth.world.World;
	import starling.display.Image;
	import starling.events.TouchEvent;
	import myth.gui.background.GuiBackground;
	import myth.graphics.TextureList;
	import starling.display.BlendMode;
	
	public class GuiGame extends GuiScreen 
	{
		private var bg:Image;
		private var levelName:String;
		private var pause:Boolean = false;
		
		private var b1:GuiButton;
		private var b2:GuiButton;
		
		private var help_text_temp:GuiText;
		private var help_fade:int;
		private var help_visible:Boolean;
		
		public function GuiGame(_levelName:String) 
		{
			levelName = _levelName;
		}	
		
		override public function init():void
		{
			background = null;
			
			Main.world = new World(this, levelName);
			Main.world.init();
			addChild(Main.world);
			
			addButton(new GuiButton(10, TextureList.assets.getTexture("gui_icon1"), 100, 80, 194, 142, ""));
			addButton(new GuiButton(11, TextureList.assets.getTexture("gui_icon2"), 300, 80, 194, 142, ""));
			addButton(new GuiButton(12, TextureList.assets.getTexture("gui_icon3"), 500, 80, 194, 142, ""));
			addButton(new GuiButton(13, TextureList.assets.getTexture("gui_button_pause"), 1280 - (114 / 2) - 10, 10 + (114 / 2), 114, 114, ""));
			
			help_text_temp = new GuiText(40, 700, 1200, 100, "left", "top", "Swipe to slash", 40, 0x000000, "Arial");
			addChild(help_text_temp);
		}
		
		private function createPauseButtons():void 
		{
			b1 = addButton(new GuiButton(0, TextureList.assets.getTexture("gui_button_default"), screenWidth / 2, screenHeight / 2 -50, 450, 100, "Resume", 25, 0x000000));
			b2 = addButton(new GuiButton(1, TextureList.assets.getTexture("gui_button_default"), screenWidth / 2, screenHeight / 2	+60, 450, 100, "Menu", 25, 0x000000));
		}
		
		private function removePauseButtons():void
		{
			removeButton(b1);
			removeButton(b2);
		}
		
		override public function action(button:GuiButton):void
		{
			if (button.buttonID == 13 ||button.buttonID == 0) 
			{
				if (pause)
				{
					pause = false;
					removePauseButtons();
				}
				else
				{
					pause = true;
					createPauseButtons();
				}
			}
			else if (button.buttonID == 1)
			{
				main.switchGui(new GuiMainMenu());
			}
			else if (button.buttonID > 9 && !pause)
			{
				Main.world.switchAvatar(button.buttonID - 10);
				
				help_visible = true;
				help_fade = 100;
				help_text_temp.alpha = 1;
				switch(button.buttonID - 10)
				{
					case 0: help_text_temp.text.text = "Tap to Jump."; break;
					case 1: help_text_temp.text.text = "Swipe to slash"; break;
					case 2: help_text_temp.text.text = "Tap repeatedly to sprint."; break;
				}
			}
		}

		override public function tick():void
		{	
			if (help_fade > 0 && !help_visible)
			{
				help_fade--;
				help_text_temp.alpha = Number(help_fade) / 100.0;
			}
			
			if (!pause)
			{
				Main.world.tick();
			}
		}
		
		override public function input(type:int, data:Vector.<Number>, e:TouchEvent):void 
		{
			Main.world.input(type, data, e);
			
			if (help_visible)
			{
				help_visible = false;
				help_fade = 100;
			}
		}
		
		override public function destroy():void
		{
			removeChild(Main.world);
			Main.world.onRemove();
			Main.world = null;
		}
	}
}