package myth.gui.background 
{
	import starling.display.Sprite;
	import starling.display.Image;
	import myth.util.ScaleHelper;
	import myth.graphics.TextureList;
	
	public class GuiBackground extends Sprite
	{	
		public function GuiBackground() 
		{
			var bg:Image = new Image(TextureList.atlas_gui_background.getTexture("background"));
			bg.scaleX = ScaleHelper.scaleX;
			bg.scaleY = ScaleHelper.scaleY;
			addChild(bg);
		}	
	}
}