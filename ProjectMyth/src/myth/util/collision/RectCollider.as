package myth.util.collision 
{
	import flash.geom.Rectangle;
	import flash.geom.Matrix;
	import flash.geom.Point;
	/**
	 * ...
	 * @author Kit van de Bunt
	 */
	public class RectCollider extends Rectangle
	{
		public var rotation:Number;
		public var pivotX:Number;
		public var pivotY:Number;
		public var centerShape:Point;
		public var radius:Number;
		private var matrix:Matrix = new Matrix;
		private var points:Vector.<Point> = new Vector.<Point>(4);
		private var shape:Vector.<Point> = new Vector.<Point>(4);
		public function RectCollider(x:Number,y:Number,width:Number,height:Number,_rotation:Number,_pivotX:Number,_pivotY:Number) 
		{
			super(x, y, width, height);
			rotation = _rotation;
			
			pivotX = _pivotX;
			pivotY = _pivotY;
			matrix.rotate(_rotation);
			points[0] = new Point(x + pivotX, y + pivotY);
			points[1] = new Point(x + pivotX + width, y + pivotY);
			points[3] = new Point(x + pivotX, y + pivotY + height);
			points[2] = new Point(x + pivotX + width, y + pivotY + height);
			shape[0] = new Point(0 + pivotX, 0 + pivotY);
			shape[1] = new Point(0 + pivotX + width, 0 + pivotY);
			shape[3] = new Point(0 + pivotX, 0 + pivotY + height);
			shape[2] = new Point(0 + pivotX + width, 0 +pivotY + height);
			centerShape = new Point(pivotX + (width / 2), pivotY + (height / 2));
			//trace(centerShape);
			radius = centerShape.subtract(shape[0]).length;
		}
		
		public function intersect(otherRect:RectCollider):Boolean {
			var inter:Boolean = false;
			var minCheckDist:Number = this.radius + otherRect.radius;
			var dist:Number = this.rectCenter().subtract(otherRect.rectCenter()).length;
			//trace(this.rectCenter());
			//trace(otherRect.rectCenter());
			if (dist < minCheckDist) {
				var otherPoints:Vector.<Point> = otherRect.rectPoints();
				var c:Number;
				var s:Number;
				var rotatedX:Number;
				var rotatedY:Number;
				var leftX:Number;
				var rightX:Number;
				var topY:Number;
				var bottomY:Number;
				var i:int;
				//check if other rect point is in this rect
				c = Math.cos( -this.rotation );
				s = Math.sin( -this.rotation );
				//perform a normal check if the new point is inside the 
				//bounds of the UNrotated rectangle
				leftX = this.x +this.pivotX;
				rightX = this.x + this.width +this.pivotX;
				topY = this.y +this.pivotY;
				bottomY = this.y + this.height +this.pivotY;
				for (i = 0; i < otherPoints.length;i++){
					//UNrotate the point depending on the rotation of the rectangle
					rotatedX = this.x + c * (otherPoints[i].x - this.x) - s * (otherPoints[i].y - this.y);
					rotatedY = this.y + s * (otherPoints[i].x - this.x) + c * (otherPoints[i].y - this.y);
				
					inter = leftX <= rotatedX && rotatedX <= rightX && topY <= rotatedY && rotatedY <= bottomY;
					if (inter) {
						break;
					}
				}
				
				if (!inter) {
					//check if this rect point is in other rect
					c = Math.cos( -otherRect.rotation );
					s = Math.sin( -otherRect.rotation );
					leftX = otherRect.x +otherRect.pivotX;
					rightX = otherRect.x + otherRect.width +otherRect.pivotX;
					topY = otherRect.y +otherRect.pivotY;
					bottomY = otherRect.y + otherRect.height +otherRect.pivotY;
					var thisPoints:Vector.<Point> = this.rectPoints();
					for (i = 0; i < thisPoints.length; i++) {
						
						rotatedX = otherRect.x + c * (thisPoints[i].x - otherRect.x) - s * (thisPoints[i].y - otherRect.y);
						rotatedY = otherRect.y + s * (thisPoints[i].x - otherRect.x) + c * (thisPoints[i].y - otherRect.y);
					
						
						inter = leftX <= rotatedX && rotatedX <= rightX && topY <= rotatedY && rotatedY <= bottomY;
						if (inter) {
							break;
						}
					}
				}
			}
			return inter;
		}
		
		public function rectPoints():Vector.< Point > {
			var mat:Matrix = new Matrix;
			mat.rotate(rotation);
			var returnPoints:Vector.<Point> = new Vector.<Point>(4);
			//returnPoints[0] = mat.transformPoint(shape[0]);
			//returnPoints[1] = mat.transformPoint(shape[1]);
			//returnPoints[2] = mat.transformPoint(shape[2]);
			//returnPoints[3] = mat.transformPoint(shape[3]);
			//trace(mat);
			//apply matrix
			//x' = x*a + y*c + tx
			//y' = x*b + y*d + ty
			
			returnPoints[0] = new Point((shape[0].x * mat.a) + (shape[0].y * mat.c), (shape[0].x * mat.b) + (shape[0].y*mat.d));
			returnPoints[1] = new Point((shape[1].x * mat.a) + (shape[1].y * mat.c), (shape[1].x * mat.b) + (shape[1].y*mat.d));
			returnPoints[2] = new Point((shape[2].x * mat.a) + (shape[2].y * mat.c), (shape[2].x * mat.b) + (shape[2].y*mat.d));
			returnPoints[3] = new Point((shape[3].x * mat.a) + (shape[3].y * mat.c), (shape[3].x * mat.b) + (shape[3].y*mat.d));
			
			returnPoints[0].x += x;
			returnPoints[0].y += y;
			returnPoints[1].x += x;
			returnPoints[1].y += y;
			returnPoints[3].x += x;
			returnPoints[3].y += y;
			returnPoints[2].x += x;
			returnPoints[2].y += y;
			
			//trace(returnPoints[0],returnPoints[1],returnPoints[2],returnPoints[3]);
			return returnPoints;
		}
		
		public function rectCenter():Point {
			var mat:Matrix = new Matrix;
			mat.rotate(rotation);
			var returnPoint:Point = new Point;
			
			returnPoint = new Point((centerShape.x * mat.a) + (centerShape.y * mat.c), (centerShape.x * mat.b) + (centerShape.y*mat.d));
			
			returnPoint.x += x;
			returnPoint.y += y;
			
			return returnPoint;
		}
	}

}