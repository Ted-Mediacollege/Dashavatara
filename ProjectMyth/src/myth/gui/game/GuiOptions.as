package myth.gui.game 
{
	import myth.gui.GuiScreen;
	import myth.gui.components.GuiButton;
	import myth.input.TouchType;
	import myth.gui.components.GuiText;
	import myth.graphics.AssetList;
	import myth.gui.background.GuiBackground;
	import myth.util.Debug;
	import myth.lang.Lang;
	import myth.data.GameData;

	public class GuiOptions extends GuiScreen
	{	
		private var button_music:GuiButton;
		private var button_sound:GuiButton;
		private var button_lang:GuiButton;
		
		private var pressed:Boolean = false;
		
		public function GuiOptions() 
		{
			
		}
		
		override public function init():void 
		{ 
			addChild(background);
			
			var b:GuiButton = addButton(new GuiButton(0, AssetList.assets.getTexture("gui_button_default"), screenWidth / 2, screenHeight / 2 + 330, 450, 100, Lang.trans(Lang.MENU, "main.back"), 45, 0xf1d195, "GameFont"));
			
			button_music = addButton(new GuiButton(10, AssetList.assets.getTexture("gui_button_default"), screenWidth / 2, 110, 450, 100, "Music: BOOLEAN", 45, 0xf1d195, "GameFont"));
			button_sound = addButton(new GuiButton(11, AssetList.assets.getTexture("gui_button_default"), screenWidth / 2, 220, 450, 100, "Sound: BOOLEAN", 45, 0xf1d195, "GameFont"));
			button_lang = addButton(new GuiButton(12, AssetList.assets.getTexture("gui_button_default"), screenWidth / 2, 330, 450, 100, "Language: INT", 45, 0xf1d195, "GameFont"));

			button_music.buttonText.text = GameData.MUSIC == true ? Lang.trans(Lang.MENU, "option.music") + " : " + Lang.trans(Lang.MENU, "option.on") : Lang.trans(Lang.MENU, "option.music") + ": " + Lang.trans(Lang.MENU, "option.off");
			button_sound.buttonText.text = GameData.SOUND == true ? Lang.trans(Lang.MENU, "option.sound") + ": " + Lang.trans(Lang.MENU, "option.on") : Lang.trans(Lang.MENU, "option.sound") + ": " + Lang.trans(Lang.MENU, "option.off");
			button_lang.buttonText.text = Lang.trans(Lang.MENU, "option.language") + ": " + Lang.language_list[Lang.currentLang];
		}
		
		override public function tick():void 
		{ 
			super.tick();
			background.tick();
		}
		
		override public function action(b:GuiButton):void 
		{ 
			if (b.buttonID == 0)
			{
				main.switchGui(new GuiMainMenu(), true);
			}
			else if (b.buttonID == 10)
			{
				GameData.MUSIC = !GameData.MUSIC;
				button_music.buttonText.text = GameData.MUSIC == true ? Lang.trans(Lang.MENU, "option.music") + " : " + Lang.trans(Lang.MENU, "option.on") : Lang.trans(Lang.MENU, "option.music") + ": " + Lang.trans(Lang.MENU, "option.off");
			}
			else if (b.buttonID == 11)
			{
				GameData.SOUND = !GameData.SOUND;
				button_sound.buttonText.text = GameData.SOUND == true ? Lang.trans(Lang.MENU, "option.sound") + ": " + Lang.trans(Lang.MENU, "option.on") : Lang.trans(Lang.MENU, "option.sound") + ": " + Lang.trans(Lang.MENU, "option.off");
			}
			else if (b.buttonID == 12)
			{
				if (!pressed)
				{
					pressed = true;
					
					GameData.LANG++;
					if (GameData.LANG > Lang.language_list.length - 1)
					{
						GameData.LANG = 0;
					}
					
					Lang.setLanguage(GameData.LANG);
					
					main.switchGui(new GuiOptions(), true);
				}
			}
			/*else if (b.buttonID == 10)
			{
				if (Debug.USER[0] == -1)
				{
					Debug.USER[0] = 0;
				}
				else
				{
					Debug.USER[0] = -1;
				}
				b.buttonText.text = "DEBUG1: " + Debug.USER[0];
			}
			else if (b.buttonID == 11)
			{
				if (Debug.USER[1] == -1)
				{
					Debug.USER[1] = 2;
				}
				else
				{
					Debug.USER[1] = -1;
				}
				b.buttonText.text = "DEBUG2: " + Debug.USER[1];
			}
			else if (b.buttonID == 12)
			{
				if (Debug.USER[2] == -1)
				{
					Debug.USER[2] = 1;
				}
				else
				{
					Debug.USER[2] = -1;
				}
				b.buttonText.text = "DEBUG3: " + Debug.USER[2];
			}*/
		}
		
		override public function destroy():void 
		{ 
			
		}
	}
}