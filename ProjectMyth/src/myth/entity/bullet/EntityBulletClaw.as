package myth.entity.bullet 
{
	import starling.display.Image;
	import myth.graphics.AssetList;
	import myth.util.MathHelper;
	import myth.util.TimeHelper;
	import starling.textures.Texture;
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
			//image = new Image(AssetList.atlas_player.getTexture("bullet_1"));
			image = new Image(Texture.fromColor(20,20));
			image.pivotX = image.width / 2;
			image.pivotY = image.height/2;
			image.rotation = -Math.PI/2;
			artLayer.addChild(image);
		}
		
		override public function tick():void {
			super.tick();
			//trace(MathHelper.RadianToDirection(this.rotation, speed).x);
			this.x += MathHelper.RadianToDirection(this.rotation,speed).x*TimeHelper.deltaTimeScale;
			this.y += MathHelper.RadianToDirection(this.rotation,speed).y*TimeHelper.deltaTimeScale;
		}
	}

}