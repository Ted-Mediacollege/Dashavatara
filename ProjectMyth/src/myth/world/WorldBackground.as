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
		private static var textures_earth:Vector.<String> = new <String>["broken tower", "earth_bush", "earth_grass1", "earth_grass2", "earth_tree", "earth_veg", "earth_venus_flytrap"];
		private static var textures_hell:Vector.<String> = new <String>["hell_bg_rock1", "hell_bg_rock2", "hell_bg_rock3", "hell_bg_rock4", "hell_bg_stalag"];
		private static var textures_lucht:Vector.<String> = new <String>["sky_lucht", "earth_lucht", "hell_lucht"];
		
		public var Backgrounds_created:Vector.<Background>;
		public var Backgrounds_random:Vector.<Background>;
		
		public var queue:Vector.<Vector.<int>>;	
		public var theme:int;
		public var textureNames:Vector.<String>;
		
		public function WorldBackground(data:Vector.<Vector.<int>>, t:int) 
		{
			queue = data;
			theme = t;
			
			Backgrounds_created = new Vector.<Background>();
			Backgrounds_random = new Vector.<Background>();
			
			var bg:Image = new Image(AssetList.assets.getTexture(textures_lucht[theme]));
			bg.blendMode = BlendMode.NONE;
			addChild(bg);
			
			if (theme == Theme.SKY)
			{
				var textures:Vector.<Texture> = AssetList.assets.getTextures("common_wolk");
				var texturesLength:int = textures.length;
				for (var j:int = 0; j < 25; j++ )
				{
					var depth:Number = (MathHelper.nextInt(380) / 100) + 3;
					var b2:Background = new Background(textures[MathHelper.nextInt(texturesLength)], MathHelper.nextInt(1480 * depth), (depth * 90) - 300, depth, 1 - (depth / 20), 1 - (depth / 20));
					b2.x = b2.posX / b2.z;
					Backgrounds_random.push(b2);
					addChild(b2);
				}
			}
			else if (theme == Theme.EARTH)
			{
				var mountain:Texture = AssetList.assets.getTexture("earth_bergen");
				for (var m:int = 0; m < 2; m++ )
				{
					var b3:Background = new Background(mountain, (m * 1280) * 4, 0, 4, 1, 1);
					b3.x = b3.posX / b3.z;
					Backgrounds_random.push(b3);
					addChild(b3);
				}
			}
			
			textureNames = getTexturesForTheme(theme);
			var queueLength:int = queue.length;
			for (var k:int = 0; k < queueLength; k++ )
			{
				if (queue[k][2] / queue[k][1] > 1280)
				{
					queue.splice(0, k - 1);
					return;
				}
				
				var b5:Background = new Background(AssetList.assets.getTexture(textureNames[queue[k][0]]), queue[k][2], queue[k][3], queue[k][1], 1, 1);
				b5.x = b5.posX / b5.z;
				Backgrounds_created.push(b5);
				addChild(b5);
				
				if (k == queueLength - 1)
				{
					queue.splice(0, k - 1);
				}
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
		
		public function addToQueue(ty:int, pz:int, px:int, py:int):void
		{
			var d:Vector.<int> = new <int>[ty, pz, px, py];
			queue.push(d);
		}
		
		public function tick(camX:Number):void
		{
			for (var i:int = Backgrounds_created.length - 1; i > -1; i-- )
			{
				Backgrounds_created[i].x = (Backgrounds_created[i].posX + -camX) / Backgrounds_created[i].z;
				if (Backgrounds_created[i].x + Backgrounds_created[i].width < 0)
				{
					removeChild(Backgrounds_created[i]);
					Backgrounds_created.splice(i, 1);
				}
			}
			
			if (queue.length > 0)
			{
				if ((queue[0][2] + -camX) / queue[0][1] < 1380)
				{
					var d:Vector.<int> = queue.shift();
					var b5:Background = new Background(AssetList.assets.getTexture(textureNames[d[0]]), d[2], d[3], d[1], 1, 1);
					b5.x = b5.posX / b5.z;
					Backgrounds_created.push(b5);
					addChild(b5);
				}
			}
			
			if (theme == 0)
			{
				for (var j:int = Backgrounds_random.length - 1; j > -1; j--)
				{
					Backgrounds_random[j].x = (Backgrounds_random[j].posX + -camX) / Backgrounds_random[j].z;
					if (Backgrounds_random[j].x + Backgrounds_random[j].width < 0)
					{
						Backgrounds_random[j].posX += (1280 * Backgrounds_random[j].z) + (Backgrounds_random[j].width * Backgrounds_random[j].z);
					}
				}
			}
			else if (theme == 1)
			{
				if (Backgrounds_random[0].x + Backgrounds_random[0].width < 0)
				{
					for (var kr:int = Backgrounds_random.length - 1; kr > -1; kr--)
					{
						Backgrounds_random[kr].posX += 1280 * 4;
					}
				}
				
				for (var k:int = Backgrounds_random.length - 1; k > -1; k--)
				{
					Backgrounds_random[k].x = (Backgrounds_random[k].posX + -camX) / Backgrounds_random[k].z;
				}
			}
		}
	}
}