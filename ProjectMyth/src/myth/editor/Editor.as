package myth.editor 
{
	import myth.editor.component.Scroll;
	import myth.gui.components.GuiText;
	import starling.display.Image;
	import starling.display.Sprite;
	import myth.graphics.TextureList;
	import starling.events.TouchEvent;
	import myth.input.TouchType;
	
	public class Editor extends Sprite
	{		
		public var SCROLL:Scroll;
		
		public var text_cat:GuiText;
		
		public static var catList:Vector.<String> = new < String > ["Tiles", "Objects", "Background", "Entities"];
		public var catSelected:int;
		
		public function Editor() 
		{
			
		}	
		
		public function build():void
		{
			catSelected = 0;
			
			var a1:Image = new Image(TextureList.assets.getTexture("editor_panel_main"));
			a1.x = 1280 - 350;
			addChild(a1);
			
			SCROLL = new Scroll();
			addChild(SCROLL);
		}
		
		public function input(type:int, data:Vector.<Number>, e:TouchEvent):void 
		{ 
			if (type == TouchType.SWIPE)
			{
				SCROLL.scroll(data[2]);
			}
		}
		
		public function tick():void
		{
			SCROLL.tick();
		}
		
		public function save():void
		{
			
		}
		
		public function load():void
		{
			
		}
	}
}