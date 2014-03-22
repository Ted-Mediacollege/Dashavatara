package myth.editor.component 
{
	import starling.display.Image;
	import myth.graphics.TextureList;
	import starling.display.Sprite;
	
	public class Constructor extends Sprite
	{
		public var active:Boolean = false;
		public var moving:Boolean = false;
		
		public var item:Image;
		
		public var button_move:Image;
		public var button_delete:Image;
		
		public function Constructor() 
		{
			button_move = new Image(TextureList.assets.getTexture("editor_option_move"));
			button_delete = new Image(TextureList.assets.getTexture("editor_option_delete"));
			
			addChild(button_move);
			addChild(button_delete);
		}	
		
		public function construct(tex:String, type:int):void
		{
			visible = true;
			active = true;
			
			item = new Image(TextureList.assets.getTexture(tex));
			addChild(item);
			
			button_move.x = item.x + item.width + 20;
			button_move.y = item.y;
			button_delete.x = item.x + item.width + 20;
			button_delete.y = item.y + 70;
		}
		
		public function destory():void
		{
			visible = false;
			active = false;
			moving = false;
			
			removeChild(item);
			item = null;
		}
		
		public function move(px:int, py:int):void
		{
			item.x = px;
			item.y = py;
			button_move.x = item.x + item.width + 20;
			button_move.y = item.y;
			button_delete.x = item.x + item.width + 20;
			button_delete.y = item.y + 70;
		}
		
		public function action(px:int, py:int):void
		{
			if (px > item.x + item.width + 20 && px < item.x + item.width + 76 && py > item.y && py < item.y + 56) //MOVE
			{
				moving = true;
			}
			else if (px > item.x + item.width + 20 && px < item.x + item.width + 76 && py > item.y + 70 && py < item.y + 126) //MOVE
			{
				destory();
			}
		}
	}
}