package myth.gui.components 
{
	import starling.textures.Texture;
	public class GuiButtonToggle extends GuiButton
	{
		public var toggle:Boolean;
		private var texOn:Texture;
		private var texOff:Texture;
		/**
		 * Toggle Button
		 * @param id = button id (id voor action func in guiScreen)
		 * @param a = button texture
		 * @param ad = button texture
		 * @param px = X position
		 * @param py = Y position
		 * @param pw = hitbox Width
		 * @param ph = hitbox Height
		 * @param t = button text
		 * @param s = text size
		 * @param c = text color
		 * @param f = font name 
		 * @param ac = active 
		 */
		public function GuiButtonToggle(id:int, a:Texture, ad:Texture, px:Number, py:Number, pw:Number, ph:Number, t:String, ac:Boolean, s:int = 15, c:uint = 0x000000, f:String = "Arial")  {
			super(id, a, px, py, pw, ph, t, s, c, f);
			texOn = ad;
			texOff = a;
			toggle = ac;
			if (toggle) {
				image.texture = texOn;
			}
		}
		
		override public function click():void {
			toggleButton();
		}
		
		public function setState(active:Boolean):void {
			toggle = !active;
			toggleButton();
		}
		
		private function toggleButton():void {
			if(toggle){
				image.texture = texOff;
				toggle = false;
			}else {
				image.texture = texOn;
				toggle = true;
			}
		}
	}
}