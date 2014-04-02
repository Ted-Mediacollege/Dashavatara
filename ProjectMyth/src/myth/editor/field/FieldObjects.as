package myth.editor.field 
{
	import starling.display.Sprite;
	import myth.background.Background;
	import myth.graphics.TextureList;
	import myth.editor.EditorItem;
	import myth.editor.EditorFiles;
	
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
		
		public function buildFile(a:Array, t:int):void
		{
			OBJECTS = new Vector.<EditorItem>();
			
			var arrayLength:int = a.length;
			var objectNames:Vector.<String> = EditorFiles.getObjectNames(t);
			for (var i:int = 0; i < arrayLength; i++ )
			{
				if (a[i].type != 2) //QUICK FIX
				{
					addObject(objectNames[a[i].type], a[i].type, a[i].x, a[i].y, true);
				}
			}
		}
		
		public function saveData(saveFile:Object):void
		{
			saveFile.objects = new Array();
			var objectsLength:int = OBJECTS.length;
			for (var k:int = 0; k < objectsLength; k++ )
			{
				var obj:Object = new Object();
				obj.type = 0;
				obj.x = OBJECTS[k].posX;
				obj.y = OBJECTS[k].y + OBJECTS[k].height;
				saveFile.objects.push(obj);
			}
		}
		
		public function sortData(saveFile:Object):void
		{
			var id:int = 0;
			var value:Number = 0;
			var oldObject:Array = saveFile.objects;
			var newObject:Array = new Array();
			
			for (var i:int = oldObject.length - 1; i > -1; i-- )
			{
				var l:int = newObject.length;
				if (l == 0)
				{
					newObject.push(oldObject.pop());
				}
				else
				{
					var added:Boolean = false;
					for (var j:int = 0; j < l; j++ )
					{
						if (oldObject[i].x < newObject[j].x)
						{
							newObject.splice(j, 0, oldObject.pop());
							added = true;
							break;
						}
					}
					
					if (!added)
					{
						newObject.push(oldObject.pop());
					}
				}
			}
			
			saveFile.objects = newObject;
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
		
		public function addObject(tex:String, t:int, px:Number, py:Number, pivotFix:Boolean = false):void
		{
			var ob:EditorItem = new EditorItem(TextureList.assets.getTexture(tex), tex, t, px, py, 1, 1, 1);
			if (pivotFix)
			{
				ob.y -= ob.height;
			}
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