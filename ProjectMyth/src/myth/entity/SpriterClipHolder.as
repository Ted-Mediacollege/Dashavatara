package myth.entity 
{
	import treefortress.spriter.SpriterClip;
	public class SpriterClipHolder 
	{
		public var inUse:Boolean = false;
		public var clip:SpriterClip;
		public function SpriterClipHolder(_clip:SpriterClip) 
		{
			clip = _clip;
		}
		
	}

}