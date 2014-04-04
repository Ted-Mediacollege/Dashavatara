package myth.gui.game 
{
	import flash.geom.Rectangle;
	import myth.gui.components.GuiButton;
	import myth.gui.components.GuiButtonPress;
	import myth.gui.GuiScreen;
	import myth.graphics.AssetList;
	import starling.display.Image;
	import myth.data.GameData;
	import starling.display.Sprite;
	import starling.events.TouchEvent;
	import myth.input.TouchType;
	
	public class GuiEditorLoad extends GuiScreen
	{
		private var button_load:GuiButton;
		private var button_delete:GuiButton;
		
		private var listfield:Sprite;
		
		private var levelButtonsList:Vector.<GuiButtonPress>;
		
		private var levelSelected:int = -1;
		
		public function GuiEditorLoad() 
		{
		}	
		
		override public function init():void
		{
			levelButtonsList = new Vector.<GuiButtonPress>();
			
			var bg:Image = new Image(AssetList.assets.getTexture("gui_lose"));
			addChild(bg);
			
			addButton(new GuiButton(0, AssetList.assets.getTexture("gui_button_small"), screenWidth / 2 + 480, screenHeight - 20, 250, 85, "Back to editor", 35, 0xf1d195, "GameFont"));
			button_load = addButton(new GuiButton(1, AssetList.assets.getTexture("gui_button_small"), screenWidth / 2 - 480, screenHeight - 20, 250, 85, "Load Level", 35, 0xf1d195, "GameFont"));
			button_delete = addButton(new GuiButton(2, AssetList.assets.getTexture("gui_button_small"), screenWidth / 2 - 180, screenHeight - 20, 250, 85, "Delete Level", 35, 0xf1d195, "GameFont"));
			
			button_load.visible = false;
			button_delete.visible = false;
			button_load.enabled = false;
			button_delete.enabled = false;
			
			listfield = new Sprite();
			listfield.clipRect = new Rectangle(0, 0, 1200, 640);
			listfield.x = 10;
			listfield.y = 10;
			addChild(listfield);
			
			var le:int = GameData.levelnames.length;
			for (var i:int = 0; i < le; i++ )
			{
				var b:GuiButtonPress = new GuiButtonPress(i + 10, AssetList.assets.getTexture("gui_button_levela"), screenWidth / 2 - 35, 50 + i * 100, 1180, 85, GameData.levelnames[i], 35, 0xf1d195, "GameFont"); 
				listfield.addChild(b);
				buttonList.push(b);
				levelButtonsList.push(b);
			}
		}
		
		override public function action(b:GuiButton):void 
		{ 
			if (b.buttonID == 0)
			{
				main.switchGui(new GuiEditor());
			}
			else if (b.buttonID == 1)
			{
				main.switchGui(new GuiEditor(GameData.levelList[levelSelected], levelSelected));
			}
			else if (b.buttonID == 2)
			{
				GameData.levelList.splice(levelSelected, 1);
				GameData.levelnames.splice(levelSelected, 1);
				listfield.removeChild(levelButtonsList[levelSelected]);
				buttonList.splice(buttonList.indexOf(levelButtonsList[levelSelected]), 1);
				levelButtonsList.splice(levelSelected, 1);
				
				for (var j:int = levelSelected; j < levelButtonsList.length; j++ )
				{
					levelButtonsList[j].y -= 100;
					levelButtonsList[j].posY -= 100;
					levelButtonsList[j].buttonID -= 1;
				}
				
				for (var k:int = levelButtonsList.length - 1; k > -1; k-- )
				{
					levelButtonsList[k].unpress();
				}
				
				button_load.visible = true;
				button_delete.visible = true;
				button_load.enabled = true;
				button_delete.enabled = true;
				levelSelected = -1;
			}
			else if (b.buttonID > 9)
			{
				for (var i:int = levelButtonsList.length - 1; i > -1; i-- )
				{
					levelButtonsList[i].unpress();
				}
				
				(b as GuiButtonPress).press();
				button_load.visible = true;
				button_delete.visible = true;
				button_load.enabled = true;
				button_delete.enabled = true;
				levelSelected = b.buttonID - 10;
			}
		}
		
		override public function input(type:int, data:Vector.<Number>, e:TouchEvent):void 
		{ 
			if (type == TouchType.CLICK)
			{
				for (var i:int = levelButtonsList.length - 1; i > -1; i-- )
				{
					levelButtonsList[i].unpress();
				}
				
				button_load.visible = false;
				button_delete.visible = false;
				button_load.enabled = false;
				button_delete.enabled = false;
				levelSelected = -1;
			}
			else if (type == TouchType.SWIPE)
			{
				if (levelButtonsList.length > 0)
				{
					var dir:Number = data[3];
					if (levelButtonsList[0].y >= 50 && dir > 0)
					{
						dir = -(levelButtonsList[0].y - 50);
					}
					else if (levelButtonsList[levelButtonsList.length - 1].y + levelButtonsList[levelButtonsList.length - 1].height + 10 <= 640 && dir < 0)
					{
						if (levelButtonsList[0].y > 50)
						{
							dir = -((levelButtonsList[levelButtonsList.length - 1].y + levelButtonsList[levelButtonsList.length - 1].height + 10) - 640);
						}
					}
					
					if (levelButtonsList[0].y <= 50 && dir < 0)
					{
						dir = -(levelButtonsList[0].y - 50);
					}
					
					for (var j:int = levelButtonsList.length - 1; j > -1; j--)
					{
						levelButtonsList[j].y += dir;
					}
				}
			}
		}
		
		override public function tick():void
		{
			
		}
		
		override public function destroy():void
		{
			
		}
	}
}