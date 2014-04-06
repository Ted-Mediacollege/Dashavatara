package myth.lang 
{
	public class Language 
	{	
		public var menu:Vector.<String>;
		public var ingame:Vector.<String>;
		public var editor:Vector.<String>;
		public var tutorial:Vector.<String>;
		
		public function Language(xml:XML) 
		{
			var menuLength:int = xml.menu.children().length();
			menu = new Vector.<String>(menuLength * 2);
			for (var i:int = 0; i < menuLength; i++)
			{
				menu.push("" + xml.menu.t[i].@name);
				menu.push("" + xml.menu.t[i]);
			}
			
			var gameLength:int = xml.game.children().length();
			ingame = new Vector.<String>(gameLength * 2);
			for (var j:int = 0; j < gameLength; j++)
			{
				ingame.push("" + xml.game.t[j].@name);
				ingame.push("" + xml.game.t[j]);
			}
			
			var editorLength:int = xml.editor.children().length();
			editor = new Vector.<String>(editorLength * 2);
			for (var k:int = 0; k < editorLength; k++)
			{
				editor.push("" + xml.editor.t[k].@name);
				editor.push("" + xml.editor.t[k]);
			}
			
			var tutorialLength:int = xml.tutorial.children().length();
			tutorial = new Vector.<String>(tutorialLength * 2);
			for (var m:int = 0; m < tutorialLength; m++)
			{
				tutorial.push("" + xml.tutorial.t[m].@name);
				tutorial.push("" + xml.tutorial.t[m]);
			}
		}
		
		public function getTranslation(catigory:int, text:String):String
		{
			switch(catigory)
			{
				case Lang.MENU: for (var i:int = menu.length - 2; i > -1; i-=2) { if (text == menu[i]) { return menu[i + 1]; } } break;
				case Lang.INGAME: for (var j:int = ingame.length - 2; j > -1; j-=2) { if (text == ingame[j]) { return ingame[j + 1]; } } break;
				case Lang.EDITOR: for (var k:int = editor.length - 2; k > -1; k-=2) { if (text == editor[k]) { return editor[k + 1]; } } break;
				case Lang.TUTORIAL: for (var m:int = tutorial.length - 2; m > -1; m-=2) { if (text == tutorial[m]) { return tutorial[m + 1]; } } break;
			}
			
			return "ERROR";
		}
	}
}