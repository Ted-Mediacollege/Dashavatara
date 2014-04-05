package myth.tutorial 
{
	import starling.display.Image;
	import myth.graphics.AssetList;
	
	public class TutorialPanel extends Image
	{
		public function TutorialPanel(text:String) 
		{
			super(AssetList.assets.getTexture("tutorial_field"));
			
			x = 200;
			y = 185;
			
			
		}
	}
}