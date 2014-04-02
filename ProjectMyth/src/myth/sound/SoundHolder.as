package myth.sound 
{
	import flash.media.Sound;
	public class SoundHolder 
	{
		public var name:String;
		public var dir:String;
		public var file:String;
		public var extension:String;
		public function SoundHolder(_name:String,_dir:String, _file:String,_extension:String) 
		{
			name = _name;
			dir = _dir;
			file = _file;
			extension = _extension;
		}
		
	}

}