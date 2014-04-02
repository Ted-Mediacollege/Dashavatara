package myth.sound 
{
	import flash.events.Event;
	import flash.filesystem.File;
	import flash.media.Sound;
	import flash.media.SoundChannel;
	import flash.media.SoundTransform;
	import myth.data.Theme;
	import myth.sound.SoundHolder;
	import starling.extensions.SoundManager;
	import starling.utils.AssetManager;
	
	public class SoundPlayer
	{
		public static var assets:AssetManager;
		public static var common:SoundManager;
		public static var managerLevel:SoundManager;
		public static var currentThema:int = -1;
		
		public static var commonList:Vector.<SoundHolder>;
		public static var thema1List:Vector.<SoundHolder>;
		public static var thema2List:Vector.<SoundHolder>;
		public static var thema3List:Vector.<SoundHolder>;
		
		public static function init():void {
			commonList = new Vector.<SoundHolder>();
			commonList[0] =	new SoundHolder("button"			, "sound/common/", "jump17" 							, ".mp3");
			commonList[1] =	new SoundHolder("jump"				, "sound/common/", "jump12 -" 						, ".wav");
			commonList[2] =	new SoundHolder("enemyFlyHit"		, "sound/common/", "geluid-eerste-pijn-vliegende -" 	, ".mp3");
			commonList[3] =	new SoundHolder("EnemyWalkLaugh"	, "sound/common/", "geluid-lach-lopende-enemie" 		, ".mp3");
			
			//assets.addSound("
			//assets.removeSound(
			loadCommonSound();
		}
		
		private static function loadCommonSound():void {
			var appDir:File = File.applicationDirectory;
			assets = new AssetManager();
			assets.verbose = true;
			for (var i:int = 0; i < commonList.length; i++) {
				assets.enqueue(appDir.resolvePath(commonList[i].dir+commonList[i].file+commonList[i].extension));
			}
			setupCommonSound();
		}
		
		private static function setupCommonSound():void {
			assets.loadQueue(function(ratio:Number):void {
				if (ratio == 1.0) {
					common = new SoundManager();
					for (var i:int = 0; i < commonList.length; i++) {
						trace(commonList[i].name);
						common.addSound(commonList[i].name, assets.getSound(commonList[i].file) );
					}
				}
			});
		}
		
		public static function initLevel(thema:int):void {
			if (thema != currentThema) {
				currentThema = thema;
				managerLevel = new SoundManager();
				if(thema==Theme.SKY){
					
				}else if(thema==Theme.EARTH){
					
				}else if(thema==Theme.HELL){
					
				}
			}
		}
		
	}
}