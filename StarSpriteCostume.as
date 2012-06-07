package
{
	
	
	import com.phoenixperry.BitmapDataCatcher;
	
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	
	import starling.core.Starling;
	import starling.display.DisplayObject;
	import starling.display.Image;
	import starling.display.MovieClip;
	import starling.display.Sprite;
	import starling.textures.Texture;
	import starling.textures.TextureAtlas;
	
	public class StarSpriteCostume extends Sprite
 	{
		private var _myXML:XML;
		private var myTexture:Texture; 
		
		private var myAtlas:TextureAtlas; 
		private var _textureName:String; 
		private var _myFrameRate:int; 
		private var myMovie:MovieClip; 
		private var _single_mc:MovieClip; 
		private var sprites:SingletonSpriteSheet; 
		private var _cacheID:String; 
		private var bitMapFromSheet:BitmapData; 
		public function StarSpriteCostume(textureName:String, myFrameRate:int, CACHE_ID:String=null)
		{
			//starling 
			sprites = SingletonSpriteSheet.getInstance();
			_myXML = sprites.myXML; 
			myTexture = sprites.myTexture ; 
			_textureName = textureName; 
			_cacheID = CACHE_ID; 
			
		}
		
		public function getDressed():MovieClip {
			
			var myImage:Image = new Image(myTexture); 
			
			myAtlas = new TextureAtlas(myTexture, _myXML); 
			
			//first create the costume 
			var frames:Vector.<Texture> = myAtlas.getTextures(_textureName); 
			name = _textureName; 
			myMovie= new MovieClip(frames,_myFrameRate); 
			
			Starling.juggler.add(myMovie); 
			return myMovie; 
		
		}
		
//		public function cacheMe():BitmapData { 
//			var target2BitmapData:BitmapData = BitmapDataCatcher.cacheBitmap(_cacheID,bitMapFromSheet, _myXML);
//			return target2BitmapData; 
//		}
	
		
//	public function singleOutfit(_myTexture:Texture, _xmlData:XML, _name:String):MovieClip{ 
		//fix this function. it's busted. Why? 
//			var _myAtlas:TextureAtlas = new TextureAtlas(_myTexture,_xmlData); 
//			trace(_myAtlas);
//			trace("i ran screaming"); 
//			//first create the costume 
//			var _frames:Vector.<Texture> = myAtlas.getTextures(_name); 
//			_single_mc= new MovieClip(_frames,1);  
//			
//			return _single_mc; 
		
		//}
		

	}
}