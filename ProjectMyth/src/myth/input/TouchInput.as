package myth.input 
{
	import starling.events.Touch;
	import starling.events.TouchEvent;
	import myth.Main;
	
	public class TouchInput 
	{	
		public var touchStart:Point;
		public var zooming:Boolean = false;
		
		public function onMouse(e:TouchEvent):void
		{
			var touches:Vector.<Touch> = e.getTouches(Main.gui);
			
			/*
			var touches:Vector.<Touch> = e.getTouches(Main.activeGui);
			if (touches.length > 1)
			{
				zooming = true;
				
				var positions:Vector.<Point> = new Vector.<Point>(4);
				for (var i:int = 0; i < 2; i++ )
				{
					positions[i * 2] = touches[i].getLocation(Main.activeGui);
					positions[i * 2 + 1] = touches[i].getPreviousLocation(Main.activeGui);
				}
				
				Main.activeGui.touchZoom(MathHelper.dis2(positions[0].x, positions[0].y, positions[2].x, positions[2].y) - MathHelper.dis2(positions[1].x, positions[1].y, positions[3].x, positions[3].y));
			}
			else if (touches.length == 1)
			{
				if(touches[0].phase == TouchPhase.BEGAN)
				{
					zooming = false;
					touchStart = touches[0].getLocation(Main.activeGui);
				}
				else if(touches[0].phase == TouchPhase.ENDED)
				{
					if (zooming)
					{
						zooming = false;
					}
					else
					{
						var touchEnd:Point = touches[0].getLocation(Main.activeGui);
						Main.activeGui.touchClick(touchStart.x, touchStart.y, touchEnd.x, touchEnd.y);
					}
				}
				else if(touches[0].phase == TouchPhase.MOVED)
				{	
					var touchPos:Point = touches[0].getLocation(Main.activeGui);
					var touchMovement:Point = touches[0].getMovement(Main.activeGui);
					Main.activeGui.touchMove(touchPos.x, touchPos.y, touchMovement.x, touchMovement.y);
				}
				else if(touches[0].phase == TouchPhase.HOVER)
				{
					
				}
			}
			*/
		}
	}

