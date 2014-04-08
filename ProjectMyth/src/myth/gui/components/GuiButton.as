package myth.gui.components 
{
	import flash.geom.Point;
	import starling.display.Image;
	import starling.display.Sprite;
	import starling.text.TextField;
	import starling.textures.Texture;
	import myth.util.ScaleHelper;
	
	public class GuiButton extends Sprite
	{
		public var image:Image;
		public var buttonID:int;
		public var value:Number; //Voor sliders of andere settings buttons (wordt nog niet gebruikt)
		public var enabled:Boolean = true;
		
		public var posX:Number;
		public var posY:Number;
		public var posWidth:Number;
		public var posHeight:Number;
		
		public var buttonText:TextField;
		
		/* 
		 * id = button id (id voor action func in guiScreen)
		 * a = button texture
		 * px = X position
		 * py = Y position
		 * pw = hitbox Width
		 * ph = hitbox Height
		 * t = button text
		 * s = text size
		 * c = text color
		 * f = font name 
		 */
		
		public function GuiButton(id:int, a:Texture, px:Number, py:Number, pw:Number, ph:Number, t:String, s:int = 15, c:uint = 0xf1d195, f:String = "Arial") 
		{
			x = px;
			y = py;
			
			posX = px;
			posY = py;
			posWidth = pw;
			posHeight = ph;
			
			image = new Image(a);
			image.pivotX = image.width / 2;
			image.pivotY = image.height / 2;
			addChild(image);
			buttonID = id;
			
			if (t != "") 
			{
				buttonText = new TextField(posWidth, posHeight, t, f, s, c);
				buttonText.hAlign = "center";
				buttonText.vAlign = "center";
				buttonText.x = -(image.width / 2);
				buttonText.y = -(image.height / 2);
				addChild(buttonText);
			}
			
		}
		
		public function click():void
		{
		}
		
		public function setEnabled(e:Boolean):void
		{
			enabled = e;
			
			if (!e)
			{
				image.color = 0x000000;
			}
		}
	}
}