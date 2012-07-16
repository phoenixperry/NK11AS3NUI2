package com.phoenixperry
{
	import flash.display.Bitmap;
	
	import starling.display.Sprite;
	import starling.events.Event;
	import starling.text.BitmapChar;
	import starling.text.BitmapFont;
	import starling.text.TextField;
	import starling.textures.Texture;
	import starling.utils.Color;
	
	public class HeroFont extends Sprite 
	{
		
		
		[Embed(source = "assets/gameOver/fonts/hero.png")] 
		private static const BitmapChars:Class; 
		
		
		[Embed(source = "assets/gameOver/fonts/hero.fnt" , mimeType="application/octet-stream")] 
		private static const HeroXML:Class; 
		
		
		public function HeroFont()
		{
			addEventListener(Event.ADDED_TO_STAGE, onAdded); 
		}
		private function onAdded(e:Event):void {
			//creates the embedded bitmap 
			var bitmap:Bitmap = new BitmapChars(); 
			
			//creates a texture out of it 
			var texture:Texture = Texture.fromBitmap(bitmap); 
			
			//create the xml file describing the glyphes position on the sprite
			var xml:XML = XML(new HeroXML()); 
			
			//resister the bitmap font to make it an available textfield
			TextField.registerBitmapFont(new BitmapFont(texture, xml)); 
			
			//create the Textfield object 
			var bmpFontTF:TextField = new TextField(400,400, "here's some copy", "HeroLight", 60); 
			
			//the native bitmap font size no scaling 
			bmpFontTF.fontSize = BitmapFont.NATIVE_SIZE; 
			
			//use white to use the texture as it is no tinitnig 
			bmpFontTF.color = Color.WHITE; 
			
			//centers the text on stage 
			bmpFontTF.x = stage.stageWidth - bmpFontTF.width >> 1; 
			bmpFontTF.y = stage.stageHeight - bmpFontTF.height >> 1; 
			
			addChild(bmpFontTF); 
		}
	}
}