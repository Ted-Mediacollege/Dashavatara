package myth.entity 
{
	import flash.geom.Point;
	import flash.geom.Rectangle;
	import myth.util.collision.RectCollider;
	import starling.display.Shape;
	import starling.display.Sprite;
	import myth.util.Debug;
	
	public class Entity extends Sprite
	{
		public var artLayer:Sprite = new Sprite();
		private var debugLayer:Sprite = new Sprite();
		public var collider:RectCollider;
		private var colShape:Shape = new Shape();
		public function Entity(colWidth:Number = 180,colHeight:Number = 180,colPivotX:Number = -90,colPivotY:Number = -90) 
		{
			addChild(artLayer);
			addChild(debugLayer);
			collider = new RectCollider(this.x, this.y, colWidth, colHeight, this.rotation, colPivotX, colPivotY);
			Debug.test(function():void{
				colShape.x += collider.pivotX;
				colShape.y += collider.pivotY;
				colShape.graphics.lineStyle(3, 0x00ff55, 0.8);
				colShape.graphics.drawRect(0, 0, collider.width, collider.height);
				colShape.graphics.drawCircle(-colPivotX, -colPivotY, 5);
				debugLayer.addChild(colShape);
			},Debug.DrawRectsColliders);
		}
		
		public function tick():void {
			collider.x = this.x;
			collider.y = this.y;
			collider.rotation = this.rotation;
		}
	}
}