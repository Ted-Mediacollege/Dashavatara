package myth.editor.field 
{
	import starling.display.Sprite;
	import myth.background.Background;
	import myth.editor.EditorItem;
	import myth.graphics.TextureList;
	import myth.editor.EditorFiles;
	
	public class FieldEnemies extends Sprite
	{
		public var ENEMIES:Vector.<EditorItem>;
		
		public function FieldEnemies() 
		{
			
		}
		
		public function buildNew():void
		{
			ENEMIES = new Vector.<EditorItem>();
		}
		
		public function buildFile(a:Array):void
		{
			ENEMIES = new Vector.<EditorItem>();
			
			var arrayLength:int = a.length;
			var enemiesNames:Vector.<String> = EditorFiles.getEnemieNames();
			for (var i:int = 0; i < arrayLength; i++ )
			{
				addEnemies(enemiesNames[a[i].type], a[i].spawnX + 1280, a[i].spawnY, true);
			}
		}
		
		public function tick(camX:Number):void
		{
			for (var i:int = ENEMIES.length - 1; i > -1; i-- )
			{
				ENEMIES[i].x = ENEMIES[i].posX + -camX;
				if (ENEMIES[i].x < -ENEMIES[i].width || ENEMIES[i].x > 1080)
				{
					ENEMIES[i].visible = false;
				}
				else
				{
					ENEMIES[i].visible = true;
				}
			}
		}
		
		public function addEnemies(tex:String, px:Number, py:Number, pivotFix:Boolean = false):void
		{
			var en:EditorItem = new EditorItem(TextureList.assets.getTexture(tex), tex, 0, px, py, 1, 1, 1);
			if (pivotFix)
			{
				en.y -= en.height;
			}
			en.visible = false;
			ENEMIES.push(en);
			addChild(en);
		}
		
		public function getEnemiesAt(px:Number, py:Number):EditorItem
		{
			for (var i:int = ENEMIES.length - 1; i > -1; i-- )
			{
				if (px > ENEMIES[i].x && px < ENEMIES[i].x + ENEMIES[i].width && py > ENEMIES[i].y && py < ENEMIES[i].y + ENEMIES[i].height)
				{
					var en:EditorItem = ENEMIES[i];
					removeChild(ENEMIES[i]);
					ENEMIES.splice(i, 1);
					return en;
				}
			}
			return null;
		}
	}
}