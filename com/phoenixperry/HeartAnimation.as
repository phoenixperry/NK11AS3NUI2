package com.phoenixperry
{	
	import com.greensock.*;
	import com.greensock.easing.*;
	
	import flash.display.Bitmap;
	import flash.events.TimerEvent;
	import flash.media.Sound;
	import flash.media.SoundChannel;
	import flash.utils.Timer;
	
	import org.osflash.signals.Signal;
	
	import starling.animation.Tween;
	import starling.display.MovieClip;
	import starling.display.Sprite;
	import starling.events.Event;
	import starling.textures.Texture;
	import starling.textures.TextureAtlas;
	
	public class HeartAnimation extends Sprite
	{
		public var sc:SoundChannel; 
		public var soundDone:Signal; 
		
		[Embed(source="./assets/gameOver/sounds/heart2.mp3", mimeType="audio/mpeg")] 
		private var heart:Class; 
		
		private var sprites:StarSpriteCostume; 
		private var whiteHeart:MovieClip; 
		private var timer:Timer; 
		public var animationComplete:Boolean = false; 
		private var tone:*; 
		private var speed:Number = 0.5; 
		
		public function HeartAnimation()
		{
			addEventListener(Event.ADDED_TO_STAGE, onAdded);  
			timer = new Timer(500); 
			timer.addEventListener(TimerEvent.TIMER, runAnimation); 
		}
		private function onAdded(e:starling.events.Event):void
		{	timer.start(); 
			removeEventListener(Event.ADDED_TO_STAGE, onAdded); 	
			sprites = new StarSpriteCostume("whiteHeart", 1);
			whiteHeart = sprites.getDressed();
			
			whiteHeart.alpha = .5; 
			whiteHeart.x = 0 + whiteHeart.width/2;
			whiteHeart.y = 0+whiteHeart.height/2;
			whiteHeart.color = 0xa32827; 
			whiteHeart.pivotX = whiteHeart.width/2; 
			whiteHeart.pivotY = whiteHeart.height/2; 
			whiteHeart.scaleX  = 0.5; 
			whiteHeart.scaleY = 0.5; 
			
			addChild(whiteHeart);
			tone = new heart(); 
			sc = new SoundChannel(); 
		}
		private function runAnimation(e:TimerEvent):void { 
	
			
			if(timer.currentCount%2) { 
				beat();
			}
			
			else { 
				beatIn(); 
			}
			
		}
		
		
		
		private function beat():void { 

			TweenLite.to(whiteHeart, .4, {scaleX:1, scaleY:1, alpha:1});
			playSound(); 
		}
		private function beatIn():void { 
			TweenLite.to(whiteHeart, .4, {scaleX:.5, scaleY:.5, alpha:.5});
		}
		private function playSound():void { 
			sc = tone.play();
			//for continual looping 
			//sc.addEventListener(Event.SOUND_COMPLETE, onComplete);
		}
		public function stopSound():void{ 
			//sc = tone.stop(); 
			timer.stop(); 
		}
//endless loop
//		function onComplete(event:Event):void
//		{
//			sc(event.target).removeEventListener(event.type, onComplete);
//			playSound();
//		}
	}
}