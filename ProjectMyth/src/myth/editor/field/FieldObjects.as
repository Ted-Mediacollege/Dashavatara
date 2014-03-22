package myth.editor.field 
{
	import starling.display.Sprite;
	import myth.background.Background;
	import myth.graphics.TextureList;
	import myth.editor.EditorItem;
	
	public class FieldObjects extends Sprite
	{
		public var OBJECTS:Vector.<EditorItem>;
		
		public function FieldObjects() 
		{
			
		}
		
		public function buildNew():void
		{
			OBJECTS = new Vector.<EditorItem>();
		}
		
		public function buildFile():void
		{
			OBJECTS = new Vector.<EditorItem>();
		}
		
		public function tick(camX:Number):void
		{
			for (var i:int = OBJECTS.length - 1; i > -1; i-- )
			{
				OBJECTS[i].x = OBJECTS[i].posX + -camX;
				if (OBJECTS[i].x < -OBJECTS[i].width || OBJECTS[i].x > 1080)
				{
					OBJECTS[i].visible = false;
				}
				else
				{
					OBJECTS[i].visible = true;
				}
			}
		}
		
		public function addObject(tex:String, px:Number, py:Number):void
		{
			var ob:EditorItem = new EditorItem(TextureList.assets.getTexture(tex), tex, 0, px, py, 1, 1, 1);
			ob.visible = false;
			OBJECTS.push(ob);
			addChild(ob);
		}
		
		public function getObjectAt(px:Number, py:Number):EditorItem
		{
			for (var i:int = OBJECTS.length - 1; i > -1; i-- )
			{
				if (px > OBJECTS[i].x && px < OBJECTS[i].x + OBJECTS[i].width && py > OBJECTS[i].y && py < OBJECTS[i].y + OBJECTS[i].height)
				{
					var ob:EditorItem = OBJECTS[i];
					removeChild(OBJECTS[i]);
					OBJECTS.splice(i, 1);
					return ob;
				}
			}
			return null;
		}
	}
}