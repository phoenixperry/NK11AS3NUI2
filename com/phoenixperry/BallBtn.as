package com.phoenixperry
{
	import flash.display.Bitmap;
	import flash.events.TimerEvent;
	import flash.media.Sound;
	import flash.net.URLRequest;
	import flash.ui.Mouse;
	import flash.utils.Timer;
	
	import flashx.textLayout.debug.assert;
	
	import org.osflash.signals.Signal;
	
	import starling.display.Button;
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
		private var tone:*;  
		private static var _rhxpos:Number; 
		private static var _rhypos:Number; 
		private var w:Number=50; 
		private var h:Number=50; 
		public var touched:Boolean; 
		private var immunityTime:Timer; 
		private var quad:Quad; 
		
		public var iwasTouched:Signal; 
		
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
			addEventListener(Event.ADDED_TO_STAGE, onAdded); 
			immunityTime = new Timer(2000,1); 
			//immunity timer
			immunityTime.addEventListener(TimerEvent.TIMER_COMPLETE, onTimerComplete); 
			tone= new _sound(); 
		}
		

		
		protected function onTimerComplete(event:TimerEvent):void
		{
			
			trace("no longer immune"); 
			touched = false; 
			
		}
		
		private function onAdded(e:Event):void {
			removeEventListener(Event.ADDED_TO_STAGE, onAdded); 
			addEventListener(Event.ENTER_FRAME,cHit); 	
		}
		private function playSound():void { 
			touched = false;
			tone.play(); 
		}
		
		private function cHit(e:Event):void
		{
			
			if(GameMain.useKinect) {
				
				if((_rhxpos >= _xpos) && (_rhxpos <= _xpos+w) && (_rhypos >= _ypos) && (_rhypos <= _ypos +height) && touched ==false) 
				{
					trace(myName, "I've been touched!"); 
					immunityTime.start(); 
					quad.color = 0xFF00FF; 
					tone.play(); 
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
	
					tone.play(); 
				}
		
			
			}

		
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