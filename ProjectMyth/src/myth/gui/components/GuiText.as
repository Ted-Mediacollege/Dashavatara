package myth.gui.components 
{
	import starling.display.Sprite;
	import starling.text.TextField;
	import myth.util.ScaleHelper;

	public class GuiText extends Sprite
	{
		public var text:TextField;
		
		/* px = x position
		 * py = y position
		 * w = width
		 * h = height
		 * aH = align Horizontal
		 * aV = align Vertical
		 * t = text
		 * s = font size
		 * c = font color
		 * f = font family
		 */
		
		public function GuiText(px:Number, py:Number, w:Number, h:Number, aH:String, aV:String, t:String, s:int = 15, c:uint = 0x000000, f:String = "Arial") 
		{
			x = ScaleHelper.tX(px);
			y = ScaleHelper.tY(py);
			scaleX = ScaleHelper.scaleX;
			scaleY = ScaleHelper.scaleY;
			
			text = new TextField(w, h, t, f, s, c);
			text.hAlign = aH;
			text.vAlign = aV;
			addChild(text);
		}
	}
}