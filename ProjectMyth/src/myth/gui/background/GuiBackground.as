package myth.gui.background 
{
	import starling.display.Sprite;
	import starling.display.Image;
	import myth.util.ScaleHelper;
	import myth.graphics.TextureList;
	import starling.textures.Texture;
	import myth.util.MathHelper;
	
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
			
			var bg:Image = new Image(TextureList.atlas_background2.getTexture("background"));
			addChild(bg);
			
			var textures:Vector.<Texture> = TextureList.atlas_background.getTextures("background");
			
			var r:Image = new Image(textures[3]);
			r.x = -200;
			r.y = 200;
			r.scaleX = 4.5;
			r.scaleY = 4.5;
			addChild(r);
			
			for (var i:int = 0; i < 15; i++ )
			{
				var c:Image = new Image(textures[MathHelper.nextInt(3)]);
				c.x = MathHelper.nextInt(1700);
				c.y = MathHelper.nextInt(600);
				addChild(c);
				clouds.push(c);
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