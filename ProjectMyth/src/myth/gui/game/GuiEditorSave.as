package myth.gui.game 
{
	import myth.gui.GuiScreen;
	import myth.gui.components.GuiButton;
	import myth.graphics.AssetList;
	import starling.display.Image;
	import myth.data.GameData;

	public class GuiEditorSave extends GuiScreen
	{
		private var levelString:String;
		
		public function GuiEditorSave(s:String) 
		{
			levelString = s;
		}
		
		override public function init():void
		{
			var bg:Image = new Image(AssetList.assets.getTexture("gui_lose"));
			addChild(bg);
			
			addButton(new GuiButton(0, AssetList.assets.getTexture("gui_button_small"), screenWidth / 2, screenHeight / 2, 250, 85, "Save level", 35, 0xf1d195, "GameFont"));
		}
		
		override public function action(b:GuiButton):void 
		{ 
			if (b.buttonID == 0)
			{
				GameData.levelnames.unshift("Unnamed - " + getDateString());
				GameData.levelList.unshift(levelString);
				
				main.switchGui(new GuiEditor(levelString, 0));
			}
		}
		
		override public function tick():void
		{
			
		}
		
		override public function destroy():void
		{
			
		}
		
		public function getDateString():String
		{
			var d:Date = new Date();
			var s:String = "";
			
			s += "" + d.getDate();
			s += "-" + d.getMonth();
			s += "-" + d.getFullYear();
			
			var h:int = d.getHours();
			if (h < 10)
			{
				s += " 0" + h;
			}
			else
			{
				s += " " + h;
			}
			
			var m:int = d.getMinutes();
			if (m < 10)
			{
				s += ":0" + m;
			}
			else
			{
				s += ":" + m;
			}
			
			return s;
		}
	}
}