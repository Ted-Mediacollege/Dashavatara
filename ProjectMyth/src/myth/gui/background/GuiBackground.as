package myth.gui.background 
{
	import myth.util.PerlinNoise;
	import myth.util.RGB;
	import starling.display.Sprite;
	import starling.display.Image;
	import myth.util.ScaleHelper;
	import myth.graphics.AssetList;
	import starling.textures.Texture;
	import myth.util.MathHelper;
	import myth.data.Theme;
	
	public class GuiBackground extends Sprite
	{	
		public var theme:int;
		public var clouds:Vector.<Image>;
		public var earth:Vector.<Image>;
		public var hell:Vector.<Image>;
	
		private var perlin:PerlinNoise;
		private var pos:int;
		
		public function GuiBackground() 
		{
			build();
		}	
		
		public function build():void
		{
			theme = Theme.MENU_THEME;
			
			var bg:Image;
			switch(theme)
			{
				case Theme.SKY: bg = new Image(AssetList.assets.getTexture("sky_lucht")); break;
				case Theme.EARTH: bg = new Image(AssetList.assets.getTexture("earth_lucht")); break;
				case Theme.HELL: bg = new Image(AssetList.assets.getTexture("hell_lucht")); break;
			}
			addChild(bg);
			
			if (theme == Theme.SKY)
			{
				clouds = new Vector.<Image>();
				var textures:Vector.<Texture> = AssetList.assets.getTextures("common_wolk");
				for (var i:int = 0; i < 15; i++ )
				{
					var c:Image = new Image(textures[MathHelper.nextInt(3)]);
					c.x = MathHelper.nextInt(1700);
					c.y = MathHelper.nextInt(600);
					addChild(c);
					clouds.push(c);
				}
			}
			else if (theme == Theme.EARTH)
			{
				earth = new Vector.<Image>();
				for (var j:int = 0; j < 2; j++ )
				{
					var m:Image = new Image(AssetList.assets.getTexture("earth_bergen"));
					m.x = (j * 1280) - 600;
					addChild(m);
					earth.push(m);
				}
			}
			else if (theme == Theme.HELL)
			{
				hell = new Vector.<Image>();
				perlin = new PerlinNoise(123);
				
				var stalagPos:int = 0;
				for (var k:int = 0; k < 8; k++ )
				{
					stalagPos += MathHelper.nextInt(230) + 70;
					var h:Image = new Image(AssetList.assets.getTexture("hell_bg_stalag"));
					h.x = stalagPos; 
					h.y -= MathHelper.nextInt(200);
					addChild(h);
					hell.push(h);
				}
				
				stalagPos = 0;
				var list:Vector.<String> = new <String>["hell_bg_rock1", "hell_bg_rock2", "hell_bg_rock3", "hell_bg_rock4"];
				for (var p:int = 0; p < 4; p++ )
				{
					stalagPos += MathHelper.nextInt(200) + 200 * p;
					var n:Image = new Image(AssetList.assets.getTexture(list[p]));
					n.pivotY = n.height;
					n.y = 768 + MathHelper.nextInt(100);
					n.x = stalagPos;
					addChild(n);
					hell.push(n);
				}
			}
		}
		
		public function tick():void
		{
			if (theme == 0)
			{
				for (var i:int = clouds.length - 1; i > -1; i-- )
				{
					clouds[i].x -= 1;
					if (clouds[i].x + clouds[i].width < 0)
					{
						clouds[i].x += 1280 + clouds[i].width;
					}
				}
			}
			else if (theme == 1)
			{
				for (var j:int = earth.length - 1; j > -1; j-- )
				{
					if (earth[0].x < -1280)
					{
						earth[j].x += 1280;
					}
					earth[j].x -= 1;
				}
			}
			else if (theme == 2)
			{
				pos++;
				var c:int = 255 - 20 + int(perlin.noise1(pos / 10) * 40);
				
				if (c > 255) { c = 255; }
				
				for (var k:int = hell.length - 1; k > -1; k-- )
				{
					hell[k].x -= 1;
					hell[k].color = RGB.rgbToHex(new RGB(c, c * 2, c * 2));
					if (hell[k].x + hell[k].width < 0)
					{
						hell[k].x += 1280 + hell[k].width;
					}
				}
			}
		}
	}
}