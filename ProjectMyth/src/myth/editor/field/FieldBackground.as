package myth.editor.field 
{
	import myth.background.Background;
	import starling.display.Sprite;
	import starling.display.Image;
	import myth.graphics.TextureList;
	import starling.display.BlendMode;
	import starling.textures.Texture;
	import myth.util.MathHelper;
	
	public class FieldBackground extends Sprite
	{
		public var BACKGROUND_RANDOM:Vector.<Background>;
		public var BACKGROUND_OBJECTS:Vector.<Background>;
		
		public function FieldBackground() 
		{
			
		}
		
		public function buildCommon(size:int, t:int):void
		{
			BACKGROUND_RANDOM = new Vector.<Background>();
			BACKGROUND_OBJECTS = new Vector.<Background>();
			
			if (t == 0)
			{
				var bg:Image = new Image(TextureList.assets.getTexture("sky_lucht"));
				bg.blendMode = BlendMode.NONE;
				addChild(bg);
							
				var clouds:Vector.<Texture> = TextureList.assets.getTextures("common_wolk");
				var cloudslength:int = clouds.length;
				var cloudiness:int = int(Math.ceil(size / 127 * 0.35));
				for (var j:int = 0; j < cloudiness; j++ )
				{
					var b2:Background = new Background(clouds[MathHelper.nextInt(cloudslength)], MathHelper.nextInt(size + 2500) - 500, MathHelper.nextInt(280) - 50, 4, 1, 1);
					b2.x = b2.posX / b2.z;
					b2.visible = false;
					BACKGROUND_RANDOM.push(b2);
					addChild(b2);
				}
			}
			else if (t == 1)
			{
				buildCommon(size, 0);
			}
			else
			{
				buildCommon(size, 0);
			}
		}
		
		public function buildNew(size:int, t:int):void
		{
			buildCommon(size, t);
		}
		
		public function buildFile(t:int):void
		{
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
		}
	}
}