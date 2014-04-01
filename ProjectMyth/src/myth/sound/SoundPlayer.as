package sound 
{
	import flash.events.Event;
	import flash.media.Sound;
	import flash.media.SoundChannel;
	import flash.media.SoundTransform;
	public class SoundPlayer
	{
		public static var Sound_Shield:String = "gejuich";
		public static var Music_Menu:String = "menu";
		public static var Sound_Fire:String = "fire";
		public static var Music_Game:String = "game";
		public static var Sound_Gejuich:String = "gejuich";
		
		private static var soundList:Vector.<SoundHolder> = new Vector.<SoundHolder>;
		
		[Embed(source="../../lib/sound/shield bash.mp3")]
		private static var ShieldBach_Sound:Class;
		[Embed(source = "../../lib/sound/start menu music.mp3")]
		private static var Menu_Sound:Class;
		[Embed(source = "../../lib/sound/fire loop.mp3")]
		private static var Fire_Sound:Class;
		[Embed(source = "../../lib/sound/background_music_done.mp3")]
		private static var Game_Sound:Class;
		[Embed(source="../../lib/sound/gejuich.mp3")]
		private static var Gejuich_Sound:Class;
		
		private static var musicChannal:SoundChannel = new SoundChannel();
		private static var SFXChannal:SoundChannel = new SoundChannel();
		
		private static var PlayingMusic:String;
		private static var fireChannal:SoundChannel = new SoundChannel();
		
		private static var soundChannal:SoundChannel = new SoundChannel();
		
		private static var fireVolume:Number = 0.2;
		private static var fireBallHit:Boolean = false;
		
		
		public static function initSounds():void 
		{
			soundList[0] = new SoundHolder(Sound_Shield, new ShieldBach_Sound());
			soundList[1] = new SoundHolder(Music_Menu, new Menu_Sound());
			soundList[2] = new SoundHolder(Sound_Fire, new Fire_Sound());
			soundList[3] = new SoundHolder(Music_Game, new Game_Sound);
			soundList[4] = new SoundHolder(Sound_Gejuich, new Gejuich_Sound());
			for (var i:int = 0; i < soundList.length; i++){
				if (soundList[i].name == Sound_Fire) {
					fireChannal = soundList[i]._sound.play();
					setVolume(fireVolume, fireChannal);
				} 
			}
			fireChannal.addEventListener(Event.SOUND_COMPLETE , fireReplay);
		}
		/**
		* plays music in a loop
		* @param use one off the public static strings in the SFX class
		*/
		public static function playMusic(musicName:String):void {
			musicChannal.stop();
			for (var i:int = 0; i < soundList.length; i++) 
			{
				if(soundList[i].name == musicName){
					musicChannal = soundList[i]._sound.play();
					PlayingMusic = soundList[i].name;
					setVolume(0.7, musicChannal);
				}
			}
			musicChannal.addEventListener(Event.SOUND_COMPLETE, soundReplay);
		}
		
		public static function playSound(musicName:String):void {
			for (var i:int = 0; i < soundList.length; i++) 
			{
				if(soundList[i].name == musicName){
					soundChannal = soundList[i]._sound.play();
					setVolume(0.3, soundChannal);
				}
			}
		}
		
		public static function soundReplay(e:Event):void {
			musicChannal.removeEventListener(Event.SOUND_COMPLETE, soundReplay);
			for (var i:int = 0; i < soundList.length; i++) 
			{
				if(soundList[i].name == PlayingMusic){
					musicChannal = soundList[i]._sound.play();
					setVolume(0.7, musicChannal);
				}
			}
			musicChannal.addEventListener(Event.SOUND_COMPLETE, soundReplay);
		}
		
		public static function fireReplay(e:Event):void {
			fireChannal.removeEventListener(Event.SOUND_COMPLETE , fireReplay);
			for (var i:int = 0; i < soundList.length; i++){
				if(soundList[i].name == Sound_Fire){
					fireChannal = soundList[i]._sound.play();
					setVolume(fireVolume, fireChannal);
				} 
			}
			fireChannal.addEventListener(Event.SOUND_COMPLETE , fireReplay);
		}
		
		private static function setVolume(volume:Number , channal:SoundChannel):void {
			var transform:SoundTransform = new SoundTransform(volume);
			channal.soundTransform = transform;
		}
		
		public static function loopSound():void {
			if (fireVolume > 0.2 && !fireBallHit) {
				fireVolume -= 0.01;
				setVolume(fireVolume, fireChannal);
			}else if (fireBallHit) {
				fireVolume += 0.06;
				if (fireVolume > 1) {
					fireBallHit = false;
					setVolume(fireVolume, fireChannal);
				}
			}
		}
		
		public static function FireHitSound():void {
			//if(fireVolume<0.5){
				fireVolume = 1 ;
			//}
			fireBallHit = true;
		}
	}
}