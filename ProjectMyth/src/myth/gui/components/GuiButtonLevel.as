package myth.gui.components 
{
	public class GuiButtonLevel extends GuiButton
	{
		import starling.display.BlendMode;
		import myth.graphics.TextureList;
		
		public var file_name:String;
		public var level_name:String;
		public var level_description:String;
		public var level_difficulty:String;
		
		public function GuiButtonLevel(id:int, px:int, py:int, fn:String, ln:String, ld:String, lf:String) 
		{
			super(100 + id, TextureList.assets.getTexture("map_button_a"), px, py, 138, 139, "" + (id + 1), 80, 0xFFFFFF, "Arial");
			
			file_name = fn;
			level_name = ln;
			level_description = ld;
			level_difficulty = lf;
		}
	}
}