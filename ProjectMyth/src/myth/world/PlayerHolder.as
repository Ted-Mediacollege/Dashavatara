package myth.world 
{
	import myth.graphics.Display;
	import myth.graphics.LayerID;
	import myth.entity.player.EntityPlayerBase;
	import myth.entity.player.EntityPlayer01v5;
	import myth.entity.player.EntityPlayer03;
	import myth.entity.player.EntityPlayerBoar;
	import myth.Main;
	import starling.display.Image;
	import treefortress.spriter.SpriterClip;
	import myth.graphics.TextureList;
	
	public class PlayerHolder 
	{
		public var players:Vector.<EntityPlayerBase> = new Vector.<EntityPlayerBase>;
		
		private var currentPlayer:int = 1;
		
		private var animTransform:SpriterClip;
		private var animTransform2:SpriterClip;
		private var transformCircle:Image;
		
		public function PlayerHolder() 
		{
			players[0] = new EntityPlayer03(); 
			//players[1] = new EntityPlayer01v2(); 
			players[1] = new EntityPlayer01v5();
			//players[2] = new EntityPlayer02v2(); 
			players[2] = new EntityPlayerBoar(); 
			 
			Main.world.player = players[1];
			currentPlayer = 1;
			Main.world.physicsWorld.playerBody.userData.graphic = Main.world.player;
			Display.add(Main.world.player, LayerID.GamePlayer);
			
			////////////
			animTransform = TextureList.spriterLoader.getSpriterClip("transAnim");
			animTransform2 = TextureList.spriterLoader.getSpriterClip("transAnim");
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
					transformCircle.visible = false;
					
					animTransform2.visible = false;
					animTransform2.stop();
				}
			);
			
			transformCircle = new Image(TextureList.assets.getTexture("common_tadaa"));
			transformCircle.pivotX = 102;
			transformCircle.pivotY = 100;
			
			animTransform.visible = false;
			animTransform2.visible = false;
			transformCircle.visible = false;
			//Display.add(transformCircle,LayerID.GamePlayerBack);
			Display.add(animTransform2,LayerID.GamePlayerBack);
		}
		
		public function tick():void {
			animTransform.x = Main.world.player.x;
			animTransform.y = Main.world.player.y;
			animTransform2.x = Main.world.player.x;
			animTransform2.y = Main.world.player.y;
			transformCircle.x = Main.world.player.x;
			transformCircle.y = Main.world.player.y - 90;
			transformCircle.rotation += 0.1;
		}
		
		public function switchAvatar(id:int):void {
			if(id !=currentPlayer){
				var playerPosX:int = Main.world.player.x;
				var playerPosY:int = Main.world.player.y;
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
				transformCircle.visible = true;
			}
		}
	}
}