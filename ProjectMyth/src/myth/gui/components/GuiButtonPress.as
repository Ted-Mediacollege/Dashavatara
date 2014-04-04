package myth.gui.components 
{
	import starling.display.Image;
	import starling.textures.Texture;
	import myth.graphics.AssetList;
	
	public class GuiButtonPress extends GuiButton
	{
		public var pressed:Boolean = false;
		
		public function GuiButtonPress(id:int, a:Texture, px:Number, py:Number, pw:Number, ph:Number, t:String, s:int = 15, c:uint = 0xf1d195, f:String = "Arial") 
		{
			super(id, a, px, py, pw, ph, t, s, c, f);
			pressed = false;
		}
		
		override public function click():void
		{
		}
		
		public function press():void
		{
			if (!pressed)
			{
				pressed = true;
				removeChild(image);
				image = new Image(AssetList.assets.getTexture("gui_button_levelb"));
				image.pivotX = image.width / 2;
				image.pivotY = image.height / 2;
				addChildAt(image, 0);
			}
		}
		
		public function unpress():void
		{
			if (pressed)
			{
				pressed = false;
				removeChild(image);
				image = new Image(AssetList.assets.getTexture("gui_button_levela"));
				image.pivotX = image.width / 2;
				image.pivotY = image.height / 2;
				addChildAt(image, 0);
			}
		}
	}
}