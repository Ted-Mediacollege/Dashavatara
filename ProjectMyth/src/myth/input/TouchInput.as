package myth.input 
{
	import starling.events.Touch;
	import starling.events.TouchEvent;
	import starling.events.TouchPhase;
	import myth.Main;
	import flash.geom.Point;
	import myth.util.MathHelper;
	
	public class TouchInput 
	{	
		public var touchStart:Point;
		public var zooming:Boolean = false;
		
		public function onMouse(e:TouchEvent):void
		{
			var touches:Vector.<Touch> = e.getTouches(Main.gui);
			
			if (touches.length > 1) 
			{
				zooming = true;
				
				var positions:Vector.<Point> = new Vector.<Point>(4);
				for (var i:int = 0; i < 2; i++ )
				{
					positions[i * 2] = touches[i].getLocation(Main.gui);
					positions[i * 2 + 1] = touches[i].getPreviousLocation(Main.gui);
				}
				
				var v1:Vector.<Number> = new Vector.<Number>(1);
				v1[0] = MathHelper.dis2(positions[0].x, positions[0].y, positions[2].x, positions[2].y) - MathHelper.dis2(positions[1].x, positions[1].y, positions[3].x, positions[3].y); 
				Main.input(TouchType.ZOOM, v1, e);
			}
			else if (touches.length == 1) 
			{
				if(touches[0].phase == TouchPhase.BEGAN)
				{
					zooming = false;
					touchStart = touches[0].getLocation(Main.gui);
				}
				else if(touches[0].phase == TouchPhase.ENDED)
				{
					if (zooming)
					{
						zooming = false;
					}
					else
					{
						var touchEnd:Point = touches[0].getLocation(Main.gui);
						
						var v2:Vector.<Number> = new Vector.<Number>(4);
						v2[0] = touchStart.x; 
						v2[1] = touchStart.y; 
						v2[2] = touchEnd.x; 
						v2[3] = touchEnd.y;
						Main.input(TouchType.CLICK, v2);
					}
				}
				else if(touches[0].phase == TouchPhase.MOVED)
				{	
					var touchPos:Point = touches[0].getLocation(Main.gui);
					var touchMovement:Point = touches[0].getMovement(Main.gui);
					
					var v3:Vector.<Number> = new Vector.<Number>(4);
					v3[0] = touchPos.x; 
					v3[1] = touchPos.y; 
					v3[2] = touchMovement.x; 
					v3[3] = touchMovement.y;
					Main.input(TouchType.SWIPE, v3);
				}
			}
		}
	}
}