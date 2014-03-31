package myth.editor.component 
{
	import starling.display.Image;
	import myth.graphics.TextureList;
	import starling.display.Sprite;
	import starling.utils.deg2rad;
	import myth.util.MathHelper;

	public class EditorRotater extends EditorTool
	{
		private var constructor:EditorConstructor;
		public var rotate:Number = 0;
		private var image:Image;
		
		public function EditorRotater(cons:EditorConstructor, r:Number = 0) 
		{
			constructor = cons;
			rotate = r;
			
			image = new Image(TextureList.assets.getTexture("editor_tool_rotator"));
			image.pivotX = image.width / 2;
			image.pivotY = image.height / 2;
			
			constructor.toolholder.addChild(image);
			constructor.toolholder.visible = true;
			
			constructor.toolActive = true;
		}
		
		override public function swipeAction(px:int, py:int):void
		{
			var rot:Number = MathHelper.pointToRadian(constructor.toolholder.x, px, constructor.toolholder.y, py);
			image.rotation = rot;
			constructor.item.rotation = rot;
			constructor.frame.rotation = rot;
		}
		
		override public function action(px:int, py:int):void
		{
			image.rotation = MathHelper.pointToRadian(constructor.toolholder.x, px, constructor.toolholder.y, py);
		}
		
		override public function destroy():void
		{
			constructor.toolholder.removeChild(image);
		}
	}
}