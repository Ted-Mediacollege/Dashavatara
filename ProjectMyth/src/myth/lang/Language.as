package myth.lang 
{
	public class Language 
	{	
		public var menu:Vector.<String>;
		public var ingame:Vector.<String>;
		public var editor:Vector.<String>;
		
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
		}
		
		public function getTranslation(catigory:int, text:String):String
		{
			if (catigory == Lang.MENU)
			{
				for (var i:int = menu.length - 2; i > -1; i-=2)
				{
					if (text == menu[i])
					{
						return menu[i + 1];
					}
				}
			}
			else if (catigory == Lang.INGAME)
			{
				for (var j:int = ingame.length - 2; j > -1; j-=2)
				{
					if (text == ingame[j])
					{
						return ingame[j + 1];
					}
				}
			}
			else if (catigory == Lang.EDITOR)
			{
				for (var k:int = editor.length - 2; k > -1; k-=2)
				{
					if (text == editor[k])
					{
						return editor[k + 1];
					}
				}
			}
			
			return "NOT FOUND";
		}
	}
}