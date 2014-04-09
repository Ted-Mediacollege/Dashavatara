package myth.editor.field 
{
	import starling.display.Sprite;
	import myth.background.Background;
	import myth.editor.EditorItem;
	import myth.graphics.AssetList;
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
				addEnemies(enemiesNames[a[i].type], a[i].type, a[i].spawnX + 1280, a[i].type == 3 ? a[i].spawnY + 1280 : a[i].spawnY, true);
			}
		}
		
		public function saveData(saveFile:Object):void
		{
			saveFile.enemies = new Array();
			var enemieLength:int = ENEMIES.length;
			for (var m:int = 0; m < enemieLength; m++ )
			{
				var enm:Object = new Object();
				enm.type = ENEMIES[m].type;
				enm.spawnX = ENEMIES[m].posX - 1280;
				enm.spawnY = ENEMIES[m].type == 3 ? ENEMIES[m].y + ENEMIES[m].height - 1280 : ENEMIES[m].y + ENEMIES[m].height;
				saveFile.enemies.push(enm);
			}
		}
		
		public function sortData(saveFile:Object):void
		{
			var id:int = 0;
			var value:Number = 0;
			var oldEnemy:Array = saveFile.enemies;
			var newEnemy:Array = new Array();
			
			for (var i:int = oldEnemy.length - 1; i > -1; i-- )
			{
				var l:int = newEnemy.length;
				if (l == 0)
				{
					newEnemy.push(oldEnemy.pop());
				}
				else
				{
					var added:Boolean = false;
					for (var j:int = 0; j < l; j++ )
					{
						if (oldEnemy[i].spawnX < newEnemy[j].spawnX)
						{
							newEnemy.splice(j, 0, oldEnemy.pop());
							added = true;
							break;
						}
					}
					
					if (!added)
					{
						newEnemy.push(oldEnemy.pop());
					}
				}
			}
			
			saveFile.enemies = newEnemy;
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
		
		public function addEnemies(tex:String, t:int, px:Number, py:Number, pivotFix:Boolean = false):void
		{
			var en:EditorItem = new EditorItem(AssetList.assets.getTexture(tex), tex, t, px, py, 1, 1, 1);
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