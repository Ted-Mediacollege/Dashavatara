package myth.particle 
{
	import flash.geom.Point;
	public class slashPart extends Point
	{
		public var t:Number;
		public function slashPart(_x:Number,_y:Number,_t:Number) 
		{
			super(_x, _y);
			t = _t;
		}
	}
}