package myth.gui.components 
{
	public class GuiButtonLevel extends GuiButton
	{
		import starling.display.BlendMode;
		import myth.graphics.AssetList;
		
		public var file_name:String;
		public var levelID:int;
		
		public function GuiButtonLevel(id:int, px:int, py:int, fn:String, done:Boolean) 
		{
			super(100 + id, AssetList.assets.getTexture("l" + (id + 1) + (done == true ? "b" : "a")), px, py, 138, 139, "", 80, 0xFFFFFF, "Arial");
			
			file_name = fn;
			levelID = id;
		}
	}
}