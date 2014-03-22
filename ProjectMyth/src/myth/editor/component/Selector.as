package myth.editor.component 
{
	import myth.gui.components.GuiText;
	import starling.display.Sprite;
	import starling.display.Image;

	public class Selector extends Sprite
	{
		public var cat_text:GuiText;
		
		public var CAT:int;
		public var ITEM:int;
		
		public static var CAT_OBJECTS:int = 0;
		public static var CAT_BACKGROUND:int = 1;
		public static var CAT_ENEMY:int = 2;
		
		public function Selector() 
		{
			
		}
		
		public function build(t:int):void
		{
			cat_text = new GuiText(1105, 355, 200, 50, "center", "center", "CAT_CAT_CAT", 30, 0x000000, "Arial");
			addChild(cat_text);
			
			CAT = 0;
			switch_cat(0);
		}
		
		public function switch_cat(dir:int):void
		{
			CAT += dir;
			if (CAT < CAT_OBJECTS) { CAT = CAT_BACKGROUND; }
			if (CAT > CAT_BACKGROUND) { CAT = CAT_OBJECTS; }
			
			switch(CAT)
			{
				case CAT_OBJECTS: cat_text.text.text = "Objects"; break;
				case CAT_BACKGROUND: cat_text.text.text = "Background"; break;
				default: cat_text.text.text = "Enemy"; break;
			}
			
			ITEM = 0;
			switch_item(0);
		}
		
		public function switch_item(dir:int):void
		{
			
		}
	}
}