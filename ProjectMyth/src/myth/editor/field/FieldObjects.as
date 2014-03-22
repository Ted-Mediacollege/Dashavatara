package myth.editor.field 
{
	import starling.display.Sprite;
	import myth.background.Background;
	import myth.graphics.TextureList;
	
	public class FieldObjects extends Sprite
	{
		public var OBJECTS:Vector.<Background>;
		
		public function FieldObjects() 
		{
			
		}
		
		public function buildNew():void
		{
			OBJECTS = new Vector.<Background>();
		}
		
		public function buildFile():void
		{
			OBJECTS = new Vector.<Background>();
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
			var ob:Background = new Background(TextureList.assets.getTexture(tex), px, py, 1, 1, 1);
			ob.visible = false;
			OBJECTS.push(ob);
			addChild(ob);
		}
		
		public function getObjectAt(px:Number, py:Number):Background
		{
			for (var i:int = OBJECTS.length; i > -1; i-- )
			{
				
			}
		}
	}
}