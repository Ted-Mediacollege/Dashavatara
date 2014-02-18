package myth.world 
{
	import flash.geom.Point;
	import flash.geom.Rectangle;
	import myth.entity.bullet.EntityBulletBase;
	import myth.entity.bullet.EntityBulletClaw;
	import myth.entity.enemy.EntityEnemyBase;
	import myth.entity.enemy.EnemyType;
	import myth.entity.enemy.EntityEnemyFlying;
	import myth.entity.enemy.EntityEnemyWalking;
	import myth.entity.player.EntityPlayerBase;
	import starling.display.Sprite;
	import myth.util.ScaleHelper;
	import myth.util.MathHelper;
	import myth.entity.bullet.BulletType;
	import myth.Main;
	/**
	 * ...
	 * @author Kit van de Bunt
	 */
	public class WorldEntityManager extends WorldManagerBase
	{
		private var data:Vector.<Vector.<int>>;
		public var enemyList:Vector.<EntityEnemyBase> = new Vector.<EntityEnemyBase>;
		public var bulletList:Vector.<EntityBulletBase> = new Vector.<EntityBulletBase>;
		
		public function WorldEntityManager(_data:Vector.<Vector.<int>> = null):void {
			data = _data;
		}
		
		public function makeEnemy( type:int,xPos:int,yPos:int) :void
		{
			var enemy : EntityEnemyBase;
			if(type == EnemyType.Walking_01){
				enemy = new EntityEnemyWalking();
			}else if(type == EnemyType.Walking_02){
				enemy = new EntityEnemyWalking();
			}else if(type == EnemyType.Flying_01){
				enemy = new EntityEnemyFlying();
			}
			enemy.x = xPos;
			enemy.y = yPos;
			enemyList.push(enemy);
			addChild(enemy);
		}
		
		private function removeEnemy(e:EntityEnemyBase, number:int):void {
			removeChild(enemyList[number]);
			enemyList.splice(number , 1);
		}
		
		public function makeBullet( type :Number, xPos:Number,yPos:Number, xDest:Number, yDest:Number) :void
		{
			var angle:Number;
			angle = MathHelper.pointToRadian(xPos, xDest, yPos, yDest);
			var newBullet : EntityBulletBase;
			if(type == BulletType.Claw){
				newBullet = new EntityBulletClaw();
			}else if(type == BulletType.Arrow){
				newBullet = new EntityBulletClaw();
			}
			newBullet.x = xPos;
			newBullet.y = yPos;
			newBullet.rotation = angle;
			bulletList.push(newBullet);
			addChild(newBullet);
		}
		
		private function removeBullet(b:EntityBulletBase, number:int):void {
			removeChild(bulletList[number]);
			bulletList.splice(number , 1);
		}
		
		override public function tick(speed:int , dist:Number):void {
			//spawn enemies
			if (data.length > 0) {
				while(data[0][1] < dist) {
					makeEnemy(data[0][0], 1400, data[0][2]);
					data.splice(0, 1);
					if (data.length < 1) {
						break;
					}
				}
			}
			//move enemies at speed off level
			for (var i:int = 0; i < enemyList.length; i++) {
				enemyList[i].x -= speed;
				enemyList[i].tick();
			}
			for (var j:int = 0; j < bulletList.length; j++) {
				bulletList[j].x -= speed;
				bulletList[j].tick();
			}
			
			checkHit();
		}
		
		//tick
		public function checkHit():int {
			RemoveBulletExitScreen();
			checkBulletHitEnemy();
			var damage:int = checkPlayerEnemyHit();
			return damage;
		}
		
		private function RemoveBulletExitScreen():void {
			var j:int;
			var rectBullet:Rectangle;
			var rectScreen:Rectangle = new Rectangle(-200, -200, ScaleHelper.screenX+400, ScaleHelper.screenY+400);
			for (j = 0; j < bulletList.length; j++) {
				rectBullet = new Rectangle(bulletList[j].x, bulletList[j].y, bulletList[j].width, bulletList[j].height);
				var onScreen:Boolean = rectBullet.intersects(rectScreen);
				if (!onScreen) {
					removeBullet(bulletList[j], j);
					break;
				}
			}
		}
		
		private function checkBulletHitEnemy():void {
			var i:int;
			var j:int;
			for (i = 0; i < enemyList.length; i++) {
				for (j = 0; j < bulletList.length; j++) {
					var hit:Boolean = enemyList[i].collider.intersect(bulletList[j].collider);
					if (hit) {
						removeBullet(bulletList[j], j);
						removeEnemy(enemyList[i], i);
						break;
					}
				}
			}
		}
		
		private function checkPlayerEnemyHit():int {
			var i:int;
			var player:EntityPlayerBase = Main.world.player;
			var damage:int;
			
			for (i = 0; i < enemyList.length; i++) 
			{
				var hit:Boolean = enemyList[i].collider.intersect(player.collider);
				if (hit) {
					var dist:Number;
					switch(enemyList[i].enemyType) {
					case EnemyType.Flying_01:
							damage += enemyList[i].damage;
							removeEnemy(enemyList[i], i);
						break;
					case EnemyType.Walking_01:
							damage += enemyList[i].damage;
							removeEnemy(enemyList[i], i);
						break;
					}
				}
			}
			return damage;
		}
	}

}