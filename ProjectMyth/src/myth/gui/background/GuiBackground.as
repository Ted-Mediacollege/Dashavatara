package myth.gui.background 
{
	import starling.display.Sprite;
	import starling.display.Image;
	import myth.util.ScaleHelper;
	import myth.graphics.TextureList;
	import starling.textures.Texture;
	import myth.util.MathHelper;
	import myth.data.Theme;
	
	public class GuiBackground extends Sprite
	{	
		public var clouds:Vector.<Image>;
		
		public function GuiBackground() 
		{
			build();
		}	
		
		public function build():void
		{
			clouds = new Vector.<Image>();
			
			var bg:Image;
			switch(Theme.MENU_THEME)
			{
				case Theme.SKY: bg = new Image(TextureList.assets.getTexture("sky_lucht")); break;
				case Theme.EARTH: bg = new Image(TextureList.assets.getTexture("earth_lucht")); break;
				case Theme.HELL: bg = new Image(TextureList.assets.getTexture("hell_lucht")); break;
			}
			addChild(bg);
			
			if (Theme.MENU_THEME == Theme.SKY)
			{
				var textures:Vector.<Texture> = TextureList.assets.getTextures("common_wolk");
				for (var i:int = 0; i < 15; i++ )
				{
					var c:Image = new Image(textures[MathHelper.nextInt(3)]);
					c.x = MathHelper.nextInt(1700);
					c.y = MathHelper.nextInt(600);
					addChild(c);
					clouds.push(c);
				}
			}
		}
		
		public function tick():void
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
	}
}