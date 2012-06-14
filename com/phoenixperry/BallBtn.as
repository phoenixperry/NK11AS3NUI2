package com.phoenixperry
{
	import com.greensock.TweenLite;
	
	import flash.display.Bitmap;
	import flash.events.Event;
	import flash.events.TimerEvent;
	import flash.media.Sound;
	import flash.media.SoundChannel;
	import flash.net.URLRequest;
	import flash.utils.Timer;
	
	import flashx.textLayout.debug.assert;
	
	import org.osflash.signals.Signal;
	
	import starling.core.Starling;
	import starling.display.Button;
	import starling.display.MovieClip;
	import starling.display.Quad;
	import starling.display.Sprite;
	import starling.events.Event;
	import starling.textures.Texture;
	
	public class BallBtn extends Sprite{

		private var btnSkin:Bitmap; 
		private var btnTexture:Texture; 
		public var myBtn:Button; 
		private var _xpos:Number; 
		private var _ypos:Number;
		public var myName:Number; 
		public var tone:*;  
		private static var _rhxpos:Number; 
		private static var _rhypos:Number; 
		private var w:Number=50; 
		private var h:Number=50; 
		public var touched:Boolean; 
		private var immunityTime:Timer; 
		private var quad:Quad; 
		private var quadMc:MovieClip; 
		public var iwasTouched:Signal; 
		private var patternDemoTimer:Timer;
		public var sc:SoundChannel; 
		
		public var soundDone:Signal; 
		
		public function BallBtn( _sound:Class,  _name:Number, xpos:Number,  ypos:Number)
		{
			iwasTouched = new Signal(); 
			quad = new Quad(w,h,0xFFFFFF,true); 
			quad.x = xpos; 
			quad.y = ypos; 
			addChild(quad); 
			
			 _xpos = xpos; 
			 _ypos = ypos; 
			myName = _name; 			
			addEventListener(starling.events.Event.ADDED_TO_STAGE, onAdded); 
			immunityTime = new Timer(2000,1); 
			//immunity timer
			immunityTime.addEventListener(TimerEvent.TIMER, onTimerComplete, false, 0, true); 
			tone= new _sound(); 
			sc = new SoundChannel(); 

			soundDone = new Signal(); 
			patternDemoTimer = new Timer(2000, 1); 
		
			
		}

		protected function soundPlayed(event:flash.events.Event):void
		{
			soundDone.dispatch();	
		}		

		
		protected function onTimerComplete(event:TimerEvent):void
		{
			//trace("no longer immune"); 
			//touched = false; 

		}
		
		private function onAdded(e:starling.events.Event):void {
			removeEventListener(starling.events.Event.ADDED_TO_STAGE, onAdded); 
			addEventListener(starling.events.Event.ENTER_FRAME,cHit); 	
			iwasTouched.add(playSound); 
		}
		private function playSound(myName:Number):void { 
			sc = tone.play(); 
			//sc.soundTransform.volume(0.2);
			sc.addEventListener(flash.events.Event.SOUND_COMPLETE, soundPlayed, false, 0, true);
			//WARNING LIKE A MOFO - this might cause a memory leak
	
			
			touched = false;
		}
		
		private function cHit(e:starling.events.Event):void
		{
			
			if(GameMain.useKinect) {
				
				if((_rhxpos >= _xpos) && (_rhxpos <= _xpos+w) && (_rhypos >= _ypos) && (_rhypos <= _ypos +height) && touched ==false) 
				{
					trace(myName, "I've been touched!"); 
					immunityTime.start(); 
					quad.color = 0xFF00FF; 
				
					touched = true; 
				}

			}
			
			if(!GameMain.useKinect) {
				if(( GlowBody.xpos>= _xpos) && (GlowBody.xpos <= _xpos+w) && (GlowBody.ypos >= _ypos) && (GlowBody.ypos <= _ypos +height)&& touched ==false) 
				{		
					iwasTouched.dispatch(myName);   
					trace(myName, "I've been touched!"); 
					if(!immunityTime.running)immunityTime.start(); 
					quad.color = 0xFF00FF;
					touched = true; 
					
				}
		
			
			}

		
		}
			
		public function colorMe():void {
			quad.color = 0xFF0000; 
			//TweenLite.to(this, 1, {tint:0xffffff});
			
			patternDemoTimer.start();
			playSound(myName);
			
			
		}


		public static function get rhypos():Number
		{
			return _rhypos;
		}

		public static function set rhypos(value:Number):void
		{
			_rhypos = value;
		}

		public static function get rhxpos():Number
		{
			return _rhxpos;
		}

		public static function set rhxpos(value:Number):void
		{
			_rhxpos = value;
		}


	}
}