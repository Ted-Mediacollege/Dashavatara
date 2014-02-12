package myth.lang 
{
	public class Language 
	{	
		public var ingame:Vector.<String>;
		public var menu:Vector.<String>;
		
		public function Language(xml:XML) 
		{
			var length:int = xml.menu.children().length();
		}
	}
}







/*

			var xmldata:XML = new XML(new xmlfile());
			var citieslength:int = xmldata.cities.children().length();
			CITIES = new Vector.<City>(citieslength);
			
			for (var i:int = 0; i < citieslength; i++ )
			{
				CITIES[i] = new City(xmldata.cities.city[i].@x, xmldata.cities.city[i].@y, xmldata.cities.city[i].@name);
				CITIES[i].setNode(xmldata.cities.city[i].node);
				CITIES[i].setHitbox(xmldata.cities.city[i].click.@x1, xmldata.cities.city[i].click.@y1, xmldata.cities.city[i].click.@x2, xmldata.cities.city[i].click.@y2);
			}

*/