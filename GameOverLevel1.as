
package
{
	
	import Box2D.Common.Math.b2Vec2;
	
	import com.greensock.TweenLite;
	import com.greensock.easing.Bounce;
	import com.phoenixperry.EarthAirChaser;
	import com.phoenixperry.HeroFont;
	import com.phoenixperry.IntroAnimation;
	
	import flash.display.Bitmap;
	import flash.events.TimerEvent;
	import flash.media.Sound;
	import flash.text.Font;
	import flash.ui.GameInput;
	import flash.utils.Timer;
	
	import org.osflash.signals.Signal;
	
	import starling.core.Starling;
	import starling.display.Image;
	import starling.display.MovieClip;
	import starling.display.Quad;
	import starling.display.Sprite;
	import starling.events.Event;
	import starling.text.TextField;
	import starling.textures.Texture;
	
	public class GameOverLevel1 extends LevelGen
	{	
		
		[Embed(source="assets/gameOver/fonts/Gotham-Light.otf", embedAsCFF="false", fontName="Gotham")]
		private static var Gotham:Class;  
		
		private var font:Font = new Gotham(); 
		private var endText:TextField; 
		
		private var sprites:StarSpriteCostume;
		
		
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
		private var heart1:MovieClip;
		private var heart2:starling.display.MovieClip; 
		private var heart3:starling.display.MovieClip; 
		private var heart4:starling.display.MovieClip;  
		
		private var onLevel1:starling.text.TextField;
		private var onLevel2:starling.text.TextField;
		private var onLevel3:starling.text.TextField;
		private var onLevel4:starling.text.TextField;
		
		private var level1Complete:Signal; 
		private var level2Complete:Signal; 
		private var level3Complete:Signal; 
		private var level1_mc:MovieClip; 
		private var level2_mc:MovieClip; 
		private var level3_mc:MovieClip; 
		private var intro_ani:IntroAnimation; 
		private var msg:TextField; 

		
		
		
		public function GameOverLevel1() 
		{
	

//			var q:Quad = new Quad(300,300,0xFF00FF,true); 
//			addChild(q); 
			//change this timer to change the lenght the fear clip is up
			introTimer = new Timer(17000,1);
			introTimer.addEventListener(TimerEvent.TIMER_COMPLETE, startUp); 
			
			goombaImmune = new Timer(1000);
//			introBits = new intro(); 
//			introTexture = Texture.fromBitmap(introBits); 
//			introImage = new Image(introTexture); 
//			addChild(introImage);
//			introImage.alpha = 0; 
//			//TweenLite.to(introImage, 1, {alpha:1});
			//here's a funciton todo the graphics
			intro_ani = new IntroAnimation(); 
			addChild(intro_ani); 
			introTimer.start(); 
			level1Complete = new Signal(); 
			level2Complete = new Signal(); 
			level3Complete = new Signal(); 
			level1Complete.add(endLevel1); 
			level2Complete.add(endLevel2); 
			level3Complete.add(endLevel3); 
	
		}
		private function endLevel1():void{
			removeChild(level1_mc); 
			sprites = new StarSpriteCostume("level2",1); 
			level2_mc = sprites.getDressed(); 
			addChild(level2_mc); 
		}
		private function endLevel2():void { 
			removeChild(level2_mc); 
			sprites = new StarSpriteCostume("level3",1); 
			level3_mc = sprites.getDressed(); 
			addChild(level3_mc); 
			
		}
		private function endLevel3():void { 
			removeChild(level3_mc); 
		}

		protected function startUp(event:TimerEvent):void
		{	
			removeEventListener(TimerEvent.TIMER_COMPLETE,startUp); 
			
			if(!GameMain.useKinect){
			gb = new GlowBody();  
			addChild(gb); 
			sprites = new StarSpriteCostume("heart", 1);
			heart1 = sprites.getDressed();
			heart2 = sprites.getDressed(); 
			heart3 = sprites.getDressed(); 
			heart4 = sprites.getDressed(); 
			
			sprites = new StarSpriteCostume("level1",1); 
			level1_mc = sprites.getDressed(); 
			addChild(level1_mc); 
			
			gameUI(); 
			
			endText = new TextField(500, 200, "GAME OVER", font.fontName, 38, 0xFFFFFF);  
			endText.x = stage.stageWidth - endText.width >>1 ;
			endText.y = stage.stageHeight - endText.height >> 1;
			endText.alpha = 0; 
			addChild(endText); 
			
			}

			addEventListener(Event.ENTER_FRAME,goombaLevels); 
	
			fireGoomba = new Timer(1000);  
			fireGoomba.start();
			fireGoomba.addEventListener(TimerEvent.TIMER,goGoomba);

		}
		//this section really does run the game speed in commpleteness 
		public function goGoomba(event:TimerEvent):void{
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
			 oddsOfEvil=0.1;	 
			// trace("level 1");
		 }
		 
		 if(fireGoomba.currentCount > 5 && fireGoomba.currentCount < 120 ) { 
			 currentLevel=2; 
			 oddsOfFall=0.6
			 oddsOfFear=0.5;
			 oddsOfEvil=0.3;	 
			// trace("level 2");
		 }
		 if(fireGoomba.currentCount > 120 && fireGoomba.currentCount < 180) { 
		 	currentLevel=3; 
		 	oddsOfFall=0.8
		 	oddsOfFear=0.85;
		 	oddsOfEvil=0.9;	 
		 //	trace("level 3");  
		}

		if(fireGoomba.currentCount == 5){ 
			level1Complete.dispatch(); 
		}
		 
		if(fireGoomba.currentCount == 120) { 
			level2Complete.dispatch(); 
		}
		if(fireGoomba.currentCount == 180) {
			level3Complete.dispatch();  
		}
	
		 updateHearts(); 

	}
		
		private function drawLevelUpUI():void { 
			 
		}
		private function getInputs():void
		{
			getX = GameMain.getX/100 *stage.stageWidth;
			getY = GameMain.getY/100 *stage.stageHeight;
			speedKnob = GameMain.speedKnob; 
			attackBtn = GameMain.attackBtn; 
		}		
		private function gameUI():void { 
		
			addChild(heart1); 
			
			addChild(heart2); 
			addChild(heart3); 
			addChild(heart4);
			heart4.x =840; 
			heart4.y = 40; 
			
			heart3.x = 881; 
			heart3.y = 40; 
			
			heart2.x = 921;
			heart2.y = 40; 
			
			heart1.x = 961; 
			heart1.y = 40; 
		}
		
		private function updateHearts():void {
			if(GameMain.useKinect) { 
				if(GameMain.countGlows < 9) {
					removeChild(heart1); 
					heart1.dispose(); 
				}
				if(GameMain.countGlows < 6) { 
					removeChild(heart2); 
					heart2.dispose(); 	
				}
				if(GameMain.countGlows < 3) { 
					removeChild(heart3); 
					heart3.dispose(); 
				}
				if(GameMain.countGlows == 0) { 
					removeChild(heart4); 
					heart4.dispose(); 				
				}
			}else {
				if(GameMain.countGlows == 0 ) {
					removeChild(heart1); 
					removeChild(heart2); 
					removeChild(heart3); 
					removeChild(heart4); 
					heart1.dispose(); 
					heart2.dispose(); 
					heart3.dispose(); 
					heart4.dispose(); 
					endText.alpha = 100; 
						
				}
			}
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