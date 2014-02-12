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
			/*_data = new < Vector.<int> > [ 
			new <int>[ 0, 20, 300 ],
			new <int>[ 0, 200, 400 ],
			new <int>[ 0, 270, 350 ],
			new <int>[ 0, 480, 400 ],
			new <int>[ 0, 1020, 330 ],
			new <int>[ 0, 1200, 430 ],
			new <int>[ 0, 1270, 150 ],
			new <int>[ 0, 1480, 100 ],
			new <int>[ 0, 2020, 240 ],
			new <int>[ 0, 2200, 360 ],
			new <int>[ 0, 2270, 470 ],
			new <int>[ 0, 2480, 360 ],
			new <int>[ 0, 2620, 380 ],
			new <int>[ 0, 2800, 230 ],
			new <int>[ 0, 3270, 240 ],
			new <int>[ 0, 3480, 280 ],
			new <int>[ 0, 3680, 220 ]
			];*/
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