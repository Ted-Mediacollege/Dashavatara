package myth.tile 
{
	import starling.display.MovieClip;
	import myth.world.WorldTiles2;
	import starling.core.Starling;
	
	public class TileWater extends Tile
	{		
		private var movieclip:MovieClip;
		
		public function TileWater(px:Number, py:Number, i:int) 
		{
			super(i);
			
			movieclip = new MovieClip(WorldTiles2.waterTiles);
			movieclip.x = px;
			movieclip.y = py;
			movieclip.fps = 10;
			movieclip.play();
			movieclip.touchable = false;
			addChild(movieclip);
			
			//Starling.juggler.add(movieclip);
			
			id = i;
		}	
	}
}