
package
{
	
	import Box2D.Common.Math.b2Vec2;
	
	import com.greensock.TweenLite;
	import com.greensock.easing.Bounce;
	import com.phoenixperry.EarthAirChaser;
	
	import flash.display.Bitmap;
	import flash.events.TimerEvent;
	import flash.media.Sound;
	import flash.ui.GameInput;
	import flash.utils.Timer;
	
	import starling.display.Image;
	import starling.display.Quad;
	import starling.display.Sprite;
	import starling.events.Event;
	import starling.textures.Texture; 
	public class GameOverLevel1 extends LevelGen
	{	
		[Embed(source="./assets/gameOver/sprites/FearisTheMindKiller.jpg")]
		private var intro:Class;
		
		private var introBits:Bitmap; 
		private var introTexture:Texture; 
		private var introImage:Image; 
		
		private var fireGoomba:Timer; 
		private var fireGoomba2:Timer; 
		private var fireGoomba3:Timer; 
		private var goombaImmune:Timer; 
		private var introTimer:Timer; 
		public var gb:GlowBody; 
		private var goobaFireTime:Number=1000; 
		
		//for incoming numbers 
		private var getX:Number; 
		private var getY:Number; 
		private var speedKnob:Number; 
		private var attackBtn:Number; 
		private var dropEvil:Number =0; 
		
		private var currentLevel =0; 
		
		private var oddsOfFall, oddsOfFear, oddsOfEvil; 
		
		public function GameOverLevel1() 
		{
//			var q:Quad = new Quad(300,300,0xFF00FF,true); 
//			addChild(q); 
			//change this timer to change the lenght the fear clip is up
			introTimer = new Timer(100,1);
			introTimer.addEventListener(TimerEvent.TIMER_COMPLETE, startUp); 
			
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
			
			if(!GameMain.useKinect){
			gb = new GlowBody();  
			addChild(gb); 
		
			}

			addEventListener(Event.ENTER_FRAME,goombaLevels); 
	
			fireGoomba = new Timer(1000);  
			fireGoomba.start();
			fireGoomba.addEventListener(TimerEvent.TIMER,goGoomba);

		}
		//this section really does run the game speed in commpleteness 
		public function goGoomba(event:TimerEvent):void{
			var ea:EarthAir = new EarthAir(); 
			addChild(ea); 
			
				var rnd:Number = Math.random(); 
			//	trace(rnd, "odds of a fall"); 
				if(rnd  < oddsOfFall) { 
					if(rnd < oddsOfFear) { 
						if(rnd < oddsOfEvil) {
							var ea2:EarthAirChaser = new EarthAirChaser(); 
							addChild(ea2); 
							//trace("dropped super baddy"); 
						}else {
							var ea:EarthAir = new EarthAir(); 
							addChild(ea); 
							//trace("dropped normal baddy"); 
						}
					}
				}
		}
		
		//this is the function that sets everything 
		public function goombaLevels(e:Event):void { 
			//and here is where you set your xy
		getInputs(); 
		//see how many goomba have been fired - x goomba = level 1 
		 if (fireGoomba.currentCount == 0) { 
			 currentLevel=1; 
			 oddsOfFall=0.4
			 oddsOfFear=0.4;
			 oddsOfEvil=0.2;	 
			 trace("level 1");
		 }
		 if(fireGoomba.currentCount > 60 && fireGoomba.currentCount < 120 ) { 
			 currentLevel=2; 
			 oddsOfFall=0.6
			 oddsOfFear=0.5;
			 oddsOfEvil=0.3;	 
			 trace("level 2");
		 }
		 if(fireGoomba.currentCount > 120 && fireGoomba.currentCount < 180) { 
		 	currentLevel=3; 
		 	oddsOfFall=0.8
		 	oddsOfFear=0.85;
		 	oddsOfEvil=0.9;	 
		 	trace("level 3");
		}
	}
		private function getInputs():void
		{
			getX = GameMain.getX/100 *stage.stageWidth;
			getY = GameMain.getY/100 *stage.stageHeight;
			speedKnob = GameMain.speedKnob; 
			attackBtn = GameMain.attackBtn; 
			
		}		
		
		override public function removeLevel():void {
			//you are going to need to loop to check 
			//how many goomba there are
			if(!GameMain.useKinect){
			gb.remove();
			gb.destroy();
		

			}
			fireGoomba.removeEventListener(TimerEvent.TIMER,goGoomba); 
			
			this.removeChildren(); 
			this.dispose();
			trace(numChildren); 
			//listeners outta here
			this.removeEventListeners(); 
		}
		
	}
}