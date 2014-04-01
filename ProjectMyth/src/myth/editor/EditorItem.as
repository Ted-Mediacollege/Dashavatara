package myth.editor 
{
	import myth.background.Background;
	import starling.display.Sprite;
	import starling.textures.Texture;
	import starling.display.Image;

	public class EditorItem extends Background
	{
		public var type:int;
		public var item_name:String;
		
		public function EditorItem(t:Texture, n:String, ty:int, px:Number, py:Number, pz:Number, sx:Number, sy:Number, r:Number = 0) 
		{
			super(t, px, py, pz, sx, sy, r);
			
			item_name = n;
			type = ty;
		}
	}
}