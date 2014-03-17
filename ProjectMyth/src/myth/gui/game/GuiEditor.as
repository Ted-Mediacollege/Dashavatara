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

	public class GuiEditor extends GuiScreen
	{
		private var editor:Editor;
		
		public function GuiEditor() 
		{
			
		}
		
		override public function init():void 
		{ 
			EditorFiles.loadTextures();
			if (EditorFiles.TILE_SKY_0.art != null)
			{
				trace("yay 1");
			}
			
			addChild(background);
			
			var t:GuiText = new GuiText(50, 50, 400, 60, "left", "top", "GuiEditor", 25, 0x000000);
			addChild(t);
			
			var b1:GuiButton = addButton(new GuiButton(0, TextureList.assets.getTexture("gui_button_default"), screenWidth / 2, screenHeight / 2 + 330, 450, 100, "Main Menu", 25, 0x000000));
			var b2:GuiButton = addButton(new GuiButton(1, TextureList.assets.getTexture("gui_button_default"), screenWidth / 2, screenHeight / 2 - 60, 450, 100, "Create Level", 25, 0x000000));
			var b3:GuiButton = addButton(new GuiButton(2, TextureList.assets.getTexture("gui_button_default"), screenWidth / 2, screenHeight / 2 + 60, 450, 100, "Load Level", 25, 0x000000));
		}
		
		override public function tick():void 
		{ 
			background.tick();
		}
		
		override public function action(b:GuiButton):void 
		{ 
			if (b.buttonID == 0)
			{
				main.switchGui(new GuiMainMenu());
			}
			else if (b.buttonID == 1)
			{
				main.switchGui(new GuiMainMenu());
			}
			else if (b.buttonID == 2)
			{
				main.switchGui(new GuiMainMenu());
			}
		}
		
		override public function destroy():void 
		{ 
			EditorFiles.unLoadTextures();
			if (EditorFiles.TILE_SKY_0.art == null)
			{
				trace("yay 2");
			}
		}
	}
}