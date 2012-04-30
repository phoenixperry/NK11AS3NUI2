package
{
	import flash.display.Bitmap;
	
	import starling.display.Sprite;
	import starling.events.Event;
	import starling.extensions.ParticleDesignerPS;
	import starling.textures.Texture; 
	import starling.core.Starling; 
	
	public class Body extends Sprite
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
		

		
		public  var xpos:Number=0; 
		public  var ypos:Number=0; 
		
		public  var xpos2:Number=0; 
		public  var ypos2:Number=0; 
		
		public static var xpos3:Number=0; 
		public static var ypos3:Number=0; 
		
		public static var xpos4:Number=0; 
		public static var ypos4:Number=0; 
		
		public static var xpos5:Number; 
		public static var ypos5:Number; 
		
		public static var xpos6:Number; 
		public static var ypos6:Number; 
		
		public static var xpos7:Number; 
		public static var ypos7:Number; 
		
		public static var xpos8:Number; 
		public static var ypos8:Number; 
		
		public static var xpos9:Number; 
		public static var ypos9:Number; 
		
		public static var xpos10:Number; 
		public static var ypos10:Number; 
		
		public static var xpos11:Number; 
		public static var ypos11:Number; 
		
		public static var xpos12:Number; 
		public static var ypos12:Number; 
		
		public static var xpos13:Number; 
		public static var ypos13:Number; 
		
		
		[Embed(source="./assets/gameOver/sprites/texture.png")] 
		private var _particle:Class;  
		
		[Embed(source="./assets/gameOver/sprites/particle.xml",  mimeType="application/octet-stream")]
		private var particleData:Class;
		
		public function Body()
		{
		addEventListener(Event.ADDED_TO_STAGE, onAdded); 
		particleXML = XML(new particleData()); 
		particleBits = new _particle(); 
		
		}
		
		private function onAdded(e:Event) { 
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

			mps.emitterX= 800; 
			mps.emitterY = 240; 
			mps.start();
			mps2.start();
			mps3.start();
			mps4.start();
			mps5.start();
			mps6.start();
			mps7.start();
			mps8.start();
			mps9.start();
			mps10.start();
			mps11.start();
			mps12.start();
			mps13.start();
			
			addChild(mps); 
			
			addChild(mps2);
			addChild(mps3);
			addChild(mps4);
			addChild(mps5);
			addChild(mps6);
			addChild(mps7);
			addChild(mps8);
			addChild(mps9);
			addChild(mps10);
			addChild(mps11);
			addChild(mps12);
			addChild(mps13);

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
		}
	
		public function update():void {
//			mps.emitterX= xpos; 
//			mps.emitterY = ypos;
			
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
			
		}
//l2		
	}
}