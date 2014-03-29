package myth.gui.components 
{
	public class GuiButtonLevel extends GuiButton
	{
		import starling.display.BlendMode;
		import myth.graphics.TextureList;
		
		public function GuiButtonLevel(id:int, px:int, py:int) 
		{
			super(100 + id, TextureList.assets.getTexture("map_button_a"), px, py, 138, 139, "" + (id + 1), 80, 0xFFFFFF, "Arial");
		}
	}
}