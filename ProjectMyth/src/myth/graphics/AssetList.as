package myth.graphics 
{
	import myth.entity.player.PlayerType;
	import myth.gui.components.GuiButton;
	import myth.asset.Asset;
	import myth.gui.game.GuiEditor;
	import starling.extensions.SoundManager;
	import starling.textures.TextureAtlas;
	import starling.textures.Texture;
	import starling.utils.AssetManager;
	import flash.filesystem.File;
	import myth.Main;
	import myth.gui.game.GuiLoading;
	import treefortress.spriter.SpriterLoader;
	import treefortress.spriter.SpriterClip;
	import treefortress.spriter.AnimationSet;
	import myth.lang.Lang;
	import myth.data.Theme;
	import myth.entity.SpriterClipPool;
	
	public class AssetList 
	{
		private static var appDir:File;
		
		//font
		[Embed(source="../../../lib/font/Connie-Regular.ttf", embedAsCFF="false", fontFamily="GameFont")]
		private static const gameFont:Class;
		
		//texture loaders
		public static var assets:AssetManager;
		public static var spriterLoader:SpriterLoader;
		
		private static var currentWorldType:int = -1;
		//private static var tileData:Vector.<int>;
		
		//sound
		public static var soundCommon:SoundManager;
		public static var soundLevel:SoundManager;
		
		private static var commonSoundList:Vector.<Asset>;
		private static var soundList1:Vector.<Asset>;
		private static var soundList2:Vector.<Asset>;
		private static var soundList3:Vector.<Asset>;
		
		private static var texList1:Vector.<Asset>;
		private static var texList2:Vector.<Asset>;
		private static var texList3:Vector.<Asset>;
		private static var i:int;
		private static var j:int;
		
		public static var clipEnemyExplode:SpriterClip;
		public static var animationSet:AnimationSet;
		
		public static function initTextures():void {
			texList1 = new Vector.<Asset>();
			texList2 = new Vector.<Asset>();
			texList3 = new Vector.<Asset>();
			//thema2 textures
			texList1[0] = new Asset("sky_spritesheet"		, "tex/background/", "sky_spritesheet"			, ".atf");
			texList1[1] = new Asset("sky_spritesheet"		, "tex/background/", "sky_spritesheet"			, ".xml");
			//thema2 textures
			texList2[0] = new Asset("earth_spritesheet"		, "tex/background/", "earth_spritesheet"		, ".atf");
			texList2[1] = new Asset("earth_spritesheet"		, "tex/background/", "earth_spritesheet"		, ".xml");
			//thema3 textures
			texList3[0] = new Asset("hell_spritesheet"		, "tex/background/", "hell_spritesheet"			, ".atf");
			texList3[1] = new Asset("hell_spritesheet"		, "tex/background/", "hell_spritesheet"			, ".xml");
		}
		
		public static function initSound():void {
			commonSoundList = new Vector.<Asset>();
			soundList1 = new Vector.<Asset>();
			soundList2 = new Vector.<Asset>();
			soundList3 = new Vector.<Asset>();
			//common sounds
			commonSoundList[0] =	new Asset("button"				, "sound/common/", "button1" 				, ".mp3");
			commonSoundList[1] =	new Asset("jump"				, "sound/common/", "jump12 -" 				, ".mp3");
			commonSoundList[2] =	new Asset("enemyFlyHit"			, "sound/common/", "enemy_fly_hit" 			, ".mp3");
			commonSoundList[3] =	new Asset("enemyFlyHit2"		, "sound/common/", "enemy_fly_hit2" 		, ".mp3");
			commonSoundList[4] =	new Asset("enemyFlySpawn"		, "sound/common/", "enemy_fly_Spawn" 		, ".mp3");
			commonSoundList[5] =	new Asset("enemyWalkHit"		, "sound/common/", "enemy_walk_hit" 		, ".mp3");
			commonSoundList[6] =	new Asset("enemyWalkSpawn"		, "sound/common/", "enemy_walk_spawn" 		, ".mp3");
			commonSoundList[7] =	new Asset("enemyWalkSpawn2"		, "sound/common/", "enemy_walk_spawn2" 		, ".mp3");
			
			commonSoundList[8] =	new Asset("playerFluitHit"		, "sound/common/", "player_fluit_hit" 		, ".mp3");
			commonSoundList[9] =	new Asset("playerLionHit"		, "sound/common/", "player_boar_hit" 		, ".mp3");
			commonSoundList[10] =	new Asset("playerBoarHit"		, "sound/common/", "player_lion_hit" 		, ".mp3");
			commonSoundList[11] =	new Asset("winSound"			, "sound/common/", "Winning_sfx" 			, ".mp3");
			
			//thema1 sounds
			soundList1[0] = new Asset("levelMusic"		, "sound/thema1/", "hemel_level_muziek"					, ".mp3");
			//thema2 sounds
			soundList2[0] = new Asset("levelMusic"		, "sound/thema2/", "aarde_level_muziek"					, ".mp3");
			//thema3 sounds
			soundList3[0] = new Asset("levelMusic"		, "sound/thema3/", "hel_level_muziek"					, ".mp3");
			//enqueue common sound
			for (var i:int = 0; i < commonSoundList.length; i++) {
				assets.enqueue(appDir.resolvePath(commonSoundList[i].dir+commonSoundList[i].file+commonSoundList[i].extension));
			}
		}
		
		public static function preLoad(thema:int):void
		{
			appDir = File.applicationDirectory;
			assets = new AssetManager();
			assets.verbose = true;
			initSound();
			initTextures();
			switch(thema)
			{
				case Theme.SKY:  break;
				case Theme.EARTH:  break;
				case Theme.HELL:  break;
			}
			loadLevelAssets(thema,true);
			
			GuiLoading.ready++;
			
			//set path common texture
			assets.enqueue(appDir.resolvePath("tex/common"));
			assets.enqueue(appDir.resolvePath("tex/gui"));
			assets.enqueue(appDir.resolvePath("tex/editor"));
			assets.enqueue(appDir.resolvePath("lang"));
			assets.enqueue(appDir.resolvePath("mapData"));
			assets.enqueue(appDir.resolvePath("tex/map"));
			assets.enqueue(appDir.resolvePath("tex/tutorial"));
			
			
			//load common assets	
			assets.loadQueue(function(ratio:Number):void {
				GuiLoading.progress = ratio;
				if (ratio == 1.0) {
					Lang.init();
					GuiLoading.ready++;
					//init common sound manager
					soundCommon = new SoundManager();
					for (var i:int = 0; i < commonSoundList.length; i++) {
						soundCommon.addSound(commonSoundList[i].name, assets.getSound(commonSoundList[i].file) );
					}
					SpriterClipPool.init();
					addLevelAssets(thema);
				}
			});
		}
		
		public static function loadLevelAssets(worldType:int, onlyQueue:Boolean=false,calFrom:String = "game", from:Object =null):void
		{
			trace("----------------------[load]----------------------------");
			var load:Boolean = false;
			if (currentWorldType != worldType) {
				load = true;
			}
			trace("[AssetList]: "+load +" theme: "+worldType);
			
			if (load) {
				//unload unneaded assets
				unloadCurrentSounds(currentWorldType);
				unloadCurrentTextures(currentWorldType);
				//hier moeten alleen de assets voor een level geladen worden
				//assets.enqueue(appDir.resolvePath("tex/anim"));
				enQueueLevel(worldType);
				//assets.verbose = true;
				if(!onlyQueue){
					assets.loadQueue(function(ratio:Number):void{
						//trace("Loading assets, progress:", ratio);
						if (ratio == 1.0) {
							trace("Loading assets done");
							soundLevel = new SoundManager();
							addLevelAssets(worldType);
							if(calFrom == "game"){
								Main.world.build();
							}else if (calFrom == "editor") {
								var guiEditor:GuiEditor = Main.gui as GuiEditor;
								guiEditor.build(calFrom);
							}else {
								var guiEditor:GuiEditor = Main.gui as GuiEditor;
								guiEditor.build(calFrom);
							}
						}
					});
				}
			}else {
				if(calFrom == "game"){
					Main.world.build();
				}else if (calFrom == "guiEditor") {
					var guiEditor:GuiEditor = Main.gui as GuiEditor;
					guiEditor.build(calFrom);
				}else {
					var guiEditor:GuiEditor = Main.gui as GuiEditor;
					guiEditor.build(calFrom);
				}
				trace("no reload needed");
			}
			
			Theme.MENU_THEME = worldType;
			currentWorldType = worldType;
		}
		
		private static function addLevelAssets(thema:int):void {
			if(thema==Theme.SKY){
				for (i = 0; i < soundList1.length; i++) {
					soundLevel.addSound(soundList1[i].name, assets.getSound(soundList1[i].file) );
				}
			}else if(thema==Theme.EARTH){
				for (i = 0; i < soundList2.length; i++) {
					soundLevel.addSound(soundList2[i].name, assets.getSound(soundList2[i].file) );
				}
			}else if(thema==Theme.HELL){
				for (i = 0; i < soundList3.length; i++) {
					soundLevel.addSound(soundList3[i].name, assets.getSound(soundList3[i].file) );
				}
			}
		}
		
		private static function unloadCurrentSounds(current:int):void {
			if(current==Theme.SKY){
				for (i = 0; i < soundList1.length; i++) {
					assets.removeSound(soundList1[i].name);
				}
			}else if(current==Theme.EARTH){
				for (i = 0; i < soundList2.length; i++) {
					assets.removeSound(soundList2[i].name);
				}
			}else if(current==Theme.HELL){
				for (i = 0; i < soundList3.length; i++) {
					assets.removeSound(soundList3[i].name);
				}
			}
		}
		
		private static function unloadCurrentTextures(current:int):void {
			if(current==Theme.SKY){
				for (i = 0; i < texList1.length; i++) {
					assets.removeTextureAtlas(texList1[i].name);
				}
			}else if(current==Theme.EARTH){
				for (i = 0; i < texList2.length; i++) {
					assets.removeTextureAtlas(texList2[i].name);
				}
			}else if(current==Theme.HELL){
				for (i = 0; i < texList3.length; i++) {
					assets.removeTextureAtlas(texList3[i].name);
				}
			}
		}
		
		private static function enQueueLevel(thema:int):void {
			soundLevel = new SoundManager();
			if (thema == Theme.SKY) {
				trace("enqueue sky")
				for (i = 0; i < soundList1.length; i++) {
					trace(appDir.resolvePath(soundList1[i].dir+soundList1[i].file+soundList1[i].extension).url);
					assets.enqueue(appDir.resolvePath(soundList1[i].dir+soundList1[i].file+soundList1[i].extension));
				}
				for (i = 0; i < texList1.length; i++) {
					assets.enqueue(appDir.resolvePath(texList1[i].dir+texList1[i].file+texList1[i].extension));
				}
			}else if(thema==Theme.EARTH){
				for (i = 0; i < soundList2.length; i++) {
					assets.enqueue(appDir.resolvePath(soundList2[i].dir+soundList2[i].file+soundList2[i].extension));
				}
				for (i = 0; i < texList2.length; i++) {
					assets.enqueue(appDir.resolvePath(texList2[i].dir+texList2[i].file+texList2[i].extension));
				}
			}else if(thema==Theme.HELL){
				for (i = 0; i < soundList3.length; i++) {
					assets.enqueue(appDir.resolvePath(soundList3[i].dir+soundList3[i].file+soundList3[i].extension));
				}
				for (i = 0; i < texList3.length; i++) {
					assets.enqueue(appDir.resolvePath(texList3[i].dir+texList3[i].file+texList3[i].extension));
				}
			}
		}
		
	}
}