package myth.gui.game 
{
	import myth.gui.components.GuiButton;
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
		
		public function GuiGame(_levelName:String) 
		{
			levelName = _levelName;
		}	
		
		override public function init():void
		{
			background = null;
			
			var bg:Image = new Image(TextureList.atlas_background2.getTexture("background"));
			bg.blendMode = BlendMode.NONE;
			bg.touchable = false;
			addChild(bg);
			
			Main.world = new World(this, levelName);
			Main.world.init();
			addChild(Main.world);
			
			addButton(new GuiButton(10, TextureList.atlas_gui.getTexture("icon1"), 100, 80, 194, 142, ""));
			addButton(new GuiButton(11, TextureList.atlas_gui.getTexture("icon2"), 300, 80, 194, 142, ""));
			addButton(new GuiButton(12, TextureList.atlas_gui.getTexture("icon3"), 500, 80, 194, 142, ""));
			addButton(new GuiButton(13, TextureList.atlas_gui.getTexture("pause"), 1280 - (114 / 2) - 10, 10 + (114 / 2), 114, 114, ""));
		}
		
		private function createPauseButtons():void 
		{
			b1 = addButton(new GuiButton(0, TextureList.atlas_gui.getTexture("button_small"), screenWidth / 2, screenHeight / 2 -50, 450, 100, "Resume", 25, 0x000000));
			b2 = addButton(new GuiButton(1, TextureList.atlas_gui.getTexture("button_small"), screenWidth / 2, screenHeight / 2	+60, 450, 100, "Menu", 25, 0x000000));
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
				//id - 10 = icon number
				Main.world.switchAvatar(button.buttonID-10);
			}
		}
		
		override public function tick():void
		{
			if (!pause)
			{
				Main.world.tick();
			}
		}
		
		override public function input(type:int, data:Vector.<Number>, e:TouchEvent):void 
		{
			Main.world.input(type, data, e);
		}
		
		override public function destroy():void
		{
			removeChild(Main.world);
			Main.world.onRemove();
			Main.world = null;
		}
	}
}