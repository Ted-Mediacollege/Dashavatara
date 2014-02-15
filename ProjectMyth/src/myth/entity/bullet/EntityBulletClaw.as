package myth.entity.bullet 
{
	import starling.display.Image;
	import myth.graphics.TextureList;
	import myth.util.MathHelper;
	import myth.util.TimeHelper;
	/**
	 * ...
	 * @author Kit van de Bunt
	 */
	public class EntityBulletClaw extends EntityBulletBase
	{
		public var image:Image;
		public function EntityBulletClaw() 
		{
			super(25);
			image = new Image(TextureList.atlas_player.getTexture("bullet_1"));
			addChild(image);
		}
		
		override public function tick():void {
			//trace(MathHelper.RadianToDirection(this.rotation, speed).x);
			this.x += MathHelper.RadianToDirection(this.rotation,speed).x*TimeHelper.deltaTimeScale;
			this.y += MathHelper.RadianToDirection(this.rotation,speed).y*TimeHelper.deltaTimeScale;
		}
	}

}