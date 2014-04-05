package myth.graphics 
{
	import myth.entity.player.PlayerType;
	import myth.gui.components.GuiButton;
	import myth.sound.SoundHolder;
	import starling.extensions.SoundManager;
	import starling.textures.TextureAtlas;
	import starling.textures.Texture;
	import starling.utils.AssetManager;
	import flash.filesystem.File;
	import myth.Main;
	import myth.gui.game.GuiLoading;
	import treefortress.spriter.SpriterLoader;
	import treefortress.spriter.SpriterClip;
	import myth.lang.Lang;
	import myth.data.Theme;
	
	public class AssetList 
	{
		private static var appDir:File;
		//textures
		//[Embed(source="../../../lib/textures/player.png")]
		//public static var player_textures:Class;
		//[Embed(source="../../../lib/textures/fish.png")]
		//public static var fish_textures:Class;
		
		//xml files
		//[Embed(source="../../../lib/textures/player.xml", mimeType = "application/octet-stream")]
		//public static var player_xml:Class;
		//[Embed(source="../../../lib/textures/fish.xml", mimeType = "application/octet-stream")]
		//public static var fish_xml:Class;
		
		//texture atlas
		//public static var atlas_player:TextureAtlas;
		//public static var atlas_fish:TextureAtlas;
		
		//font
		[Embed(source="../../../lib/font/Connie-Regular.ttf", embedAsCFF="false", fontFamily="GameFont")]
		private static const gameFont:Class;
		
		//texture loaders
		public static var assets:AssetManager;
		public static var spriterLoader:SpriterLoader;
		
		private static var currentWorldType:int = -1;
		private static var currentPlayers:Vector.<int> = new Vector.<int>;
		//private static var tileData:Vector.<int>;
		
		//sound
		public static var soundCommon:SoundManager;
		public static var soundLevel:SoundManager;
		
		private static var commonList:Vector.<SoundHolder>;
		private static var thema1List:Vector.<SoundHolder>;
		private static var thema2List:Vector.<SoundHolder>;
		private static var thema3List:Vector.<SoundHolder>;
		private static var i:int;
		
		public static function initSound():void {
			commonList = new Vector.<SoundHolder>();
			thema1List = new Vector.<SoundHolder>();
			thema2List = new Vector.<SoundHolder>();
			thema3List = new Vector.<SoundHolder>();
			//common sounds
			commonList[0] =	new SoundHolder("button"			, "sound/common/", "button1" 							, ".mp3");
			commonList[1] =	new SoundHolder("jump"				, "sound/common/", "jump12 -" 							, ".mp3");
			commonList[2] =	new SoundHolder("enemyFlyHit"		, "sound/common/", "geluid-eerste-pijn-vliegende -" 	, ".mp3");
			commonList[3] =	new SoundHolder("enemyWalkLaugh"	, "sound/common/", "geluid-lach-lopende-enemie" 		, ".mp3");
			commonList[4] =	new SoundHolder("playerHitFluit"	, "sound/common/", "geluid-pijn-blokfluitman" 			, ".mp3");
			commonList[5] =	new SoundHolder("playerHitLion"		, "sound/common/", "geluid-pijn-Leeuw" 					, ".mp3");
			commonList[6] =	new SoundHolder("playerHitBoar"		, "sound/common/", "geluid-pijn-zwijn" 					, ".mp3");
			commonList[7] =	new SoundHolder("winSound"			, "sound/common/", "Winning_sfx" 						, ".mp3");
			
			//thema1 sounds
			thema1List[0] = new SoundHolder("levelMusic"		, "sound/thema1/", "hemel_level_muziek"					, ".mp3");
			//thema2 sounds
			thema2List[0] = new SoundHolder("levelMusic"		, "sound/thema2/", "aarde_level_muziek"					, ".mp3");
			//thema3 sounds
			thema3List[0] = new SoundHolder("levelMusic"		, "sound/thema3/", "hel_level_muziek"					, ".mp3");
			//enqueue common sound
			for (var i:int = 0; i < commonList.length; i++) {
				assets.enqueue(appDir.resolvePath(commonList[i].dir+commonList[i].file+commonList[i].extension));
			}
		}
		
		public static function preLoad():void
		{
			appDir = File.applicationDirectory;
			assets = new AssetManager();
			//assets.verbose = true;
			//load spriter animations
			spriterLoader = new SpriterLoader();
			spriterLoader.completed.addOnce(onSpriterLoaded);
			spriterLoader.load([
				"spriteranims/transformation/transAnim.scml", 
				"spriteranims/player1/animLion.scml", 
				"spriteranims/player2/animFlute.scml", 
				"spriteranims/player4/animSwine.scml", 
				"spriteranims/enemydeath/enemydeaths.scml"
			]);
			
			//set path common texture
			assets.enqueue(appDir.resolvePath("tex/background"));
			assets.enqueue(appDir.resolvePath("tex/gui"));
			assets.enqueue(appDir.resolvePath("tex/editor"));
			assets.enqueue(appDir.resolvePath("lang"));
			assets.enqueue(appDir.resolvePath("mapData"));
			assets.enqueue(appDir.resolvePath("tex/map"));
			assets.enqueue(appDir.resolvePath("tex/anim"));
			assets.enqueue(appDir.resolvePath("tex/anim"));
			assets.enqueue(appDir.resolvePath("tex/tutorial"));
			initSound();
			
			//load common assets	
			assets.loadQueue(function(ratio:Number):void {
				GuiLoading.progress = ratio;
				if (ratio == 1.0) {
					Lang.init();
					GuiLoading.ready++;
					//init common sound manager
					soundCommon = new SoundManager();
					for (var i:int = 0; i < commonList.length; i++) {
						soundCommon.addSound(commonList[i].name, assets.getSound(commonList[i].file) );
					}
				}
			});
		}
		
		public static function onSpriterLoaded(loader:SpriterLoader):void 
		{
			GuiLoading.ready++;
		}
		
		public static function load():void
		{
			//atlas_player = new TextureAtlas(Texture.fromBitmap(new player_textures()), XML(new player_xml()));
			//atlas_fish = new TextureAtlas(Texture.fromBitmap(new fish_textures()), XML(new fish_xml()));
			//atlas_enemyRunning = new TextureAtlas(Texture.fromBitmap(new enemyRunning_textures()), XML(new enemyRunning_xml()));
			//atlas_enemy = new TextureAtlas(Texture.fromBitmap(new enemy_textures()), XML(new enemy_xml()));
		}
		
		public static function loadLevelAssets(worldType:int,player1Type:int,player2Type:int,player3Type:int):void
		{
			var load:Boolean = false;
			
			if (currentWorldType != worldType) {
				load = true;
			}
			//trace("currentPlayers L:"+currentPlayers.length)
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
			
			
			if (load) {
				//unload unneaded assets
				unloadCurrentSounds(currentWorldType);
				//hier moeten alleen de assets voor een level geladen worden
				//assets.enqueue(appDir.resolvePath("tex/anim"));
				enQueueLevel(worldType);
				assets.verbose = true;
				assets.loadQueue(function(ratio:Number):void{
					//trace("Loading assets, progress:", ratio);
					if (ratio == 1.0) {
						trace("Loading assets done");
						soundLevel = new SoundManager();
						addLevelAssets(worldType);
						Main.world.build();
					}
				});
			}else {
				Main.world.build();
				trace("no reload needed");
			}
			
			currentWorldType = worldType;
			currentPlayers[0] = player1Type;
			currentPlayers[1] = player2Type;
			currentPlayers[2] = player3Type;
		}
		
		private static function addLevelAssets(thema:int):void {
			if(thema==Theme.SKY){
				for (i = 0; i < thema1List.length; i++) {
					soundLevel.addSound(thema1List[i].name, assets.getSound(thema1List[i].file) );
				}
			}else if(thema==Theme.EARTH){
				for (i = 0; i < thema2List.length; i++) {
					soundLevel.addSound(thema2List[i].name, assets.getSound(thema2List[i].file) );
				}
			}else if(thema==Theme.HELL){
				for (i = 0; i < thema3List.length; i++) {
					soundLevel.addSound(thema3List[i].name, assets.getSound(thema3List[i].file) );
				}
			}
		}
		
		private static function unloadCurrentSounds(current:int):void {
			if(current==Theme.SKY){
				for (i = 0; i < thema1List.length; i++) {
					assets.removeSound(thema1List[i].name);
				}
			}else if(current==Theme.EARTH){
				for (i = 0; i < thema2List.length; i++) {
					assets.removeSound(thema2List[i].name);
				}
			}else if(current==Theme.HELL){
				for (i = 0; i < thema3List.length; i++) {
					assets.removeSound(thema3List[i].name);
				}
			}
		}
		private static function enQueueLevel(thema:int):void {
			soundLevel = new SoundManager();
			if(thema==Theme.SKY){
				for (i = 0; i < thema1List.length; i++) {
					assets.enqueue(appDir.resolvePath(thema1List[i].dir+thema1List[i].file+thema1List[i].extension));
				}
			}else if(thema==Theme.EARTH){
				for (i = 0; i < thema2List.length; i++) {
					assets.enqueue(appDir.resolvePath(thema2List[i].dir+thema2List[i].file+thema2List[i].extension));
				}
			}else if(thema==Theme.HELL){
				for (i = 0; i < thema3List.length; i++) {
					assets.enqueue(appDir.resolvePath(thema3List[i].dir+thema3List[i].file+thema3List[i].extension));
				}
			}
		}
		
	}
}