package myth.editor.field 
{
	import starling.display.Sprite;
	import myth.background.Background;
	
	public class FieldObjects extends Sprite
	{
		public var OBJECTS:Vector.<Background>;
		
		public function FieldObjects() 
		{
			
		}
		
		public function buildNew():void
		{
			OBJECTS = new Vector.<Background>();
		}
		
		public function buildFile():void
		{
			OBJECTS = new Vector.<Background>();
		}
		
		public function tick(camX:Number):void
		{
		}
	}
}