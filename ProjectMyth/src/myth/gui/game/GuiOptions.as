package myth.gui.game 
{
	import myth.gui.GuiScreen;
	import myth.gui.components.GuiButton;
	import myth.input.TouchType;
	import myth.gui.components.GuiText;
	import myth.graphics.TextureList;
	import myth.gui.background.GuiBackground;
	import myth.world.WorldBackground;
	import myth.util.ScaleHelper;
	import myth.world.WorldTiles;

	public class GuiOptions extends GuiScreen
	{
		//public var test:WorldBackground;
		public var test:WorldTiles;
		public var pos:Number = 0;
		
		public function GuiOptions() 
		{
			
		}
		
		override public function init():void 
		{ 
			var bg:GuiBackground = new GuiBackground();
			addChild(bg);
			
			var t:GuiText = new GuiText(20, 20, 400, 60, "left", "top", "GuiOptions", 25, 0x000000);
			addChild(t);			
			
			
			
			//test = new WorldBackground();
			//addChild(test);
			//test.build(0);
			
			
			var v:Vector.<int> = new Vector.<int>();
			v.push(0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0);
			test = new WorldTiles(TextureList.atlas_background.getTextures("water"), v);
			addChild(test);
			test.build(0);
			
			
			var b:GuiButton = addButton(new GuiButton(0, TextureList.atlas_gui.getTexture("button_small"), screenWidth / 2, screenHeight / 2 + 330, 450, 100, "Main Menu", 25, 0x000000));
		}
		
		override public function tick():void 
		{ 
			pos += 1;
			test.tick(pos);
		}
		
		override public function action(b:GuiButton):void 
		{ 
			main.switchGui(new GuiMainMenu());
		}
		
		override public function destroy():void 
		{ 
			
		}
	}
}