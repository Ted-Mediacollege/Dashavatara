package myth.entity.player 
{
	import flash.geom.Point;
	import myth.entity.Entity;
	import nape.callbacks.InteractionType;
	import nape.geom.Vec2;
	import nape.phys.Body;
	import nape.phys.BodyList;
	import starling.display.Sprite;
	import starling.events.TouchEvent;
	import myth.util.collision.RectCollider;
	import myth.Main;
	import myth.util.TimeHelper;
	
	public class EntityPlayerBase extends Entity
	{
		//public var collider:RectCollider;
		
		public var art:Sprite;
		public var velX:Number;
		public var velY:Number;
		public var onfeet:Boolean;
		
		public var swimmer:Boolean;
		private var maxBreakSpeed:Number = 5;
		private var Xpos:Number;
		private var playerBody:Body;
		private var playerMass:Number;
		
		public function EntityPlayerBase(_swimmer:Boolean,_XPos:int)
		{
			super(100, 180, -50, -180);
			art = new Sprite();
			addChild(art);
			
			swimmer = _swimmer;
			Xpos = _XPos;
			playerBody = Main.world.playerBody;
			playerMass = Main.world.playerBody.mass;
			
			//collider = new RectCollider(art.x, art.y, art.width, art.height, art.rotation, art.pivotX, art.pivotY);
		}
		
		public function input(type:int, data:Vector.<Number>, e:TouchEvent):void 
		{
			
		}
		
		private static var levelComplete:Boolean = false;
		
		public function levelDone():void {
			levelComplete = true;
		}
		
		public static function levelStart():void {
			levelComplete = false;
		}
		
		override public function tick():void {
			super.tick();
			var speed:Number = Main.world.speed;
			var force:Number = speed * 5;
			var maxBreakSpeed:Number = speed * 2;
			var XposT:Number = Xpos + 50 + (maxBreakSpeed * playerMass);
			if (levelComplete) {
				Xpos += speed;
			}
			//trace(Main.world.playerBody.mass+" - "+Main.world.playerBody.velocity.x);
			//trace("X: "+this.x);
			//move
			if (swimmer) {
				playerBody.applyImpulse(new Vec2((playerMass * -10), 0));
			}else{
				if (this.x < XposT) {
					if(playerBody.velocity.x+this.x>XposT){
					}else { 
						playerBody.applyImpulse(new Vec2((playerMass * force), 0));
					}
				}else if (this.x > XposT)  {
					if(this.x+playerBody.velocity.x<XposT){
					}else { 
						playerBody.applyImpulse(new Vec2((playerMass * -force), 0));
					}
				}
			}
			//apply break
			if (playerBody.velocity.x != 0) {
				if (playerBody.velocity.x > 0) {
					if(playerBody.velocity.x<maxBreakSpeed){
						playerBody.applyImpulse(new Vec2(playerMass * -(playerBody.velocity.x), 0));
					}else {
						playerBody.applyImpulse(new Vec2(playerMass * -maxBreakSpeed, 0));
					}
				}else {
					if(playerBody.velocity.x>-maxBreakSpeed){
						playerBody.applyImpulse(new Vec2(playerMass * playerBody.velocity.x, 0));
					}else {
						playerBody.applyImpulse(new Vec2(playerMass * maxBreakSpeed, 0));
					}
				}
			}
		}
		
		public function pushBack():void
		{
			trace("push");
			Main.world.playerBody.applyImpulse(new Vec2(-140*Main.world.deltaSpeed*Main.world.playerBody.mass, -200*Main.world.playerBody.mass));
		}
		
		public function isOnFeet():Boolean
		{
			var onFeet:Boolean = false;
			var colliders:BodyList = playerBody.interactingBodies(InteractionType.COLLISION);
			var colLength:int = colliders.length;
			var playerBodyId:int = playerBody.id;
			for (var j:int = 0; j < colLength; j++) 
			{
				var l:int = colliders.at(j).arbiters.length;
				for (var i:int = 0; i < l; i++) 
				{
					if (colliders.at(j).arbiters.at(i).isCollisionArbiter()) {
						var colAngle:Number;
						if(playerBodyId==colliders.at(j).arbiters.at(i).body1.id){
							colAngle = colliders.at(j).arbiters.at(i).collisionArbiter.normal.mul(-1).angle;
						}else {
							colAngle = colliders.at(j).arbiters.at(i).collisionArbiter.normal.angle;
						}
						if (colAngle > -Math.PI / 2 - 0.2 && colAngle < -Math.PI / 2 + 0.2) {
							return true;
						}
					}
				}
			}
			return false;
		}
	}
}