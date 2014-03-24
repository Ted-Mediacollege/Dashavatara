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
	import myth.data.Theme;
	
	public class WorldBackground extends Sprite
	{
		//NEED TO BE THE SAME IN EditorFiles.as
		private static var textures_sky:Vector.<String> = new <String>["sky_tree"]; 
		private static var textures_earth:Vector.<String> = new <String>["earth_tree"];
		private static var textures_hell:Vector.<String> = new <String>["earth_tree"];
		private static var textures_lucht:Vector.<String> = new <String>["sky_lucht", "earth_lucht", "null"];
		
		public var Backgrounds:Vector.<Background>;
		
		public function WorldBackground(data:Vector.<Vector.<int>>, length:int, theme:int) 
		{
			Backgrounds = new Vector.<Background>();
			build(data, 0, length, theme);
		}
		
		public function build(data:Vector.<Vector.<int>>, camX:Number, size:int, theme:int):void
		{
			var bg:Image = new Image(TextureList.assets.getTexture(textures_lucht[theme]));
			bg.blendMode = BlendMode.NONE;
			addChild(bg);

			if (theme == Theme.SKY)
			{
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
			
			var textureNames:Vector.<String> = getTexturesForTheme(theme);
			var dataLength:int = data.length;
			for (var k:int = 0; k < dataLength; k++ )
			{
				var b3:Background = new Background(TextureList.assets.getTexture(textureNames[data[k][0]]), data[k][2], data[k][3], data[k][1], 1, 1);
				b3.x = b3.posX / b3.z;
				b3.visible = false;
				Backgrounds.push(b3);
				addChild(b3);
			}
		}
		
		public function getTexturesForTheme(theme:int):Vector.<String>
		{
			switch(theme)
			{
				case Theme.SKY:   return textures_sky;
				case Theme.EARTH: return textures_earth;
				default:          return textures_hell;
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