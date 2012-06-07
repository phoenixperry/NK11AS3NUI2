package
{	
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	
	import starling.display.Sprite;
	import starling.textures.Texture;
	
	public class SingletonSpriteSheet extends Sprite
	{
		private static var instance:SingletonSpriteSheet; 
		private static var isOkToCreate:Boolean = false; 
		
		
		[Embed(source="./assets/gameOver/sprites/startClouds.png")] 
		private var spriteSheet:Class;  
		
		[Embed(source="./assets/gameOver/sprites/startClouds.xml",  mimeType="application/octet-stream")]
		private var allData:Class;
		
		private var _myTexture:Texture; 
		private var _myXML:XML; 
		private var _allBits:Bitmap;

		public function SingletonSpriteSheet()
		{
			if(!isOkToCreate) throw new Error(this + " is a singleton. Access using getInstance()"); 
			if(isOkToCreate) {
				_allBits = new spriteSheet(); 
				_myTexture = Texture.fromBitmap(_allBits, true); 
				_myXML = XML(new allData()); 
			
				
				
			}
		}
		
		//with this method we will create and access the instance of the method

		
		public static function getInstance():SingletonSpriteSheet 
		{
			//if there's no instance, make one
			if(!instance) 
			{
				isOkToCreate = true; 
				instance = new SingletonSpriteSheet(); 
				isOkToCreate = false; 
				trace("Singleton instance created"); 
			}
			return instance; 
		}

		public function get myTexture():Texture
		{
			return _myTexture;
		}

		public function get myXML():XML
		{
			return _myXML;
		}

	
		

	}
}