package myth.editor 
{
	import myth.editor.component.Scroll;
	import myth.editor.field.FieldBackground;
	import myth.editor.field.FieldTiles;
	import myth.gui.components.GuiText;
	import starling.display.Image;
	import starling.display.Sprite;
	import myth.graphics.TextureList;
	import starling.events.TouchEvent;
	import myth.input.TouchType;
	import myth.util.ScaleHelper;
	
	public class Editor extends Sprite
	{		
		public static var camX:Number;
		public static var maxX:Number;
		
		public var SCROLL:Scroll;
		
		public var FIELD_BACKGROUND:FieldBackground;
		public var FIELD_TILES:FieldTiles;

		public function Editor() 
		{
			
		}	
		
		public function build():void
		{
			var levelSize:int = 80;
			
			camX = 0;
			maxX = levelSize * 127 - 1000;
			
			FIELD_BACKGROUND = new FieldBackground();
			addChild(FIELD_BACKGROUND);
			
			FIELD_TILES = new FieldTiles();
			addChild(FIELD_TILES);
			
			SCROLL = new Scroll();
			addChild(SCROLL);
			
			var a1:Image = new Image(TextureList.assets.getTexture("editor_panel_main"));
			a1.x = 1280 - 350;
			addChild(a1);
			
			FIELD_BACKGROUND.buildNew(levelSize * 127, 0);
			FIELD_TILES.buildNew(levelSize, 0);
		}
		
		public function input(type:int, data:Vector.<Number>, e:TouchEvent):void 
		{ 
			if (type == TouchType.SWIPE || type == TouchType.CLICK)
			{
				if (data[0] < 930 && data[1] < 728)
				{
					if (type == TouchType.SWIPE)
					{
						SCROLL.scroll(data[2]);
					}
				}
				else if (data[0] < 930 && data[1] > 728)
				{
					if (type == TouchType.SWIPE)
					{
						SCROLL.warp(data[0] / 930 * maxX);
					}
				}
			}
		}
		
		public function tick():void
		{
			SCROLL.tick();
			
			FIELD_TILES.tick(camX);
			FIELD_BACKGROUND.tick(camX);
		}
		
		public function save():void
		{
			
		}
		
		public function load():void
		{
			
		}
	}
}