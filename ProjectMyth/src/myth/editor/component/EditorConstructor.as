package myth.editor.component 
{
	import myth.editor.Editor;
	import starling.display.Image;
	import myth.graphics.AssetList;
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
		public var depth:int;
		
		private var holder:Sprite;
		public var toolholder:Sprite;
		
		public var toolActive:Boolean;
		public var tool:EditorTool;
		
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
			
			toolholder = new Sprite();
			editor.addChild(toolholder);
			toolholder.x = 490;
			toolholder.y = 374;
			toolholder.visible = false;
			
			button_done = new Image(AssetList.assets.getTexture("editor_option_done"));
			button_delete = new Image(AssetList.assets.getTexture("editor_option_delete"));
			button_scale = new Image(AssetList.assets.getTexture("editor_option_scale"));
			button_rotate = new Image(AssetList.assets.getTexture("editor_option_rotate"));
			button_depth = new Image(AssetList.assets.getTexture("editor_option_depth"));
			button_rotate.color = 0x777777;
						
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
		
		public function construct(tex:String, c:int, t:int, px:Number = 200, py:Number = 200, z:Number = 1, r:Number = 0, sx:Number = 1, sy:Number = 1):void
		{
			visible = true;
			active = true;
			toolActive = false;
			editor.saved = false;
			
			item = new Image(AssetList.assets.getTexture(tex));
			item.x = px;
			item.y = py;
			item.rotation = r;
			addChild(item);
			frame = new Shape();
			addChild(frame);
			updateFrame();
			
			cat = c;
			type = t;
			item_name = tex;
			depth = z;
			
			//if (cat != EditorSelector.CAT_BACKGROUND)
			//{
				button_scale.visible = false;
				button_rotate.visible = false;
				button_depth.visible = false;
				
				holder.removeChild(button_scale);
				holder.removeChild(button_rotate);
				holder.removeChild(button_depth);
			//}

			holder.visible = true;
			moveHolder();
		}
		
		public function updateFrame():void
		{
			frame.x = item.x;
			frame.y = item.y;
			frame.graphics.clear();
			frame.graphics.lineStyle(4, 0xE3A601);
			frame.graphics.drawRect(0, 0, item.width, item.height);
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
			
			if (cat != EditorSelector.CAT_BACKGROUND)
			{
				button_scale.visible = true;
				button_rotate.visible = true;
				button_depth.visible = true;
				
				holder.addChild(button_scale);
				holder.addChild(button_rotate);
				holder.addChild(button_depth);
			}
		}
		
		public function tryMove(px:int, py:int):void
		{
			if (px > item.x && py > item.y && px < item.x + item.width && py < item.y + item.height)
			{
				moveposX = px - item.x;
				moveposY = py - item.y;
				moving = true;
				updateFrame();
			}
		}
		
		public function move(px:int, py:int):void
		{
			item.x = px - moveposX;
			item.y = py - moveposY;
			updateFrame();
			moveHolder();
		}
		
		public function swipeAction(px:int, py:int):Boolean
		{
			var w:Number = toolholder.width / 2;
			var h:Number = toolholder.height / 2;
			if (px > toolholder.x && py > toolholder.y && px < toolholder.x + toolholder.width && py <  toolholder.y + toolholder.height)
			{
				tool.swipeAction(px, py);
				return true;
			}
			return false;
		}
		
		public function action(px:int, py:int):void
		{
			if (toolActive)
			{
				if (px > toolholder.x && py > toolholder.y && px < toolholder.x + toolholder.width && py < toolholder.y + toolholder.height)
				{
					tool.action(px, py);
					return;
				}
				else
				{
					tool.destroy();
					toolActive = false;
					tool = null;
				}
			}
			
			if (px > holder.x && px < holder.x + holder.width)
			{
				var menuX:int = px - holder.x;
				var menuY:int = py - holder.y;
				
				if (menuY > 0 && menuY < 56)
				{
					if (cat == EditorSelector.CAT_BACKGROUND)
					{
						editor.FIELD_BACKGROUND.addBackground(item_name, type, (item.x + (Editor.camX / 2)) * 2, item.y, 2, item.rotation, 1, 1);
					}
					else if (cat == EditorSelector.CAT_OBJECTS)
					{
						editor.FIELD_OBJECTS.addObject(item_name, type, item.x + Editor.camX, item.y);
					}
					else if (cat == EditorSelector.CAT_ENEMY)
					{
						editor.FIELD_ENEMIES.addEnemies(item_name, type, item.x + Editor.camX, item.y);
					}
					destory(false);
					editor.removeChild(this);
				}
				else if (menuY > 70 && menuY < 126)
				{
					destory(true);
					editor.removeChild(this);
				}
				else if (menuY > 140 && menuY < 196 && cat == EditorSelector.CAT_BACKGROUND) //SCALE
				{
				}
				else if (menuY > 210 && menuY < 266 && cat == EditorSelector.CAT_BACKGROUND) //ROTATE
				{
					//tool = new EditorRotater(this, item.rotation);
				}
				else if (menuY > 280 && menuY < 336 && cat == EditorSelector.CAT_BACKGROUND) //DEPTH
				{
					tool = new EditorDepther(this, depth);
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