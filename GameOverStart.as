package
{
	import com.greensock.*;
	import com.greensock.easing.*;
	
	import flash.display.Bitmap;
	
	import org.osflash.signals.Signal;
	
	import starling.core.Starling;
	import starling.display.BlendMode;
	import starling.display.Image;
	import starling.display.MovieClip;
	import starling.display.Quad;
	import starling.display.Sprite;
	import starling.events.Event;
	import starling.textures.Texture;
	import starling.textures.TextureAtlas;

	
	public class GameOverStart extends Sprite
	{
		private var stars:MovieClip; 
		private var start:MovieClip;
	
		private var dieBtn:MovieClip; 
		private var sprites:StarSpriteCostume; 
		private var _startTexture:Texture; 
		private var _startXML:XML; 
		private var _starsTexture:Texture; 
		private var _starsXML:XML; 
		
		private var start_mc:MovieClip; 
		private var stars_mc:MovieClip; 
		private var dieBtn_mc:MovieClip
		private var starsPara:Parallex;  
		private var rainbowPara:Parallex; 
		private var cloudsPara:Parallex; 
		private var btnTrigger:Signal; 
		public static var rhxpos:Number; 
		public static var rhypos:Number; 
		
 
		
		[Embed(source="./assets/gameOver/sprites/startClouds.png")]
		private var startClouds:Class; 
		
		[Embed(source="./assets/gameOver/sprites/startClouds.xml",  mimeType="application/octet-stream")]
		private var startData:Class;
		
		[Embed(source="./assets/gameOver/sprites/stars.png")]
		private var myStars:Class;
		
		[Embed(source="./assets/gameOver/sprites/stars.xml",  mimeType="application/octet-stream")]
		private var starData:Class;
		
		[Embed(source="./assets/gameOver/sprites/Clouds.png")]
		private var Clouds:Class; 
	
		[Embed(source="./assets/gameOver/sprites/rainbowGrad.png")]
		private var Rainbow:Class; 
		

		
		public function GameOverStart()
		{
			addEventListener(Event.ADDED_TO_STAGE, startAdded); 
			
			var startBits:Bitmap = new startClouds(); 
			_startTexture = Texture.fromBitmap(startBits, true); 
			_startXML = XML(new startData()); 
			btnTrigger = new Signal(); 
			btnTrigger.add(btnClicked); 
	
	
		}
		
		private function startAdded(e:Event):void
		{
		
			trace(_startXML); 
			trace(_startTexture); 
			var textureAtlas:TextureAtlas = new TextureAtlas(_startTexture, _startXML); 
			var frames:Vector.<Texture> = textureAtlas.getTextures("StartScreen"); 
			start_mc = new MovieClip(frames, 1); 
			addChild(start_mc); 
		//	start_mc.blendMode = BlendMode.ADD; 

			cloudsPara = new Parallex(Clouds, Clouds, 1024, 768, 2046, .2, false);  
			cloudsPara.multiplyIt(); 
			cloudsPara.alpha = .5; 
			addChild(cloudsPara); 
		
			starsPara = new Parallex(myStars, myStars, 1023, 768, 2046,.05, false); 
			starsPara.screenIt(); 
			addChild(starsPara); 
			starsPara.alpha = 1; 
			
//			rainbowPara = new Parallex(Rainbow, Rainbow, 1024, 768, 2046, .2, false);  
//			rainbowPara.multiplyIt();
//			addChild(rainbowPara); 
//		
			var frames1:Vector.<Texture> = textureAtlas.getTextures("die");
			dieBtn_mc = new MovieClip(frames1,1); 
			addChild(dieBtn_mc); 
			TweenLite.to(dieBtn_mc, 2, {x:832, y:480, alpha:1, ease:Cubic.easeOut});
			dieBtn_mc.y = 480; 
			dieBtn_mc.x = 1024; 
			
			addEventListener(Event.ENTER_FRAME, btnTest); 
		}
		public function btnTest(e:Event) :void {
			if(rhxpos > 832 && rhxpos < 1024 && rhypos > 480 && rhypos < 568) { 
				btnTrigger.dispatch("btn clicked"); 
				
			}
		}
		public function btnClicked(msg:String):void {
			trace(msg);
			//TweenLite.to(dieBtn_mc, 1, {x:832, y:480,  alpha:0.5});
			var q:starling.display.Quad = new starling.display.Quad(192, 7, 0x62b6bd, true); 
			addChild(q); 
			q.x = 1024; 
			q.y = 568; 
			TweenLite.to(q, 2, {x:832, y:568, alpha:1, ease:Cubic.easeOut});
			dieBtn_mc.color = 0x62b6bd;
			
			
		}
	
		
		
	}
}