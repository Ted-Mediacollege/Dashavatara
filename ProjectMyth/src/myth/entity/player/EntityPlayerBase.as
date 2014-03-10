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
		
		override public function tick():void {
			//trace(Main.world.playerBody.mass+" - "+Main.world.playerBody.velocity.x);
			trace("X: "+this.x);
			super.tick();
			var speed:Number = Main.world.speed;
			var force:Number = speed*5;
			var XposT:Number = Xpos+ (force*playerMass)
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
			Main.world.playerBody.applyImpulse(new Vec2(-160*Main.world.deltaSpeed*Main.world.playerBody.mass, -200*Main.world.playerBody.mass));
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
	
	/*import flash.geom.Point;
	import starling.display.Sprite;
	import starling.events.TouchEvent;
	import myth.util.collision.RectCollider;
	import myth.Main;
	
	public class EntityPlayerBase extends Sprite
	{
		public var collider:RectCollider;
		
		public var art:Sprite;
		public var velX:Number;
		public var velY:Number;
		public var onfeet:Boolean;
		
		public function EntityPlayerBase()
		{
			art = new Sprite();
			art.x = 200;
			art.y = 640;
			addChild(art);
			
			velX = 0;
			velY = 0;
			
			onfeet = false;
			
			collider = new RectCollider(art.x, art.y, art.width, art.height, art.rotation, art.pivotX, art.pivotY);
		}
		
		public function input(type:int, data:Vector.<Number>, e:TouchEvent):void 
		{
		}
		
		public function tick():void 
		{
			if (velY < 10)
			{
				velY += 0.5;
			}
				
			if (isSideColliding(1))
			{
				art.x -= Main.world.deltaSpeed / 10;
				while (isSideColliding(1))
				{
					art.x -= Main.world.deltaSpeed / 10;
				}
				velX = 0;
			}
			else
			{
				if (art.x < 200)
				{
					velX = 1;
				}
				else
				{
					velX = 0;
				}
				
				if (isSideColliding(2))
				{
					art.y -= velY / 10;
					while (isSideColliding(2))
					{
						art.y -= velY / 10;
					}
					velY = 0;
				}
			}
			
			art.x += velX;
			art.y += velY;
			
			if (art.y > 640)
			{
				art.y = 640;
				velY = 0;
				onfeet = true;
			}
		}
		
		public function isOnFeet():Boolean
		{
			if (isCollidingAt(art.x, art.y + 2) || art.y > 638)
			{
				onfeet = true;
			}
			else
			{
				onfeet = false;
			}
			
			return onfeet;
		}
		
		public function isSideColliding(side:int):Boolean
		{
			if (side == 0) //TOP 
			{
				//not used?
			}
			else if (side == 1) //RIGHT
			{			
				if ((isCollidingAt(art.x + art.width / 2, art.y - art.height) && isCollidingAt(art.x + art.width / 2, art.y - art.height + 5)) || (isCollidingAt(art.x + art.width / 2 + 1, art.y - 5) && isCollidingAt(art.x + art.width / 2 + 1, art.y)))
				{
					return true;
				}
				return false;
			}
			else if (side == 2) //DOWN
			{
				var amount:int = 0;
				for (var i:Number = art.x + art.width / 2; i > art.x - art.width / 2; i-= 30 )
				{
					if (isCollidingAt(i, art.y))
					{
						amount++;
						if (amount > 1)
						{
							return true;
						}
					}
				}
				return false;
			}
			else if (side == 3) //LEFT
			{
				//not used?
			}

			return false;
		}
		
		public function isCollidingAt(px:Number, py:Number):Boolean
		{
			for (var i:int = Main.world.objectManager.objectList.length - 1; i > -1; i--) 
			{
				if (Main.world.objectManager.objectList[i].collider.intersectPoint(new Point(px, py)))
				{
					return true;
				}
			}
			
			return false;
		}
	}*/
	
	/////////////////////////////////////////
	/*
	import flash.geom.Point;
	import myth.entity.Entity;
	import starling.display.Image;
	import starling.events.TouchEvent;
	import myth.input.TouchType;
	import myth.Main;
	import myth.util.MathHelper;

	public class EntityPlayerBase extends Entity
	{
		private var canAttack:Boolean;
		private var canSwim:Boolean;
		private var canJump:Boolean;
		
		public function EntityPlayerBase(_canAttack:Boolean,_canSwim:Boolean,_canJump:Boolean,_colWidth:int=128,_colHeight:int=200,_pivotX:int=-64,_pivotY:int=-100) {
			super(_colWidth, _colHeight, _pivotX, _pivotY);
			canAttack = _canAttack;
			canSwim = _canSwim;
			canJump = _canJump;
			PosOut = new Point(x, y);
		}
		
		public function input(type:int, data:Vector.<Number>, e:TouchEvent):void {
			
		}
		
		private var drag:Number = 0.1;
		private var gravity:Number = 1;
		private var groundHeight:int = 640;
		private var gravityVelocity:Number = 0;
		private var jumpVelocity:Number = 0;
		private var totalYVelocity:Number = 0;
		private static var PosOut:Point;
		private static var outDirection:Point;
		private static var pos:Point = new Point(0, 0);
			
		override public function tick():void {
			//pillar collision
			gravityVelocity += gravity;
			pos.x = this.x- Main.world.deltaSpeed;
			pos.y = this.y;
			super.tick();
			
			for (var i:int = 0; i < Main.world.objectManager.objectList.length; i++) 
			{
				var collision:Boolean = this.collider.intersect(Main.world.objectManager.objectList[i].collider);
				if (collision) {
					this.x = PosOut.x;
					this.y = PosOut.y;
					gravityVelocity = 0;
				}else {
					if(this.x < 200){
						//this.x += Main.world.deltaSpeed;
					}
				}
			}
			PosOut = new Point(this.x-Main.world.deltaSpeed, this.y);
			//trace(PosOut);
			
			//stop on ground
			if (this.y > groundHeight) {
				this.y = groundHeight;
				gravityVelocity = 0;
			}
			//apply drag
			if (gravityVelocity != 0) {
				if (gravityVelocity > 0) {
					if(gravityVelocity-drag<0){
						gravityVelocity = 0;
					}else { 
						gravityVelocity -= drag;
					}
				}else {
					if(gravityVelocity+drag>0){
						gravityVelocity = 0;
					}else { 
						gravityVelocity += drag;
					}
				}
			}
			
			//move y
			if (jumpVelocity > 0) {
				jumpVelocity = 0;
			}else { 
				jumpVelocity += gravity;
				//trace(jumpVelocity);
				this.y += jumpVelocity;
				//PosOut.y += jumpVelocity;
			}
			
			this.y += gravityVelocity;
		}
		
		
		public function TriggerAttack():void {
			if(canAttack){
				Attack();
			}else {
				Die();
			}
		}
		
		public function TriggerJump():void {
			if(canJump){
				Jump();
			}else {
				Die();
			}
		}
		
		public function TriggerSwim():void {
			if(canSwim){
				Swim();
			}else {
				Die();
			}
		}
		
		public function Swim():void {
			trace("swim");
		}
		
		private function Attack():void {
			trace("attack");
		}
		
		private function Jump():void  {
			trace("jump");
			jumpVelocity -= 20; 
		}
		
		private function Die():void  {
			trace("die");
		}
		
	}
	*/

}