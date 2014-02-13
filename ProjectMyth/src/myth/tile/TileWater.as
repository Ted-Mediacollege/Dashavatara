package myth.tile 
{
	import starling.display.MovieClip;
	import myth.world.WorldTiles;
	
	public class TileWater extends Tile
	{		
		private var movieclip:MovieClip;
		
		public function TileWater(px:Number, py:Number, i:int) 
		{
			super(i);
			
			movieclip = new MovieClip(WorldTiles.waterTiles);
			movieclip.x = px;
			movieclip.y = py;
			//movieclip.fps = 5;
			addChild(movieclip);
			
			id = i;
		}	
	}
}