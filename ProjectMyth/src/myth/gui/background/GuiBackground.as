package myth.gui.background 
{
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
		}
	}
}