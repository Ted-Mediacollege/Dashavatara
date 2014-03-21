package myth.editor.field 
{
	import starling.display.Sprite;
	import myth.background.Background;
	
	public class FieldEnemies extends Sprite
	{
		public var ENEMIES:Vector.<Background>;
		
		public function FieldEnemies() 
		{
			
		}
		
		public function buildNew():void
		{
			ENEMIES = new Vector.<Background>();
		}
		
		public function buildFile():void
		{
			ENEMIES = new Vector.<Background>();
		}
		
		public function tick(camX:Number):void
		{
		}
	}
}