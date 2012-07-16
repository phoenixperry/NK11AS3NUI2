package com.phoenixperry
{
	import com.greensock.*;
	import com.greensock.easing.*;
	
	import flash.display.Bitmap;
	import flash.events.TimerEvent;
	import flash.utils.Timer;
	
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

	public class IntroAnimation extends Sprite
	{
		private var sprites:StarSpriteCostume; 
		private var triUp:MovieClip; 
		private var triDown:MovieClip; 
		
		public function IntroAnimation()
		{
			addEventListener(Event.ADDED_TO_STAGE, onAdded);  
		
		}
		
		 private function onAdded(e:Event):void
		{
			removeEventListener(Event.ADDED_TO_STAGE, onAdded); 	
			sprites = new StarSpriteCostume("triUp", 1);
			triUp = sprites.getDressed();
			triUp.x = stage.stageWidth/2 - triUp.width/2; 
			triUp.y = 60; 
			addChild(triUp); 
			
			sprites = new StarSpriteCostume("triDown",1); 
			triDown = sprites.getDressed(); 
			triDown.x = stage.stageWidth/2 - triDown.width / 2 ; 
			triDown.y = 140; 
			addChild(triDown); 
		}
		 
	}
}