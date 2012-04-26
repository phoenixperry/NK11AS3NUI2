package
{
	
	import flash.display.Bitmap;
	
	import starling.core.Starling;
	import starling.display.Image;
	import starling.display.MovieClip;
	import starling.display.Sprite;
	import starling.events.EnterFrameEvent;
	import starling.events.Event;
	import starling.textures.Texture;
	
	
	public class Parallex extends Sprite
	{
		private var _img1:Image; 
		private var _img2:Image; 
		private var _myBreadth:Number; 
		private var _w:Number; 
		private var _h:Number; 
		private var _s:Number; 
		private var container:Sprite; 
		private var _vert:Boolean; 
		
		//textures 
		private var para1Texture:Texture; 
		private var para2Texture:Texture;
		
		public function Parallex(img1Class:Class, img2Class:Class, w:Number, h:Number, myBreadth:Number, speed:Number, vert:Boolean):void
		{ 
			
			var para1Bit:Bitmap = new img1Class(); 
			 para1Texture = Texture.fromBitmap(para1Bit, true); 
			_img1 = new Image(para1Texture); 	
						
			var para2Bit:Bitmap = new img2Class(); 
			 para2Texture = Texture.fromBitmap(para2Bit, true); 
			_img2 = new Image(para2Texture); 		
			container = new Sprite(); 
			_w = w; 
			_h = h; 
			_myBreadth = myBreadth;  
			_s = speed; 
			_img1.x = 0; 
			_img1.y = 0; 
			_vert = vert; 
			 if(!vert) {
				_img2.x = _w; 
				_img2.y = 0; 
	
				container.addChild(_img1); 
				container.addChild(_img2);
				container.x = 0; 
				container.y = 0; 
			} else {
				_img2.x = 0;
				_img2.y = _h; 
				container.addChild(_img1); 
				container.addChild(_img2); 
			}
			 addChild(container); 

		}
		
		public function update():void {
			
			if(!_vert) {
			container.x = container.x -_s; 
			
			if(_img1.x + _myBreadth + container.x < 0) {
				_img1.x = _img1.x+(2*_myBreadth); 
			}
			if (_img2.x + _myBreadth + container.x < 0) {
				_img2.x = _img2.x +(2*_myBreadth); 	
			}
			
		}
			else {
				
				container.y = container.y -_s; 
				
				if(_img1.y + _myBreadth + container.y < 0) {
					_img1.y = _img1.y+(2*_myBreadth); 
				}
				if (_img2.y + _myBreadth + container.y < 0) {
					_img2.y = _img2.y +(2*_myBreadth); 	
				}
				
			}
		}	
		public function remove ():void
		{
			para1Texture.dispose(); 
			para1Texture.dispose(); 
			this.removeChildren(); 
			//			
		}
		
	//l2
	}
}