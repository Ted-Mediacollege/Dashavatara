package myth.world 
{
	import myth.background.Background;
	import starling.display.Sprite;
	import myth.graphics.TextureList;
	import myth.util.TimeHelper;
	import starling.textures.Texture;
	import myth.util.MathHelper;
	import myth.Main;
	import starling.display.BlendMode;
	import starling.display.Image;
	
	public class WorldBackground extends Sprite
	{
		public var Backgrounds:Vector.<Background>;
		
		public function WorldBackground(length:int) 
		{
			Backgrounds = new Vector.<Background>();
			build(0, length);
		}
		
		public function build(camX:Number, size:int):void
		{
			var textures:Vector.<Texture> = TextureList.atlas_background.getTextures("background");
						
			var bg:Image = new Image(TextureList.atlas_background2.getTexture("background"));
			bg.blendMode = BlendMode.NONE;
			addChild(bg);

			var clouds:Vector.<Texture> = TextureList.assets.getTextures("common_wolk");
			var cloudslength:int = clouds.length;
			var cloudiness:int = int(Math.ceil(size / 127 * 0.55));
			for (var j:int = 0; j < cloudiness; j++ )
			{
				var randomHeight:int = MathHelper.nextInt(380);
				var b2:Background = new Background(clouds[MathHelper.nextInt(cloudslength)], MathHelper.nextInt(size + 2500) - 500, randomHeight - 50, 4 + (randomHeight / 100), 1 - (randomHeight / 800), 1 - (randomHeight / 800));
				b2.x = b2.posX / b2.z;
				b2.visible = false;
				Backgrounds.push(b2);
				addChild(b2);
			}
		}
		
		public function tick(camX:Number):void
		{
			for (var i:int = Backgrounds.length - 1; i > -1; i-- )
			{
				Backgrounds[i].x = (Backgrounds[i].posX + -camX) / Backgrounds[i].z;
				if (Backgrounds[i].x < -Backgrounds[i].width || Backgrounds[i].x > 1280)
				{
					Backgrounds[i].visible = false;
				}
				else
				{
					Backgrounds[i].visible = true;
				}
			}
		}
	}
}