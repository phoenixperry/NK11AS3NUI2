package
{
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.Graphics;
	import flash.display.Sprite;
	import flash.geom.Point;
	
	import starling.display.Image;
	import starling.display.Sprite;
	import starling.events.Event;
	import starling.extensions.*;
	import starling.textures.Texture;
	import starling.textures.TextureAtlas;
	
	public class BalloonString extends starling.display.Sprite{
		private static var _rsxpos:Number;
		private static var _rsypos:Number; 
		
		private static var _rhxpos:Number; 
		private static var _rhypos:Number; 
		
		private var st:flash.display.Sprite; 
		private var stg:flash.display.Graphics; 
		private var stBit:BitmapData; 
		private var texture:Texture; 
		private var img:Image; 
		private var balloonString:starling.display.Sprite; 
		public function BalloonString()
		{ 
			
			addEventListener(Event.ADDED_TO_STAGE, drawInit); 
			st = new flash.display.Sprite();  
			stg = st.graphics; 	
			stBit = new BitmapData(500,500, true); 
		}
		
		private function drawInit(e:Event):void
		{
			removeEventListener(Event.ADDED_TO_STAGE, drawInit); 
			addEventListener(Event.ENTER_FRAME, drawString); 
			
		}
		
		private function drawString(e:Event):void{
			stg.clear(); 
			stg.lineStyle(2,0x000000); 
			
			stg.moveTo(150,100); 
			stg.curveTo(_rhxpos, rhypos, 500,500); 
			stBit.draw(st); 
			texture = Texture.fromBitmapData(stBit); 
			img = new Image(texture); 
			addChild(img); 
			
		}
		public static function get rsxpos():Number
		{
			return _rsxpos;
		}
		
		public static function set rsxpos(value:Number):void
		{
			_rsxpos = value;
		}
		
		public static function get rsypos():Number
		{
			return _rsypos;
		}
		
		public static function set rsypos(value:Number):void
		{
			_rsypos = value;
		}
		
		public static function get rhxpos():Number
		{
			return _rhxpos;
		}
		
		public static function set rhxpos(value:Number):void
		{
			_rhxpos = value;
		}
		
		public static function get rhypos():Number
		{
			return _rhypos;
		}
		
		public static function set rhypos(value:Number):void
		{
			_rhypos = value;
		}

//l2		
	}
}