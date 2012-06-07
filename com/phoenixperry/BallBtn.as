package com.phoenixperry
{
	
	import flash.display.Bitmap;
	
	import starling.display.Button;
	import starling.display.Sprite;
	import starling.textures.Texture;
	public class BallBtn extends Sprite
		[Embed(source="./assets/gameOver/sprites/ballBtn.png", mimeType="image/png")]
		private var ballBtn:Class; 
		private var btnSkin:Bitmap; 
		private var btnTexture:Texture; 
		public var myBtn:Button; 
		
	{	public var name:Number; 
		private var tone:Class;  
		[Embed(source="./assets/gameOver/sprites/ballBtn.png", mimeType="image/png")]
		private var ballBtn:Class; 
		public function BallBtn(var _sound:Class, var _name:Number):Button
		{
			name = _name; 
			btnSkin = new ballBtn(); 
			tone = _sound; 
			
			btnTexture = Texture.fromBitmap(btnSkin); 
		
			myBtn:Button = new Button(btnTexture, name); 
			myBtn.fontBold = true; 
			//position 
			if(!GameMain.useKinect) {
			myBtn.y = myBtn.height * name; 
			}

		}
	}
}