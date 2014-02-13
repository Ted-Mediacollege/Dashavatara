package myth.world 
{
	import flash.geom.Point;
	import flash.geom.Rectangle;
	import myth.entity.bullet.EntityBulletBase;
	import myth.entity.bullet.EntityBulletClaw;
	import myth.entity.enemy.EntityEnemyBase;
	import myth.entity.enemy.EnemyType;
	import myth.entity.enemy.EntityEnemyWalking;
	import starling.display.Sprite;
	import myth.util.ScaleHelper;
	import myth.util.MathHelper;
	import myth.entity.bullet.BulletType;
	/**
	 * ...
	 * @author Kit van de Bunt
	 */
	public class WorldEntityManager extends Sprite
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
				enemy = new EntityEnemyWalking();
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
		
		//tick
		public function move(speed:int , dist:Number):void {
			if (data.length > 0) {
				if (data[0][1] < dist) {
					makeEnemy(data[0][0], 1000, data[0][2]);
					data.splice(0, 1);
				}
			}
			//makeEnemy(EnemyType.Walking_01, 1000,600);
			for (var i:int = 0; i < enemyList.length; i++) {
				enemyList[i].x -= speed;
				enemyList[i].tick();
			}
			for (var j:int = 0; j < bulletList.length; j++) {
				bulletList[j].x -= speed;
				bulletList[j].tick();
			}
		}
		
		//tick
		public function checkHit(playerX:Number, playerY:Number):int {
			RemoveBulletExitScreen();
			checkBulletHitEnemy(playerX, playerY);
			var damage:int = checkPlayerEnemyHit(playerX, playerY);
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
		
		private function checkBulletHitEnemy(playerX:Number, playerY:Number):void {
			var i:int;
			var j:int;
			var rectBullet:Rectangle;
			var rectEnemy:Rectangle;
			for (i = 0; i < enemyList.length; i++) {
				for (j = 0; j < bulletList.length; j++) {
					rectBullet = new Rectangle(bulletList[j].x, bulletList[j].y, bulletList[j].width, bulletList[j].height);
					rectEnemy = new Rectangle(enemyList[i].x, enemyList[i].y, enemyList[i].width, enemyList[i].height);
					var hit:Boolean = rectBullet.intersects(rectEnemy);
					if (hit) {
						removeBullet(bulletList[j], j);
						removeEnemy(enemyList[i], i);
						break;
					}
				}
			}
		}
		
		private function checkPlayerEnemyHit(playerX:Number, playerY:Number):int {
			var damage:int;
			for (var i:int = 0; i < enemyList.length; i++) 
			{
				var dist:Number;
				switch(enemyList[i].enemyType) {
				case EnemyType.Flying_01:
						dist = MathHelper.dis2(playerX, playerY, enemyList[i].x, enemyList[i].y);
						if (dist < 50) {
							damage += enemyList[i].damage;
							removeEnemy(enemyList[i], i);
						}
					break;
				case EnemyType.Walking_01:
						dist = MathHelper.dis(playerX,enemyList[i].x);
						if (dist < 50) {
							damage += enemyList[i].damage;
							removeEnemy(enemyList[i], i);
						}
					break;
				}
			}
			return damage;
		}
	}

}