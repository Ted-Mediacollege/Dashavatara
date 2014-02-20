package myth.world 
{
	import myth.background.Background;
	import starling.display.Sprite;
	import myth.graphics.TextureList;
	import myth.util.TimeHelper;
	import starling.textures.Texture;
	import myth.util.MathHelper;
	import myth.Main;
	
	public class WorldBackground extends Sprite
	{
		public var Backgrounds:Vector.<Background>;
		
		public function WorldBackground(length:int) 
		{
			Backgrounds = new Vector.<Background>();
			build(0, length);
		}
		
		public function build(camX:Number, length:int):void
		{
			var textures:Vector.<Texture> = TextureList.atlas_background.getTextures("background");
			
			for (var i:int = 0; i < 2; i++ )
			{
				var b:Background = new Background(textures[3], i * 8000, 120, 7, 5, 8);
				b.x = (b.posX + -camX) /b.z;
				b.visible = false;
				Backgrounds.push(b);
				addChild(b);
			}
			
			for (var j:int = 0; j < 50; j++ )
			{
				var b2:Background = new Background(textures[MathHelper.nextInt(3)], MathHelper.nextInt(34000), MathHelper.nextInt(370), 4, 1, 1);
				b2.x = (b2.posX + -camX) /b2.z;
				b2.visible = false;
				Backgrounds.push(b2);
				addChild(b2);
			}
			
			for (var k:int = 0; k < 5; k++ )
			{
				var b3:Background = new Background(textures[4], 800 + 2800 * k - 800 + MathHelper.nextInt(1600), 265, 2, 1, 1);
				b3.x = (b3.posX + -camX) /b3.z;
				b3.visible = false;
				Backgrounds.push(b3);
				addChild(b3);
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