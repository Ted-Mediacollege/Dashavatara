package myth.world 
{
	import myth.entity.enemy.EntityEnemyBase;
	import myth.entity.enemy.EnemyType;
	import myth.entity.enemy.EntityEnemyWalking;
	import starling.display.Sprite;
	import myth.util.ScaleHelper;
	import myth.util.MathHelper;
	/**
	 * ...
	 * @author Kit van de Bunt
	 */
	public class WorldEntityManager extends Sprite
	{
		private var data:Vector.<Vector.<int>>;
		public var enemyList:Vector.<EntityEnemyBase> = new Vector.<EntityEnemyBase>;
		
		public function WorldEntityManager(_data:Vector.<Vector.<int>> = null):void {
			data = _data;
		}
		
		public function makeEnemy( type :int, xPos:int,yPos:int) :void
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
			addToList(enemy);
			addChild(enemy);
		}
		
		private function addToList(e:EntityEnemyBase):void {
			enemyList.push(e);
		}
		
		private function removeEnemy(e:EntityEnemyBase, number:int):void {
			removeChild(enemyList[number]);
			enemyList.splice(number , 1);
		}
		
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
			}
		}
		
		public function checkHit(playerX:Number, playerY:Number):int {
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