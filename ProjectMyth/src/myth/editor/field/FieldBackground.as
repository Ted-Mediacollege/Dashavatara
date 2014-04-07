package myth.editor.field 
{
	import myth.background.Background;
	import myth.data.Theme;
	import starling.display.Sprite;
	import starling.display.Image;
	import myth.graphics.AssetList;
	import starling.display.BlendMode;
	import starling.textures.Texture;
	import myth.util.MathHelper;
	import myth.editor.EditorFiles;
	import myth.editor.EditorItem;
	
	public class FieldBackground extends Sprite
	{
		public var BACKGROUND_RANDOM:Vector.<Background>;
		public var BACKGROUND_CREATED:Vector.<EditorItem>;
		public var BACKGROUND_SPAWN:Background;
		public var BACKGROUND_END:Background;
		
		public var theme:int;
		
		public function FieldBackground() 
		{
			
		}
		
		public function buildCommon(size:int, t:int):void
		{
			BACKGROUND_RANDOM = new Vector.<Background>();
			BACKGROUND_CREATED = new Vector.<EditorItem>();
		
			theme = t;
			
			var bg:Image = new Image(AssetList.assets.getTexture(EditorFiles.getLuchtName(t)));
			bg.blendMode = BlendMode.NONE;
			addChild(bg);
				
			if (t == Theme.SKY)
			{
				var textures:Vector.<Texture> = AssetList.assets.getTextures("common_wolk");
				var texturesLength:int = textures.length;
				for (var j:int = 0; j < 25; j++ )
				{
					var depth:Number = (MathHelper.nextInt(380) / 100) + 3;
					var b2:Background = new Background(textures[MathHelper.nextInt(texturesLength)], MathHelper.nextInt(1480 * depth), (depth * 90) - 300, depth, 1 - (depth / 20), 1 - (depth / 20));
					b2.x = b2.posX / b2.z;
					BACKGROUND_RANDOM.push(b2);
					addChild(b2);
				}
			}
			else if (t == Theme.EARTH)
			{
				var mountain:Texture = AssetList.assets.getTexture("earth_bergen");
				var amount:int = int(Math.ceil((size / 1280) / 4));
				for (var k:int = 0; k < amount; k++ )
				{
					var b3:Background = new Background(mountain, (k * 1280) * 4, 0, 4, 1, 1);
					b3.x = b3.posX / b3.z;
					BACKGROUND_RANDOM.push(b3);
					addChild(b3);
				}
			}
				
			BACKGROUND_SPAWN = new Background(AssetList.assets.getTexture("editor_player"), 200, 470, 1, 1, 1);
			addChild(BACKGROUND_SPAWN);
				
			BACKGROUND_END = new Background(AssetList.assets.getTexture("editor_gate"), size - 800, 221, 1, 1, 1);
			addChild(BACKGROUND_END);
		}
		
		public function buildNew(size:int, t:int):void
		{
			buildCommon(size, t);
		}
		
		public function buildFile(a:Array, size:int, t:int):void
		{
			buildCommon(size, t);
			
			var arrayLength:int = a.length;
			var bgNames:Vector.<String> = EditorFiles.getBackgroundNames(t);
			for (var i:int = 0; i < arrayLength; i++ )
			{
				addBackground(bgNames[a[i].type], a[i].type, a[i].x, a[i].y, a[i].depth, 0, 1, 1);
			}
		}
		
		public function saveData(saveFile:Object):void
		{
			saveFile.background_props = new Array();
			var backgroundLength:int = BACKGROUND_CREATED.length;
			for (var j:int = 0; j < backgroundLength; j++ )
			{
				var bg:Object = new Object();
				bg.type = BACKGROUND_CREATED[j].type;
				bg.depth = BACKGROUND_CREATED[j].z;
				bg.x = BACKGROUND_CREATED[j].posX;
				bg.y = BACKGROUND_CREATED[j].y;
				saveFile.background_props.push(bg);
			}
		}
		
		public function tick(camX:Number):void
		{
			BACKGROUND_SPAWN.x = (BACKGROUND_SPAWN.posX + -camX) / BACKGROUND_SPAWN.z;
			BACKGROUND_END.x = (BACKGROUND_END.posX + -camX) / BACKGROUND_END.z;
			
			if (theme == 0)
			{
				for (var k:int = BACKGROUND_RANDOM.length - 1; k > -1; k--)
				{
					BACKGROUND_RANDOM[k].x = (BACKGROUND_RANDOM[k].posX + -camX) / BACKGROUND_RANDOM[k].z;
					if (BACKGROUND_RANDOM[k].x + BACKGROUND_RANDOM[k].width < 0)
					{
						BACKGROUND_RANDOM[k].posX += (1280 * BACKGROUND_RANDOM[k].z) + (BACKGROUND_RANDOM[k].width * BACKGROUND_RANDOM[k].z);
					}
					else if (BACKGROUND_RANDOM[k].x > 1280)
					{
						BACKGROUND_RANDOM[k].posX -= (1280 * BACKGROUND_RANDOM[k].z) + (BACKGROUND_RANDOM[k].width * BACKGROUND_RANDOM[k].z);
					}
				}
			}
			else if (theme == 1)
			{
				if (BACKGROUND_RANDOM[0].x + BACKGROUND_RANDOM[0].width < 0)
				{
					for (var kr1:int = BACKGROUND_RANDOM.length - 1; kr1 > -1; kr1--)
					{
						BACKGROUND_RANDOM[kr1].posX += 1280 * 4;
					}
				}
				else if (BACKGROUND_RANDOM[1].x > 1280)
				{
					for (var kr2:int = BACKGROUND_RANDOM.length - 1; kr2 > -1; kr2--)
					{
						BACKGROUND_RANDOM[kr2].posX -= 1280 * 4;
					}
				}
				
				for (var m:int = BACKGROUND_RANDOM.length - 1; m > -1; m--)
				{
					BACKGROUND_RANDOM[m].x = (BACKGROUND_RANDOM[m].posX + -camX) / BACKGROUND_RANDOM[m].z;
				}
			}
			
			for (var j:int = BACKGROUND_CREATED.length - 1; j > -1; j-- )
			{
				BACKGROUND_CREATED[j].x = (BACKGROUND_CREATED[j].posX + -camX) / BACKGROUND_CREATED[j].z;
				if (BACKGROUND_CREATED[j].x < -BACKGROUND_CREATED[j].width || BACKGROUND_CREATED[j].x > 1080)
				{
					BACKGROUND_CREATED[j].visible = false;
				}
				else
				{
					BACKGROUND_CREATED[j].visible = true;
				}
			}
		}
		
		public function addBackground(tex:String, t:int, px:Number, py:Number, pz:Number, r:Number, sx:Number, sy:Number):void
		{
			var b:EditorItem = new EditorItem(AssetList.assets.getTexture(tex), tex, t, px, py, pz, sx, sy);
			b.x = b.posX / b.z;
			b.visible = false;
			
			var l:int = BACKGROUND_CREATED.length;
			if (l == 0)
			{
				addChild(b);
				BACKGROUND_CREATED.push(b);
			}
			else
			{
				for (var i:int = 0; i < l; i++ )
				{
					if (BACKGROUND_CREATED[i].posX / BACKGROUND_CREATED[i].z >= b.posX / b.z)
					{
						addChildAt(b, getChildIndex(BACKGROUND_CREATED[i]));
						BACKGROUND_CREATED.splice(i, 0, b);
						break;
					}
					
					if (i == l - 1)
					{
						addChild(b);
						BACKGROUND_CREATED.push(b);
						break;
					}
				}
			}
		}
		
		public function getBackgroundAt(px:Number, py:Number):EditorItem
		{
			for (var i:int = BACKGROUND_CREATED.length - 1; i > -1; i-- )
			{
				if (px > BACKGROUND_CREATED[i].x && px < BACKGROUND_CREATED[i].x + BACKGROUND_CREATED[i].width && py > BACKGROUND_CREATED[i].y && py < BACKGROUND_CREATED[i].y + BACKGROUND_CREATED[i].height)
				{
					var back:EditorItem = BACKGROUND_CREATED[i];
					removeChild(BACKGROUND_CREATED[i]);
					BACKGROUND_CREATED.splice(i, 1);
					return back;
				}
			}
			return null;
		}
	}
}