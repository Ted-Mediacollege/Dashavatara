package myth.tutorial 
{
	import starling.display.Image;
	import myth.graphics.AssetList;
	import starling.display.Sprite;
	import starling.text.TextField;
	
	public class TutorialPanel extends Sprite
	{
		private var image:Image;
		private var text_info:TextField;
		private var text_cont:TextField;
		
		public function TutorialPanel(text:String) 
		{
			x = 200;
			y = 185;
			
			image = new Image(AssetList.assets.getTexture("tutorial_field"));
			addChild(image);
			
			text_info = new TextField(880, 300, text, "GameFont", 35, 0x000000, false);
			text_info.vAlign = "top";
			text_info.hAlign = "center";
			addChild(text_info);
			
			text_cont = new TextField(880, 100, "Tap to continue", "GameFont", 35, 0x000000, false);
			text_cont.y = 300;
			text_info.vAlign = "center";
			text_info.hAlign = "center";
			addChild(text_cont);
		}
	}
}