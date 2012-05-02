package
{
	
	import Box2D.Common.Math.b2Vec2;
	
	import com.greensock.TweenLite;
	
	import flash.display.Bitmap;
	import flash.events.TimerEvent;
	import flash.utils.Timer;
	
	import starling.display.Image;
	import starling.display.Quad;
	import starling.display.Sprite;
	import starling.textures.Texture; 
	
	public class GameOverLevel1 extends LevelGen
	{	
		[Embed(source="./assets/gameOver/sprites/FearisTheMindKiller.jpg")]
		private var intro:Class;
		
		private var introBits:Bitmap; 
		private var introTexture:Texture; 
		private var introImage:Image; 
		
		private var fireGoomba:Timer; 
		private var goombaImmune:Timer; 
		private var introTimer:Timer; 
		public function GameOverLevel1() 
		{
//			var q:Quad = new Quad(300,300,0xFF00FF,true); 
//			addChild(q); 
			introTimer = new Timer(5000,1);
			introTimer.addEventListener(TimerEvent.TIMER_COMPLETE, startUp); 
			fireGoomba = new Timer(3000); 
			goombaImmune = new Timer(1000);

			introBits = new intro(); 
			introTexture = Texture.fromBitmap(introBits); 
			introImage = new Image(introTexture); 
			addChild(introImage);
			introImage.alpha = 0; 
			TweenLite.to(introImage, 1, {alpha:1});
			introTimer.start(); 
			
		}
		
		protected function startUp(event:TimerEvent):void
		{	
			TweenLite.to(introImage, 1, {alpha:0});
			// TODO Auto-generated method stub
			removeEventListener(TimerEvent.TIMER_COMPLETE,startUp); 
			fireGoomba.addEventListener(TimerEvent.TIMER,goGoomba);
			fireGoomba.start();
			
		}
		public function goGoomba(event:TimerEvent):void{
			trace("earth goomba up"); 
			var ea:EarthAir = new EarthAir();  
			addChild(ea); 

		}
		
		override public function removeLevel():void {
			this.removeChildren(); 
			this.dispose();
			trace(numChildren); 
			//listeners outta here
			this.removeEventListeners(); 
		}
		
	}
}