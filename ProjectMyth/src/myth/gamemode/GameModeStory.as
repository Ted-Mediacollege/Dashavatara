package myth.gamemode 
{
	public class GameModeStory extends GameMode
	{
		public function GameModeStory() 
		{
			
		}
		
		override public function init():void
		{
		}
		
		override public function tick():void
		{
		}
		
		override public function onDeath():void
		{
			//gui.main.switchGui(new GuiLose(lvlName, GuiGame.levelID));
		}
		
		override public function onWin():void
		{
			//AssetList.soundCommon.playSound("winSound");
			//gui.main.switchGui(new GuiWin(lvlName,levelData.nextLvlName, GuiGame.levelID), true);
		}
	}
}