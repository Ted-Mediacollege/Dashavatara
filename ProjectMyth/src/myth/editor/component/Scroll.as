package myth.editor.component 
{
	import starling.display.Sprite;
	import starling.display.Image;
	import myth.graphics.TextureList;
	
	public class Scroll extends Sprite
	{		
		private var art_background:Sprite;
		private var art_scroll:Image;
		
		public var camX:Number;
		public var maxX:Number;
		
		public function Scroll() 
		{
			camX = 0;
			maxX = 4000;
			
			art_background = new Sprite();
			art_scroll = new Image(TextureList.assets.getTexture("editor_scroll_pos"));
			addChild(art_background);
			addChild(art_scroll);
			
			for (var i:int = 0; i < 10; i++ )
			{
				var bs:Image = new Image(TextureList.assets.getTexture("editor_scroll_background"));
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
			art_scroll.x = 930 / maxX * camX;
		}
		
		public function scroll(dir:Number):void
		{
			camX += -dir;
			
			if (camX < 0)
			{
				camX = 0;
			}
			if (camX > maxX)
			{
				camX = maxX;
			}
		}
	}
}