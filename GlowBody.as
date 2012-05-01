package
{
	import flash.display.Bitmap;
	
	import starling.core.Starling;
	import starling.display.Sprite;
	import starling.events.Event;
	import starling.extensions.ParticleDesignerPS;
	import starling.textures.Texture; 

	
	public class GlowBody extends Sprite
	{
		private var particleXML:XML; 
		private var particleTexture:Texture; 
		private var particleBits:Bitmap; 


		private var mps:ParticleDesignerPS;
		private var mps2:ParticleDesignerPS;
		private var mps3:ParticleDesignerPS;
		private var mps4:ParticleDesignerPS;
		private var mps5:ParticleDesignerPS;
		private var mps6:ParticleDesignerPS;
		private var mps7:ParticleDesignerPS;
		private var mps8:ParticleDesignerPS;
		private var mps9:ParticleDesignerPS;
		private var mps10:ParticleDesignerPS;
		private var mps11:ParticleDesignerPS;
		private var mps12:ParticleDesignerPS;
		private var mps13:ParticleDesignerPS;
		private var mps14:ParticleDesignerPS;
		private var mps15:ParticleDesignerPS;
		

		
		private static var _xpos:Number=0; 
		private static var _ypos:Number=0; 
		
		private static var _xpos2:Number=0; 
		private static var _ypos2:Number=0; 
		
		private static  var _xpos3:Number=0; 
		private static var _ypos3:Number=0; 
		
		private static var _xpos4:Number=0; 
		private static var _ypos4:Number=0; 
		
		private static var _xpos5:Number; 
		private static var _ypos5:Number; 
		
		private static var _xpos6:Number; 
		private static var _ypos6:Number; 
		private static var _xpos7:Number; 
		private static var _ypos7:Number; 
		
		private static var _xpos8:Number; 
		private static var _ypos8:Number; 
		
		private static var _xpos9:Number; 
		private static var _ypos9:Number; 
		
		private static var _xpos10:Number; 
		private static var _ypos10:Number; 
		
		private static var _xpos11:Number; 
		private static  var _ypos11:Number; 
		
		private static var _xpos12:Number; 
		private static var _ypos12:Number; 
		
		private static var _xpos13:Number; 
		private static var _ypos13:Number; 
		
		private static var _xpos14:Number; 
		private static var _ypos14:Number; 
		
		private static var _xpos15:Number; 
		private static var _ypos15:Number; 
		
		[Embed(source="./assets/gameOver/sprites/texture.png")] 
		private var _particle:Class;  
		
		[Embed(source="./assets/gameOver/sprites/particle.xml",  mimeType="application/octet-stream")]
		private var particleData:Class;
		
		public function GlowBody()
		{
		addEventListener(Event.ADDED_TO_STAGE, onAdded); 
		particleXML = XML(new particleData()); 
		particleBits = new _particle(); 
		
		}
		
		private function onAdded(e:Event):void { 
			removeEventListener(Event.ADDED_TO_STAGE, onAdded); 
			particleTexture = Texture.fromBitmap(particleBits); 
			
			mps = new ParticleDesignerPS(particleXML, particleTexture); 
			mps2 = new ParticleDesignerPS(particleXML, particleTexture);
			mps3 = new ParticleDesignerPS(particleXML, particleTexture);
			mps4 = new ParticleDesignerPS(particleXML, particleTexture);
			mps5 = new ParticleDesignerPS(particleXML, particleTexture);
			mps6 = new ParticleDesignerPS(particleXML, particleTexture);
			mps7 = new ParticleDesignerPS(particleXML, particleTexture);
			mps8 = new ParticleDesignerPS(particleXML, particleTexture);
			mps9 = new ParticleDesignerPS(particleXML, particleTexture);
			mps10 = new ParticleDesignerPS(particleXML, particleTexture);
			mps11 = new ParticleDesignerPS(particleXML, particleTexture);
			mps12 = new ParticleDesignerPS(particleXML, particleTexture);
			mps13 = new ParticleDesignerPS(particleXML, particleTexture);
			mps14 = new ParticleDesignerPS(particleXML, particleTexture);
			mps15 = new ParticleDesignerPS(particleXML, particleTexture);

			
			
	
			mps.start();
			mps2.start();
			mps3.start();
			mps4.start();
			//mps5.start();
			mps6.start();
			mps7.start();
			mps8.start();
			mps9.start();
			mps10.start();
			mps11.start();
			mps12.start();
			mps13.start();
			mps14.start();
			mps15.start();
			
			addChild(mps); 
			addChild(mps2);
			addChild(mps3);
			addChild(mps4);
		//addChild(mps5);
			addChild(mps6);
			addChild(mps7);
			addChild(mps8);
			addChild(mps9);
			addChild(mps10);
			addChild(mps11);
			addChild(mps12);
			addChild(mps13);
			addChild(mps14);
			addChild(mps15);

			Starling.juggler.add(mps); 
			Starling.juggler.add(mps2);
			Starling.juggler.add(mps3);
			Starling.juggler.add(mps4);
			Starling.juggler.add(mps5);
			Starling.juggler.add(mps6);
			Starling.juggler.add(mps7);
			Starling.juggler.add(mps8);
			Starling.juggler.add(mps9);
			Starling.juggler.add(mps10);
			Starling.juggler.add(mps11);
			Starling.juggler.add(mps12);
			Starling.juggler.add(mps13);
			Starling.juggler.add(mps14);
			Starling.juggler.add(mps15);
		}
	
		public function update():void {
//			
			mps.emitterX= xpos; 
			mps.emitterY = ypos;
			
			mps2.emitterX= xpos2; 
			mps2.emitterY = ypos2;
			
			mps3.emitterX= xpos3; 
			mps3.emitterY = ypos3;
			mps4.emitterX= xpos4; 
			mps4.emitterY = ypos4;
			mps5.emitterX= xpos5; 
			mps5.emitterY = ypos5;
			mps6.emitterX= xpos6; 
			mps6.emitterY = ypos6;
			mps7.emitterX= xpos7; 
			mps7.emitterY = ypos7;
			mps8.emitterX= xpos8; 
			mps8.emitterY = ypos8;
			
			mps9.emitterX= xpos9; 
			mps9.emitterY = ypos9;
			
			mps10.emitterX= xpos10; 
			mps10.emitterY = ypos10;
			mps11.emitterX= xpos11; 
			mps11.emitterY = ypos11;
			mps12.emitterX= xpos12; 
			mps12.emitterY = ypos12;
			mps13.emitterX= xpos13; 
			mps13.emitterY = ypos13;
			
			mps14.emitterX= xpos14; 
			mps14.emitterY = ypos14;
			
			mps15.emitterX= xpos15; 
			mps15.emitterY = ypos15;
		}
		public static function get xpos():Number
		{
			return _xpos;
		}

		public static function set xpos(value:Number):void
		{
			_xpos = value;
		}

	
		public static function get xpos2():Number
		{
			return _xpos2;
		}

		public static function set xpos2(value:Number):void
		{
			_xpos2 = value;
		}

	
		public static function get xpos3():Number
		{
			return _xpos3;
		}

		public static function set xpos3(value:Number):void
		{
			_xpos3 = value;
		}

		
		public static function get xpos4():Number
		{
			return _xpos4;
		}

		public static function set xpos4(value:Number):void
		{
			_xpos4 = value;
		}

		
		public static function get xpos5():Number
		{
			return _xpos5;
		}

		public static function set xpos5(value:Number):void
		{
			_xpos5 = value;
		}

	

		public static function get xpos6():Number
		{
			return _xpos6;
		}

		public static function set xpos6(value:Number):void
		{
			_xpos6 = value;
		}


		public static function get xpos7():Number
		{
			return _xpos7;
		}

		public static function set xpos7(value:Number):void
		{
			_xpos7 = value;
		}

	
		public static function get xpos8():Number
		{
			return _xpos8;
		}

		public static function set xpos8(value:Number):void
		{
			_xpos8 = value;
		}

		
		public static function get xpos9():Number
		{
			return _xpos9;
		}

		public static function set xpos9(value:Number):void
		{
			_xpos9 = value;
		}

	
		public static function get xpos10():Number
		{
			return _xpos10;
		}

		public static function set xpos10(value:Number):void
		{
			_xpos10 = value;
		}

	

		public static function get xpos11():Number
		{
			return _xpos11;
		}

		public static function set xpos11(value:Number):void
		{
			_xpos11 = value;
		}

		
		public static function get xpos12():Number
		{
			return _xpos12;
		}

		public static function set xpos12(value:Number):void
		{
			_xpos12 = value;
		}

		

		public static function get xpos13():Number
		{
			return _xpos13;
		}

		public static function set xpos13(value:Number):void
		{
			_xpos13 = value;
		}

		public static function get ypos14():Number
		{
			return _ypos14;
		}

		public static function set ypos14(value:Number):void
		{
			_ypos14 = value;
		}

		public static function get xpos15():Number
		{
			return _xpos15;
		}

		public static function set xpos15(value:Number):void
		{
			_xpos15 = value;
		}

	

	

//l2		
	}
}