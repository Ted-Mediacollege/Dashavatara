package myth.editor.component 
{
	import myth.editor.Editor;
	import starling.display.Image;
	import myth.graphics.TextureList;
	import starling.display.Shape;
	import starling.display.Sprite;
	
	public class EditorConstructor extends Sprite
	{
		private var editor:Editor;
		
		public var active:Boolean = false;
		public var moving:Boolean = false;
		
		public var moveposX:Number;
		public var moveposY:Number;
		
		public var item:Image;
		public var frame:Shape;
		
		public var cat:int;
		public var type:int;
		public var item_name:String;
		
		private var holder:Sprite;
		
		public var button_done:Image;
		public var button_delete:Image;
		public var button_scale:Image;
		public var button_rotate:Image;
		public var button_depth:Image;
		
		public function EditorConstructor(e:Editor) 
		{
			editor = e;
			
			holder = new Sprite();
			editor.addChild(holder);
			holder.visible = false;
			
			button_done = new Image(TextureList.assets.getTexture("editor_option_done"));
			button_delete = new Image(TextureList.assets.getTexture("editor_option_delete"));
			button_scale = new Image(TextureList.assets.getTexture("editor_option_scale"));
			button_rotate = new Image(TextureList.assets.getTexture("editor_option_rotate"));
			button_depth = new Image(TextureList.assets.getTexture("editor_option_depth"));
						
			button_done.y = 0;
			button_delete.y = 70;
			button_scale.y = 140;
			button_rotate.y = 210;
			button_depth.y = 280;
			
			holder.addChild(button_done);
			holder.addChild(button_delete);
			holder.addChild(button_scale);
			holder.addChild(button_rotate);
			holder.addChild(button_depth);
		}	
		
		public function construct(tex:String, c:int, t:int, px:Number = 50, py:Number = 50):void
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
			
			cat = c;
			type = t;
			item_name = tex;
			
			holder.visible = true;
			moveHolder();
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
			holder.visible = false;
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
			
			moveHolder();
		}
		
		public function action(px:int, py:int):void
		{
			if (px > holder.x && px < holder.x + holder.width)
			{
				var menuX:int = px - holder.x;
				var menuY:int = py - holder.y;
				
				if (menuY > 0 && menuY < 56)
				{
					if (editor.CONSTRUCTOR.cat == EditorSelector.CAT_BACKGROUND)
					{
						editor.FIELD_BACKGROUND.addBackground(editor.CONSTRUCTOR.item_name, editor.CONSTRUCTOR.type, (editor.CONSTRUCTOR.item.x + (Editor.camX / 2)) * 2, editor.CONSTRUCTOR.item.y, 2, 1, 1);
					}
					else if (editor.CONSTRUCTOR.cat == EditorSelector.CAT_OBJECTS)
					{
						editor.FIELD_OBJECTS.addObject(editor.CONSTRUCTOR.item_name, editor.CONSTRUCTOR.type, editor.CONSTRUCTOR.item.x + Editor.camX, editor.CONSTRUCTOR.item.y);
					}
					else if (editor.CONSTRUCTOR.cat == EditorSelector.CAT_ENEMY)
					{
						editor.FIELD_ENEMIES.addEnemies(editor.CONSTRUCTOR.item_name, editor.CONSTRUCTOR.type, editor.CONSTRUCTOR.item.x + Editor.camX, editor.CONSTRUCTOR.item.y);
					}
					destory(false);
					editor.removeChild(editor.CONSTRUCTOR);
				}
				else if (menuY > 70 && menuY < 126)
				{
					destory(true);
					editor.removeChild(editor.CONSTRUCTOR);
				}
				else if (menuY > 140 && menuY < 196)
				{
					trace("button 3");
				}
				else if (menuY > 210 && menuY < 266)
				{
					trace("button 4");
				}
				else if (menuY > 280 && menuY < 336)
				{
					trace("button 5");
				}
			}
		}
		
		public function moveHolder():void
		{
			holder.x = item.x + item.width + 20;
			holder.y = item.y;
			
			if (holder.x < 5)
			{
				holder.x = 5;
			}
			if (holder.y < 5)
			{
				holder.y = 5;
			}
			if (holder.x + holder.width > 925)
			{
				holder.x = 925 - holder.width;
			}
			if (holder.y + holder.height > 635)
			{
				holder.y = 635 - holder.height;
			}
		}
	}
}