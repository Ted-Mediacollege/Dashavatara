package myth.entity 
{
	import treefortress.spriter.AnimationSet;
	import treefortress.spriter.SpriterClip;
	import myth.graphics.AssetList;
	public class SpriterClipPool 
	{
		private static var clipList:Vector.<SpriterClipHolder>;
		public static var lionClip:SpriterClip;
		public static var fluitClip:SpriterClip;
		public static var boarClip:SpriterClip;
		public static var lionClip2:SpriterClip;
		public static var fluitClip2:SpriterClip;
		public static var boarClip2:SpriterClip;
		
		
		private static var i:int;
		public static function init():void 
		{
			clipList = new Vector.<SpriterClipHolder>;
			clipList[0] = new SpriterClipHolder(new SpriterClip(new AnimationSet(AssetList.assets.getXml("enemydeaths")), AssetList.assets.getTextureAtlas("common")));
			clipList[1] = new SpriterClipHolder(new SpriterClip(new AnimationSet(AssetList.assets.getXml("enemydeaths")), AssetList.assets.getTextureAtlas("common")));
			clipList[2] = new SpriterClipHolder(new SpriterClip(new AnimationSet(AssetList.assets.getXml("enemydeaths")), AssetList.assets.getTextureAtlas("common")));
			clipList[3] = new SpriterClipHolder(new SpriterClip(new AnimationSet(AssetList.assets.getXml("enemydeaths")), AssetList.assets.getTextureAtlas("common")));
			clipList[4] = new SpriterClipHolder(new SpriterClip(new AnimationSet(AssetList.assets.getXml("enemydeaths")), AssetList.assets.getTextureAtlas("common")));
			clipList[5] = new SpriterClipHolder(new SpriterClip(new AnimationSet(AssetList.assets.getXml("enemydeaths")), AssetList.assets.getTextureAtlas("common")));
			clipList[6] = new SpriterClipHolder(new SpriterClip(new AnimationSet(AssetList.assets.getXml("enemydeaths")), AssetList.assets.getTextureAtlas("common")));
			clipList[7] = new SpriterClipHolder(new SpriterClip(new AnimationSet(AssetList.assets.getXml("enemydeaths")), AssetList.assets.getTextureAtlas("common")));
			clipList[8] = new SpriterClipHolder(new SpriterClip(new AnimationSet(AssetList.assets.getXml("enemydeaths")), AssetList.assets.getTextureAtlas("common")));
			clipList[9] = new SpriterClipHolder(new SpriterClip(new AnimationSet(AssetList.assets.getXml("enemydeaths")), AssetList.assets.getTextureAtlas("common")));
			clipList[10] = new SpriterClipHolder(new SpriterClip(new AnimationSet(AssetList.assets.getXml("enemydeaths")), AssetList.assets.getTextureAtlas("common")));
			clipList[11] = new SpriterClipHolder(new SpriterClip(new AnimationSet(AssetList.assets.getXml("enemydeaths")), AssetList.assets.getTextureAtlas("common")));
			//trace(clipList.length);
			lionClip = new SpriterClip(new AnimationSet(AssetList.assets.getXml("animLion")), AssetList.assets.getTextureAtlas("common"));
			fluitClip = new SpriterClip(new AnimationSet(AssetList.assets.getXml("animFlute")), AssetList.assets.getTextureAtlas("common"));
			boarClip = new SpriterClip(new AnimationSet(AssetList.assets.getXml("animSwine")), AssetList.assets.getTextureAtlas("common"));
		
			lionClip2 = new SpriterClip(new AnimationSet(AssetList.assets.getXml("animLion")), AssetList.assets.getTextureAtlas("common"));
			fluitClip2 = new SpriterClip(new AnimationSet(AssetList.assets.getXml("animFlute")), AssetList.assets.getTextureAtlas("common"));
			boarClip2 = new SpriterClip(new AnimationSet(AssetList.assets.getXml("animSwine")), AssetList.assets.getTextureAtlas("common"));
			
		}
		
		public static function getClip():SpriterClip {
			var returnClip:SpriterClip;
			var bla:Boolean = false;
			for (i = 0; i < clipList.length; i++) {
				if (!clipList[i].inUse) {
					returnClip = clipList[i].clip;
					clipList[i].inUse = true;
					bla = true;
					//trace("[spriterclip get]: "+returnClip+" n:"+i+" return:"+bla);
					break;
				}
			}
			if(!bla){
				returnClip = clipList[0].clip;
			}
			return returnClip;
		}
		
		public static function returnClip(clipReturnd:SpriterClip):void {
			//trace("call return");
			for (var i:int = 0; i < clipList.length; i++) {
				if (clipList[i].clip == clipReturnd) {
					//trace("return: "+i);
					clipList[i].inUse = false;
				}
			}
		}
		
	}

}