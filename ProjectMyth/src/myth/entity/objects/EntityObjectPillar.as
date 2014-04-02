package myth.entity.objects 
{
	import myth.graphics.AssetList;
	import starling.display.Image;
	import myth.Main;
	import myth.data.Theme;
	
	public class EntityObjectPillar extends EntityObjectBase
	{
		public static var sky_objects:Vector.<String> = new <String>["sky_pilar"];
		public static var earth_objects:Vector.<String> = new <String>["earth_pilaar"];
		public static var hell_objects:Vector.<String> = new <String>["hell_pilar"];
		
		public var image:Image;
		
		public function EntityObjectPillar(id:int) 
		{
			var currentObjects:Vector.<String>;
			switch(Main.world.levelData.theme)
			{
				case Theme.SKY: currentObjects = sky_objects; break;
				case Theme.EARTH: currentObjects = earth_objects; break;
				case Theme.HELL: currentObjects = hell_objects; break;
			}
			
			image = new Image(AssetList.assets.getTexture(currentObjects[id]));
			image.pivotY = image.height;
			artLayer.addChild(image);
		}
	}
}