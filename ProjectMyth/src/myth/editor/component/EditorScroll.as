package myth.editor.component 
{
	import starling.display.Sprite;
	import starling.display.Image;
	import myth.graphics.AssetList;
	import myth.editor.Editor;
	
	public class EditorScroll extends Sprite
	{		
		private var art_background:Sprite;
		private var art_scroll:Image;
		
		public function EditorScroll() 
		{
			Editor.camX = 0;
			
			art_background = new Sprite();
			art_scroll = new Image(AssetList.assets.getTexture("editor_scroll_pos"));
			addChild(art_background);
			addChild(art_scroll);
			
			for (var i:int = 0; i < 10; i++ )
			{
				var bs:Image = new Image(AssetList.assets.getTexture("editor_scroll_background"));
				bs.x = 100 * i;
				bs.y = 768 - 30;
				art_background.addChild(bs);
			}
			art_background.flatten();
			
			art_scroll.y = 768 - 18;
			art_scroll.pivotX = art_scroll.width / 2;
		}	
		
		public function tick():void
		{
			art_scroll.x = 930 / Editor.maxX * Editor.camX;
		}
		
		public function scroll(dir:Number):void
		{
			Editor.camX += -dir;
			
			if (Editor.camX < 0)
			{
				Editor.camX = 0;
			}
			if (Editor.camX > Editor.maxX)
			{
				Editor.camX = Editor.maxX;
			}
		}
		
		public function warp(pos:Number):void
		{
			Editor.camX = pos;
			
			if (Editor.camX < 0)
			{
				Editor.camX = 0;
			}
			if (Editor.camX > Editor.maxX)
			{
				Editor.camX = Editor.maxX;
			}
		}
	}
}