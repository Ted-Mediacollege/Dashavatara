package myth.graphics 
{
	import myth.entity.player.PlayerType;
	import myth.gui.components.GuiButton;
	import starling.textures.TextureAtlas;
	import starling.textures.Texture;
	import starling.utils.AssetManager;
	import flash.filesystem.File;
	import myth.Main;
	import myth.gui.game.GuiLoading;
	import treefortress.spriter.SpriterLoader;
	import treefortress.spriter.SpriterClip;
	
	public class TextureList 
	{
		//textures
		[Embed(source="../../../lib/textures/gui_achtergrond.png")]
		public static var gui_background_textures:Class;
		[Embed(source="../../../lib/textures/player.png")]
		public static var player_textures:Class;
		[Embed(source="../../../lib/textures/backgroundtiles.png")]
		public static var background_textures:Class;
		[Embed(source="../../../lib/textures/background_sky.png")]
		public static var background2_textures:Class;
		[Embed(source="../../../lib/textures/level.png")]
		public static var level_textures:Class;
		[Embed(source="../../../lib/textures/fish.png")]
		public static var fish_textures:Class;
		[Embed(source="../../../lib/textures/RunningEnemy.png")]
		public static var enemyRunning_textures:Class;
		[Embed(source="../../../lib/textures/enemie.png")]
		public static var enemy_textures:Class;
		
		//xml files
		[Embed(source = "../../../lib/textures/gui_achtergrond.xml", mimeType = "application/octet-stream")]
		public static var gui_background_xml:Class;
		[Embed(source="../../../lib/textures/player.xml", mimeType = "application/octet-stream")]
		public static var player_xml:Class;
		[Embed(source="../../../lib/textures/backgroundtiles.xml", mimeType = "application/octet-stream")]
		public static var background_xml:Class;
		[Embed(source="../../../lib/textures/background_sky.xml", mimeType = "application/octet-stream")]
		public static var background2_xml:Class;
		[Embed(source="../../../lib/textures/level.xml", mimeType = "application/octet-stream")]
		public static var level_xml:Class;
		[Embed(source="../../../lib/textures/fish.xml", mimeType = "application/octet-stream")]
		public static var fish_xml:Class;
		[Embed(source="../../../lib/textures/RunningEnemy.xml", mimeType = "application/octet-stream")]
		public static var enemyRunning_xml:Class;
		[Embed(source="../../../lib/textures/enemie.xml", mimeType = "application/octet-stream")]
		public static var enemy_xml:Class;
		
		//texture atlas
		public static var atlas_gui:TextureAtlas;
		public static var atlas_gui_background:TextureAtlas;
		public static var atlas_player:TextureAtlas;
		public static var atlas_background:TextureAtlas;
		public static var atlas_background2:TextureAtlas;
		public static var atlas_level:TextureAtlas;
		public static var atlas_fish:TextureAtlas;
		public static var atlas_enemyRunning:TextureAtlas;
		public static var atlas_enemy:TextureAtlas;
		
		public static var assets:AssetManager;
		public static var spriterLoader:SpriterLoader;
		
		public static var currentWorldType:int = -1;
		public static var currentPlayers:Vector.<PlayerType> = new Vector.<PlayerType>;
		//private static var tileData:Vector.<int>;
		
		public static function preLoad():void
		{
			assets = new AssetManager();
			
			spriterLoader = new SpriterLoader();
			spriterLoader.completed.addOnce(onSpriterLoaded);
			spriterLoader.load(["spriteranims/transformation/transAnim.scml", "spriteranims/player1/animLion.scml", "spriteranims/player4/animSwine.scml"]);

			var appDir:File = File.applicationDirectory;
			assets.enqueue(appDir.resolvePath("tex/background"));
			assets.enqueue(appDir.resolvePath("tex/gui"));
				
			assets.loadQueue(function(ratio:Number):void {
				GuiLoading.progress = ratio;
				if (ratio == 1.0) {
					GuiLoading.ready++;
				}
			});
		}
		
		public static function onSpriterLoaded(loader:SpriterLoader):void 
		{
			GuiLoading.ready++;
		}
		
		public static function load():void
		{
			atlas_gui_background = new TextureAtlas(Texture.fromBitmap(new gui_background_textures()), XML(new gui_background_xml()));
			atlas_player = new TextureAtlas(Texture.fromBitmap(new player_textures()), XML(new player_xml()));
			atlas_background = new TextureAtlas(Texture.fromBitmap(new background_textures()), XML(new background_xml()));
			atlas_background2 = new TextureAtlas(Texture.fromBitmap(new background2_textures()), XML(new background2_xml()));
			atlas_level = new TextureAtlas(Texture.fromBitmap(new level_textures()), XML(new level_xml()));
			atlas_fish = new TextureAtlas(Texture.fromBitmap(new fish_textures()), XML(new fish_xml()));
			atlas_enemyRunning = new TextureAtlas(Texture.fromBitmap(new enemyRunning_textures()), XML(new enemyRunning_xml()));
			atlas_enemy = new TextureAtlas(Texture.fromBitmap(new enemy_textures()), XML(new enemy_xml()));
		}
		
		public static function loadLevelAssets(worldType:int,player1Type:PlayerType,player2Type:PlayerType,player3Type:PlayerType):void
		{
			var load:Boolean = false;
			var appDir:File = File.applicationDirectory;
			
			if (currentWorldType != worldType) {
				load = true;
			}
			trace("currentPlayers L:"+currentPlayers.length)
			for (var i:int = 0; i < 3; i++) 
			{
				if(currentPlayers.length > 0){
					if (currentPlayers[i]==player1Type||currentPlayers[i]==player2Type||currentPlayers[i]==player3Type) {
						
					}else {
						load = true;
						break;
					}
				}
			}
			currentWorldType = worldType;
			currentPlayers[0] = player1Type;
			currentPlayers[1] = player2Type;
			currentPlayers[2] = player3Type;
			
			if (load) {
				//hier moeten alleen de assets voor een level geladen worden
				assets.enqueue(appDir.resolvePath("tex/anim"));
				
				assets.loadQueue(function(ratio:Number):void{
					trace("Loading assets, progress:", ratio);
					if (ratio == 1.0) {
						trace("Loading assets done");
						Main.world.build();
					}
				});
			}else {
				Main.world.build();
				trace("no reload needed");
			}
		}
	}
}