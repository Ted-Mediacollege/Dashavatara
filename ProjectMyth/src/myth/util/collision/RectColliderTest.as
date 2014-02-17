package myth.util.collision 
{
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.KeyboardEvent;
	import flash.text.TextField;
	import flash.ui.Keyboard;
	/**
	 * ...
	 * @author Kit van de Bunt
	 */
	public class RectColliderTest extends Sprite
	{
		private var rect1:RectCollider = new RectCollider(100, 100, 50, 100, 30 ,-25,50);
		private var rect2:RectCollider = new RectCollider(180, 100, 50, 100, 30 ,0,0);
		private var rectSprite:Sprite = new Sprite;
		private var rectSprite2:Sprite = new Sprite;
		
		private var text:TextField = new TextField();
		public function RectColliderTest() 
		{
			addChild(text);
			
			//1
			//addChild(rectSprite);
			rectSprite.graphics.lineStyle(2, 0, 1);
			
			//rectSprite.graphics.drawRect(0+rect1.pivotX, 0+rect1.pivotY, rect1.width+rect1.pivotX, rect1.height+rect1.pivotY);
			rectSprite.graphics.drawCircle(0, 0, 4);
			rectSprite.graphics.drawRect(0+rect1.pivotX, 0+rect1.pivotY, rect1.width, rect1.height);
			rectSprite.x = rect1.x;
			rectSprite.y = rect1.y;
			rectSprite.rotation = rect1.rotation;
			
			
			//2
			//addChild(rectSprite2);
			rectSprite2.graphics.lineStyle(2, 0, 1);
			
			rectSprite2.graphics.drawCircle(0, 0, 4);
			rectSprite2.graphics.drawRect(0+rect2.pivotX, 0+rect2.pivotY, rect2.width, rect2.height);
			rectSprite2.x = rect2.x;
			rectSprite2.y = rect2.y;
			rectSprite2.rotation = rect2.rotation;
			
			
			//graphics.moveTo(rect1.rectPoints[0].x,rect1.rectPoints[0].y);
			stage.addEventListener(KeyboardEvent.KEY_DOWN, keyDown);
			stage.addEventListener(KeyboardEvent.KEY_UP, keyUp);
			addEventListener(Event.ENTER_FRAME, loop);
			
		}
		
		private var up:int, down:int, left:int, right:int;
		private function keyDown(k:KeyboardEvent):void {
			switch(k.keyCode) {
				case Keyboard.W:
					up = -1;
					break;
				case Keyboard.D:
					right = 1;
					break;
				case Keyboard.S:
					down = 1;
					break;
				case Keyboard.A:
					left = -1;
					break;
			}
		}
		
		private function keyUp(k:KeyboardEvent):void {
			switch(k.keyCode) {
				case Keyboard.W:
					up = 0;
					break;
				case Keyboard.D:
					right = 0;
					break;
				case Keyboard.S:
					down = 0;
					break;
				case Keyboard.A:
					left = 0;
					break;
			}
		}
		
		public function loop(e:Event):void {
			var hor:int = left + right;
			var ver:int = up + down;
			rect2.x += hor;
			rect2.y += ver;
			rectSprite2.x = rect2.x;
			rectSprite2.y = rect2.y;
			
			rect1.rotation += 1;
			rect2.rotation += 1.2;
			rectSprite.rotation = rect1.rotation;
			rectSprite2.rotation = rect2.rotation;
			
			graphics.clear();
			if (rect1.intersect(rect2)) {
				text.text = "true";
				graphics.lineStyle(4, 0x00ff00, 1);
			}else {
				text.text = "false";
				graphics.lineStyle(4, 0x00dddd, 1);
			}
			
			//draw 1
			
			 
			graphics.moveTo(rect1.rectPoints()[0].x, rect1.rectPoints()[0].y);
			graphics.lineTo(rect1.rectPoints()[1].x, rect1.rectPoints()[1].y);
			graphics.lineTo(rect1.rectPoints()[2].x, rect1.rectPoints()[2].y);
			graphics.lineTo(rect1.rectPoints()[3].x, rect1.rectPoints()[3].y);
			graphics.lineTo(rect1.rectPoints()[0].x, rect1.rectPoints()[0].y);
			graphics.drawCircle(rect1.rectCenter().x, rect1.rectCenter().y, 2);
			
			graphics.moveTo(rect2.rectPoints()[0].x, rect2.rectPoints()[0].y);
			graphics.lineTo(rect2.rectPoints()[1].x, rect2.rectPoints()[1].y);
			graphics.lineTo(rect2.rectPoints()[2].x, rect2.rectPoints()[2].y);
			graphics.lineTo(rect2.rectPoints()[3].x, rect2.rectPoints()[3].y);
			graphics.lineTo(rect2.rectPoints()[0].x, rect2.rectPoints()[0].y);
			graphics.drawCircle(rect2.rectCenter().x, rect2.rectCenter().y, 2);
		}
	}

}