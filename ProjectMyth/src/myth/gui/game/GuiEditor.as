package myth.gui.game 
{
	import myth.editor.Editor;
	import myth.gui.GuiScreen;
	import myth.gui.components.GuiButton;
	import myth.input.TouchType;
	import myth.gui.components.GuiText;
	import myth.graphics.TextureList;
	import myth.gui.background.GuiBackground;
	import myth.gui.game.GuiMainMenu;
	import myth.editor.EditorFiles;
	import starling.events.TouchEvent;

	public class GuiEditor extends GuiScreen
	{
		private var button_menu:GuiButton;
		private var button_create:GuiButton;
		private var button_load:GuiButton;
		
		private var editor:Editor;
		public var inEditor:Boolean = false;
		
		public function GuiEditor() 
		{
			
		}
		
		override public function init():void 
		{ 
			addChild(background);
			
			button_menu = addButton(new GuiButton(0, TextureList.assets.getTexture("gui_button_default"), screenWidth / 2, screenHeight / 2 + 330, 450, 100, "Main Menu", 25, 0x000000));
			button_create = addButton(new GuiButton(1, TextureList.assets.getTexture("gui_button_default"), screenWidth / 2, screenHeight / 2 - 60, 450, 100, "Create Level", 25, 0x000000));
			button_load = addButton(new GuiButton(2, TextureList.assets.getTexture("gui_button_default"), screenWidth / 2, screenHeight / 2 + 60, 450, 100, "Load Level", 25, 0x000000));
		}
		
		override public function tick():void 
		{ 
			if (inEditor)
			{
				editor.tick();
			}
		}
		
		override public function input(type:int, data:Vector.<Number>, e:TouchEvent):void 
		{ 
			if (inEditor)
			{
				editor.input(type, data, e);
			}
		}
		
		override public function action(b:GuiButton):void 
		{ 
			if (b.buttonID == 0)
			{
				main.switchGui(new GuiMainMenu());
			}
			else if (b.buttonID == 1)
			{
				removeButton(button_menu);
				removeButton(button_create);
				removeButton(button_load);
				
				//removeChild(background);
				//background = null;
				editor = new Editor();
				addChild(editor);
				editor.build();
				
				inEditor = true;
			}
			else if (b.buttonID == 2)
			{
				removeButton(button_menu);
				removeButton(button_create);
				removeButton(button_load);
				
				removeChild(background);
				background = null;
				editor = new Editor();
				addChild(editor);
				editor.build();
				
				inEditor = true;
			}
		}
		
		override public function destroy():void 
		{ 
		}
	}
}