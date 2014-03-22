package myth.editor.component 
{
	import starling.display.Image;
	import myth.graphics.TextureList;
	import starling.display.Shape;
	import starling.display.Sprite;
	
	public class Constructor extends Sprite
	{
		public var active:Boolean = false;
		public var moving:Boolean = false;
		
		public var moveposX:Number;
		public var moveposY:Number;
		
		public var item:Image;
		public var frame:Shape;
		
		public var type:int;
		public var item_name:String;
		
		public var button_done:Image;
		public var button_delete:Image;
		
		public function Constructor() 
		{
			button_done = new Image(TextureList.assets.getTexture("editor_option_done"));
			button_delete = new Image(TextureList.assets.getTexture("editor_option_delete"));
			
			addChild(button_done);
			addChild(button_delete);
		}	
		
		public function construct(tex:String, t:int, px:Number = 50, py:Number = 50):void
		{
			visible = true;
			active = true;
			
			item = new Image(TextureList.assets.getTexture(tex));
			item.x = px;
			item.y = py;
			addChild(item);
			frame = new Shape();
			frame.x = px;
			frame.y = py;
			addChild(frame);
			frame.graphics.lineStyle(4, 0xFF0000);
			frame.graphics.drawRect(0, 0, item.width, item.height);
			
			type = t;
			item_name = tex;
			
			button_done.x = item.x + item.width + 20;
			button_done.y = item.y;
			button_delete.x = item.x + item.width + 20;
			button_delete.y = item.y + 70;
		}
		
		public function destory(del:Boolean):void
		{
			visible = false;
			active = false;
			moving = false;
			
			removeChild(frame);
			frame = null;
			removeChild(item);
			item = null;
		}
		
		public function tryMove(px:int, py:int):void
		{
			if (px > item.x && py > item.y && px < item.x + item.width && py < item.y + item.height)
			{
				moveposX = px - item.x;
				moveposY = py - item.y;
				moving = true;
			}
		}
		
		public function move(px:int, py:int):void
		{
			item.x = px - moveposX;
			item.y = py - moveposY;
			frame.x = px - moveposX;
			frame.y = py - moveposY;
			button_done.x = item.x + item.width + 20;
			button_done.y = item.y;
			button_delete.x = item.x + item.width + 20;
			button_delete.y = item.y + 70;
		}
	}
}