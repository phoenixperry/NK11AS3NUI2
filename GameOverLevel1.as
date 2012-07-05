
package
{
	
	import Box2D.Common.Math.b2Vec2;
	
	import com.greensock.TweenLite;
	import com.greensock.easing.Bounce;

	
	import flash.display.Bitmap;
	import flash.events.TimerEvent;
	import flash.media.Sound;
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
		

		public function GameOverLevel1() 
		{
//			var q:Quad = new Quad(300,300,0xFF00FF,true); 
//			addChild(q); 
			introTimer = new Timer(10000,1);
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
		public function goGoomba(event:TimerEvent):void{
			//trace("earth goomba up"); 
			var ea:EarthAir = new EarthAir();  
			addChild(ea);
		}
		public function goombaLevels(e:Event):void { 
		
		//see how many goomba have been fired - x goomba = level 1 
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