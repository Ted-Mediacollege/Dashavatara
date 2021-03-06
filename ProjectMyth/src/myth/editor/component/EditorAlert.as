package myth.editor.component 
{
	import myth.gui.components.GuiText;
	import starling.display.Image;
	import starling.display.Sprite;
	import myth.graphics.AssetList;
	
	public class EditorAlert extends Sprite
	{
		private var image:Image;
		
		public var actionID:int;
		private var tileText:GuiText;
		private var mainText:GuiText;
		private var yesText:GuiText;
		private var noText:GuiText;
		
		public function EditorAlert(id:int, titleString:String, mainString:String, yesString:String, noString:String) 
		{
			image = new Image(AssetList.assets.getTexture("editor_alert"));
			addChild(image);
			
			x = 640;
			y = 384;
			image.pivotX = image.width / 2;
			image.pivotY = image.height / 2;
			
			actionID = id;
			
			tileText = new GuiText(0, -140, 440, 50, "center", "center", titleString, 40, 0xf1d195, "GameFont");
			mainText = new GuiText(0, -100, 440, 170, "center", "center", mainString, 28, 0xf1d195, "GameFont");
			yesText = new GuiText(-110, 70, 220, 80, "center", "center", yesString, 32, 0x000000, "GameFont");
			noText = new GuiText(110, 70, 220, 80, "center", "center", noString, 32, 0x000000, "GameFont");
			
			addChild(tileText);
			addChild(mainText);
			addChild(yesText);
			addChild(noText);
		}
	}
}