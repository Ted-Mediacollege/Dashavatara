package myth.editor.field 
{
	import myth.background.Background;
	import myth.data.Theme;
	import starling.display.Sprite;
	import starling.display.Image;
	import myth.graphics.TextureList;
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
		
		public function FieldBackground() 
		{
			
		}
		
		public function buildCommon(size:int, t:int):void
		{
			BACKGROUND_RANDOM = new Vector.<Background>();
			BACKGROUND_CREATED = new Vector.<EditorItem>();
		
			var bg:Image = new Image(TextureList.assets.getTexture(EditorFiles.getLuchtName(t)));
			bg.blendMode = BlendMode.NONE;
			addChild(bg);
				
			if (t == Theme.SKY)
			{
				var clouds:Vector.<Texture> = TextureList.assets.getTextures("common_wolk");
				var cloudslength:int = clouds.length;
				var cloudiness:int = int(Math.ceil(size / 127 * 0.55)); //0.35
				for (var j:int = 0; j < cloudiness; j++ )
				{
					var randomHeight:int = MathHelper.nextInt(380);
					var b2:Background = new Background(clouds[MathHelper.nextInt(cloudslength)], MathHelper.nextInt(size + 2500) - 500, randomHeight - 50, 4 + (randomHeight / 100), 1 - (randomHeight / 800), 1 - (randomHeight / 800));
					b2.x = b2.posX / b2.z;
					b2.visible = false;
					BACKGROUND_RANDOM.push(b2);
					addChild(b2);
				}
			}
				
			var PLAYER_SPAWN:Background = new Background(TextureList.assets.getTexture("editor_player"), 200, 470, 1, 1, 1);
			PLAYER_SPAWN.visible = false;
			BACKGROUND_RANDOM.push(PLAYER_SPAWN);
			addChild(PLAYER_SPAWN);
			BACKGROUND_SPAWN = PLAYER_SPAWN;
				
			var PLAYER_END:Background = new Background(TextureList.assets.getTexture("editor_gate"), size - 800, 221, 1, 1, 1);
			PLAYER_END.pivotY = PLAYER_END.height;
			PLAYER_END.visible = false;
			BACKGROUND_RANDOM.push(PLAYER_END);
			addChild(PLAYER_END);
			BACKGROUND_END = PLAYER_END;
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
				addBackground(bgNames[a[i].type], a[i].x, a[i].y, a[i].depth, 1, 1);
			}
		}
		
		public function tick(camX:Number):void
		{
			for (var i:int = BACKGROUND_RANDOM.length - 1; i > -1; i-- )
			{
				BACKGROUND_RANDOM[i].x = (BACKGROUND_RANDOM[i].posX + -camX) / BACKGROUND_RANDOM[i].z;
				if (BACKGROUND_RANDOM[i].x < -BACKGROUND_RANDOM[i].width || BACKGROUND_RANDOM[i].x > 1080)
				{
					BACKGROUND_RANDOM[i].visible = false;
				}
				else
				{
					BACKGROUND_RANDOM[i].visible = true;
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
		
		public function addBackground(tex:String, px:Number, py:Number, pz:Number, sx:Number, sy:Number):void
		{
			var b:EditorItem = new EditorItem(TextureList.assets.getTexture(tex), tex, 0, px, py, pz, sx, sy);
			b.x = b.posX / b.z;
			b.visible = false;
			BACKGROUND_CREATED.push(b);
			addChild(b);
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