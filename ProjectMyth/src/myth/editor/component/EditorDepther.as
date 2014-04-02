package myth.editor.component 
{
	import starling.display.Image;
	import myth.graphics.AssetList;
	
	public class EditorDepther extends EditorTool
	{	
		private var constructor:EditorConstructor;
		private var image:Image;
		private var button:Image;
		private var depth:int;
		
		public function EditorDepther(cons:EditorConstructor, d:int) 
		{
			constructor = cons;
			
			image = new Image(AssetList.assets.getTexture("editor_tool_depth"));
			image.pivotX = image.width / 2;
			image.pivotY = image.height / 2;
			
			button = new Image(AssetList.assets.getTexture("editor_tool_slider"));
			button.pivotX = button.width / 2;
			button.pivotY = button.height / 2;
			button.y = 16;
			button.x = -117 + (d - 1) * 26;
			
			depth = d;
			
			constructor.toolholder.addChild(image);
			constructor.toolholder.addChild(button);
			constructor.toolholder.visible = true;
			constructor.toolActive = true;
		}
		
		override public function swipeAction(px:int, py:int):void
		{
			px = px - constructor.toolholder.x - 117;
			if (px < 0) { px = 0; }
			if (px > 260) { px = 260; }
			
			depth = int(Math.floor(px / 26)) + 1;
			button.x = -117 + (depth - 1) * 26;
			
			
		}
		
		override public function action(px:int, py:int):void
		{
			px = px - constructor.toolholder.x - 117;
			if (px < 0) { px = 0; }
			if (px > 260) { px = 260; }
			
			depth = int(Math.floor(px / 26)) + 1;
			button.x = -117 + (depth - 1) * 26;
		}
		
		override public function destroy():void
		{
			constructor.toolholder.removeChild(image);
			constructor.toolholder.removeChild(button);
		}
	}
}