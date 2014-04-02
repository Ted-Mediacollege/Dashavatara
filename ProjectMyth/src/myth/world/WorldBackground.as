package myth.world 
{
	import myth.background.Background;
	import starling.display.Sprite;
	import myth.graphics.AssetList;
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
		private static var textures_sky:Vector.<String> = new <String>["sky_tree", "sky_flower", "common_easteregg1"]; 
		private static var textures_earth:Vector.<String> = new <String>["earth_tree"];
		private static var textures_hell:Vector.<String> = new <String>["hell_bg_rock1", "hell_bg_rock2", "hell_bg_rock3", "hell_bg_rock4", "hell_bg_stalag"];
		private static var textures_lucht:Vector.<String> = new <String>["sky_lucht", "earth_lucht", "hell_lucht"];
		
		public var Backgrounds:Vector.<Background>;
		
		public function WorldBackground(data:Vector.<Vector.<int>>, length:int, theme:int) 
		{
			Backgrounds = new Vector.<Background>();
			build(data, 0, length, theme);
		}
		
		public function build(data:Vector.<Vector.<int>>, camX:Number, size:int, theme:int):void
		{
			var bg:Image = new Image(AssetList.assets.getTexture(textures_lucht[theme]));
			bg.blendMode = BlendMode.NONE;
			addChild(bg);

			if (theme == Theme.SKY)
			{
				var clouds:Vector.<Texture> = AssetList.assets.getTextures("common_wolk");
				var cloudslength:int = clouds.length;
				var cloudiness:int = int(Math.ceil(size / 127 * 0.35));
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
			else if (theme == Theme.EARTH)
			{
				var mountain:Texture = AssetList.assets.getTexture("earth_bergen");
				var amount:int = int(Math.ceil((size / 1280) / 4)) + 1;
				for (var m:int = 0; m < amount; m++ )
				{
					var b3:Background = new Background(mountain, (m * 1280) * 4, 0, 4, 1, 1);
					b3.x = b3.posX / b3.z;
					b3.visible = false;
					Backgrounds.push(b3);
					addChild(b3);
				}
			}
			
			var textureNames:Vector.<String> = getTexturesForTheme(theme);
			var dataLength:int = data.length;
			for (var k:int = 0; k < dataLength; k++ )
			{
				var b5:Background = new Background(AssetList.assets.getTexture(textureNames[data[k][0]]), data[k][2], data[k][3], data[k][1], 1, 1);
				b5.x = b5.posX / b5.z;
				b5.visible = false;
				Backgrounds.push(b5);
				addChild(b5);
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