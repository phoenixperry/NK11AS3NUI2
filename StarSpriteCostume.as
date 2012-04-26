package
{
	
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
		
		private var sprites:SingletonSpriteSheet; 

		public function StarSpriteCostume(textureName:String, myFrameRate:int)
		{
			//starling 
			sprites = SingletonSpriteSheet.getInstance();
			_myXML = sprites.myXML; 
			myTexture = sprites.myTexture; 
			_textureName = textureName; 

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

	}
}