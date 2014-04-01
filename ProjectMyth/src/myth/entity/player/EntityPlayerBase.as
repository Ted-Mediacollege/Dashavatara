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
	import starling.textures.Texture;
	
	public class EntityPlayerBase extends Entity
	{
		//public var collider:RectCollider;
		
		public var art:Sprite;
		public var velX:Number;
		public var velY:Number;
		public var onfeet:Boolean;
		
		public var swimmer:Boolean;
		private var maxBreakSpeed:Number = 5;
		public var Xpos:Number;
		private var playerBody:Body;
		private var playerMass:Number;
		
		private var privatePlayerType:int;
		private var privatePlayerTex:Texture;
		
		public function EntityPlayerBase(_swimmer:Boolean,_XPos:int,_playerType:int,_playerTex:Texture)
		{
			super(100, 180, -50, -180);
			privatePlayerTex = _playerTex;
			privatePlayerType = _playerType;
			art = new Sprite();
			addChild(art);
			
			swimmer = _swimmer;
			Xpos = _XPos;
			playerBody = Main.world.physicsWorld.playerBody;
			playerMass = Main.world.physicsWorld.playerBody.mass;
			
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
			var XposT:Number = Xpos + (speed * 60);
			if (levelComplete) {
				Xpos += speed;
			}
			//trace("Xpos: "+this.x+" velX: "+playerBody.velocity.x+" velX: "+playerBody.velocity.x/60+" timeStep: "+TimeHelper.deltaTime);
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
			//apply drag
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
			//trace(Main.world.physicsWorld.playerBody.velocity.x + " - " + Main.world.deltaSpeed*60);
		}
		
		public function pushBack():void {
			//trace("push "+Main.world.deltaSpeed);
			Main.world.physicsWorld.playerBody.applyImpulse(new Vec2(-Main.world.physicsWorld.playerBody.velocity.x*2*Main.world.physicsWorld.playerBody.mass, -200*Main.world.physicsWorld.playerBody.mass));
		}
		
		public function pushBackRock():void {
			Main.world.physicsWorld.playerBody.applyImpulse(new Vec2(-Main.world.physicsWorld.playerBody.velocity.x*6 *Main.world.physicsWorld.playerBody.mass, -500*Main.world.physicsWorld.playerBody.mass));
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
		
		public function get playerType():int {return privatePlayerType};
		//public function set playerType(type:int):void { privatePlayerType = type; };
		
		public function get playerTexture():Texture {return privatePlayerTex};
		//public function set playerTexture(tex:Texture):void {privatePlayerTex = tex;};
	}
}