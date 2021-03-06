package myth.world 
{
	import myth.graphics.Display;
	import myth.graphics.LayerID;
	import myth.entity.player.EntityPlayerBase;
	import myth.entity.player.EntityPlayer01v5;
	import myth.entity.player.EntityPlayer03;
	import myth.entity.player.EntityPlayerBoar;
	import myth.Main;
	import nape.geom.Vec2;
	import starling.display.Image;
	import treefortress.spriter.SpriterClip;
	import myth.graphics.AssetList;
	import treefortress.spriter.AnimationSet;
	import myth.entity.player.PlayerType;
	import myth.entity.SpriterClipPool;
	
	public class PlayerHolder 
	{
		public var players:Vector.<EntityPlayerBase> = new Vector.<EntityPlayerBase>;
		
		private var currentPlayer:int = 0;
		
		private var animTransform:SpriterClip;
		private var animTransform2:SpriterClip;
		
		public function PlayerHolder() 
		{
			players[0] = new EntityPlayer01v5(); 
			//players[1] = new EntityPlayer01v2(); 
			players[1] = new EntityPlayer03();
			//players[2] = new EntityPlayer02v2(); 
			players[2] = new EntityPlayerBoar(); 
			 
			Main.world.player = players[0];
			currentPlayer = 0;
			Main.world.physicsWorld.playerBody.userData.graphic = Main.world.player;
			Main.world.physicsWorld.playerBody.velocity = new Vec2(Main.world.speed * 60, 0);
			Display.add(Main.world.player, LayerID.GamePlayer);
			
			////////////
			//animTransform = AssetList.spriterLoader.getSpriterClip("transAnim");
			animTransform = new SpriterClip(new AnimationSet(AssetList.assets.getXml("transAnim")), AssetList.assets.getTextureAtlas("common"));
			//animTransform2 = AssetList.spriterLoader.getSpriterClip("transAnim");
			animTransform2 = new SpriterClip(new AnimationSet(AssetList.assets.getXml("transAnim")), AssetList.assets.getTextureAtlas("common"));
			animTransform.playbackSpeed = 1.5;
			animTransform2.playbackSpeed = 1.5;
			Display.add(animTransform,LayerID.GamePlayerFront);
			Display.add(animTransform2,LayerID.GamePlayerBack);
			Main.world.gameJuggler.add(animTransform);
			Main.world.gameJuggler.add(animTransform2);
			
			animTransform.animationComplete.add(
				function(clip:SpriterClip):void
				{
					animTransform.visible = false;
					animTransform.stop();
					
					animTransform2.visible = false;
					animTransform2.stop();
				}
			);
			
			animTransform.visible = false;
			animTransform2.visible = false;
			//Display.add(transformCircle,LayerID.GamePlayerBack);
			Display.add(animTransform2,LayerID.GamePlayerBack);
		}
		
		public var knockBackClip:SpriterClip;
		public var stoneHit:Boolean = false;
		
		public function addKnockBackClip(playerID:int):void {
			stoneHit = true;
			if (playerID == PlayerType.Boar) {
				knockBackClip = SpriterClipPool.boarClip2;
				knockBackClip.scaleX = 0.8;
				knockBackClip.scaleY = 0.8;
			}else if (playerID == PlayerType.Fluit) {
				knockBackClip = SpriterClipPool.fluitClip2;
			}else if (playerID == PlayerType.Lion) {
				knockBackClip = SpriterClipPool.lionClip2;
				knockBackClip.scaleX = 0.8;
				knockBackClip.scaleY = 0.8;
			}
			Main.world.gameJuggler.add(knockBackClip);
			knockBackClip.x = Main.world.player.x;
			knockBackClip.y = Main.world.player.y;
			knockBackClip.play("knockback");
			Display.add(knockBackClip,LayerID.GameEntity)
		}
		
		public function tick():void {
			if (knockBackClip != null) {
				knockBackClip.x -= 20;
				knockBackClip.y -= 5;
			}
			animTransform.x = Main.world.player.x;
			animTransform.y = Main.world.player.y;
			animTransform2.x = Main.world.player.x;
			animTransform2.y = Main.world.player.y;
		}
		
		public function switchAvatar(id:int):void {
			if(id !=currentPlayer){
				var playerPosX:int = Main.world.player.x;
				var playerPosY:int = Main.world.player.y;
				Main.world.player.switchPlayer();
				Main.world.player.removeFromParent();
				if (id==0) {
					Main.world.player = players[0];
					currentPlayer = 0;
				}else if (id==1) {
					Main.world.player = players[1];
					currentPlayer = 1;
				}else {
					Main.world.player = players[2];
					currentPlayer = 2;
				}
				//trace("switch "+currentPlayer+" "+distance);
				Main.world.player.x = playerPosX;
				Main.world.player.y = playerPosY;
				Display.add(Main.world.player, LayerID.GamePlayer);
				Main.world.physicsWorld.playerBody.userData.graphic = Main.world.player;
				
				animTransform.play("lotusflower");
				animTransform2.play("spinningcircle");
				animTransform.visible = true;
				animTransform2.visible = true;
			}
		}
	}
}