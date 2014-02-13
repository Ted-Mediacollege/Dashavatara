package myth.gui 
{
	import myth.input.TouchType;
	import myth.gui.components.GuiButton;
	import myth.Main;
	import starling.display.Sprite;
	import starling.events.TouchEvent;
	
	public class GuiScreen extends Sprite
	{
		public static var screenWidth:int = 1280;
		public static var screenHeight:int = 720;
		
		public var main:Main;
		public var buttonList:Vector.<GuiButton>;
		
		//called when gui contructed
		public function init():void { }
		
		//called every enter frame
		public function tick():void { }
		
		//called by touch input
		//type.click = startX, startY, endX, endY
		//type.swipe = posX, posY, movedX, movedY
		//type.zoom = zoom amount
		public function input(type:int, data:Vector.<Number>, e:TouchEvent):void { }
		
		//button click
		public function action(id:GuiButton):void { }
		
		//called when gui gets destroyed
		public function destroy():void { }
		
		//called by the main
		public function preInit(m:Main):void
		{
			main = m;
			buttonList = new Vector.<GuiButton>();
		}
		
		public function addButton(b:GuiButton):GuiButton
		{
			addChild(b);
			buttonList.push(b);
			return b;
		}
		
		//called by touch input
		public function touch(type:int, data:Vector.<Number>, e:TouchEvent):void
		{
			if (type == TouchType.CLICK)
			{
				for (var i:int = 0; i < buttonList.length; i++ )
				{
					if (data[0] > buttonList[i].posX - buttonList[i].posWidth / 2 && 
						data[1] > buttonList[i].posY - buttonList[i].posHeight / 2 && 
						data[2] > buttonList[i].posX - buttonList[i].posWidth / 2 && 
						data[3] > buttonList[i].posY - buttonList[i].posHeight / 2 && 
						data[0] < buttonList[i].posX + buttonList[i].posWidth / 2 && 
						data[1] < buttonList[i].posY + buttonList[i].posHeight / 2 &&
						data[2] < buttonList[i].posX + buttonList[i].posWidth / 2 && 
						data[3] < buttonList[i].posY + buttonList[i].posHeight / 2
						)
					{
						action(buttonList[i]);
						break;
					}
				}
			}
			
			input(type, data, e);
		}
	}
}