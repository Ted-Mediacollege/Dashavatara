package myth.entity.enemy 
{
	import starling.display.Sprite;
	import myth.util.ScaleHelper;
	import myth.util.MathHelper;
	/**
	 * ...
	 * @author Kit van de Bunt
	 */
	public class EnemyManager extends Sprite
	{
		public var enemyList:Vector.<EntityEnemyBase> = new Vector.<EntityEnemyBase>;
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
			enemyList.splice(number , 1);
		}
		
		public function move(speed:int):void {
			makeEnemy(EnemyType.Walking_01, 1000*ScaleHelper.scaleY,600*ScaleHelper.scaleY);
			for (var i:int = 0; i < enemyList.length; i++) {
				enemyList[i].x -= speed;
			}
		}
		
		public function checkHit(playerX:Number, playerY:Number):int {
			var damage:int;
			for (var i:int = 0; i < enemyList.length; i++) 
			{
				var dist:Number = MathHelper.dis2(playerX, playerY, enemyList[i].x, enemyList[i].y);
				if (dist < 50) {
					damage += enemyList[i].damage;
					removeEnemy(enemyList[i], i);
				}
			}
			return damage;
		}
	}

}