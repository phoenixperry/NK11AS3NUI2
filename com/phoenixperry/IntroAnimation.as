package com.phoenixperry
{
	import com.greensock.*;
	import com.greensock.easing.*;
	
	import flash.display.Bitmap;
	import flash.events.TimerEvent;
	import flash.utils.Timer;
	
	import org.osflash.signals.Signal;
	
	import starling.animation.Tween;
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
		private var triBtm:MovieClip; 
		private var fear:MovieClip; 
		private var timer:Timer; 
		private var leftCube:MovieClip; 
		private var rightCube:MovieClip; 
		public var animationComplete:Boolean = false; 
		
		public function IntroAnimation()
		{
			addEventListener(Event.ADDED_TO_STAGE, onAdded);  
			timer = new Timer(500); 
			timer.addEventListener(TimerEvent.TIMER, runAnimation); 
		}
		
		 private function onAdded(e:Event):void
		{	timer.start(); 
			removeEventListener(Event.ADDED_TO_STAGE, onAdded); 	
			sprites = new StarSpriteCostume("triUp", 1);
			triUp = sprites.getDressed();
			triUp.x = stage.stageWidth/2 - triUp.width/2; 
			triUp.y = -200; 
			triUp.alpha = 0; 
			addChild(triUp); 
			
			sprites = new StarSpriteCostume("triBtm",1); 
			triBtm = sprites.getDressed(); 
			triBtm.x = stage.stageWidth/2 - triBtm.width / 2 ; 
			triBtm.y = 1024; 
			triBtm.alpha = 0; 
			addChild(triBtm);
			
			sprites = new StarSpriteCostume("fearInstructions",1); 
			fear = sprites.getDressed(); 
			fear.x = stage.stageWidth/2 - fear.width/2;
			fear.y = (stage.stageHeight/2 - fear.height/2)+30; 
			fear.alpha = 0; 
			addChild(fear); 
		
		 	sprites = new StarSpriteCostume("rightCube", 1); 
			rightCube = sprites.getDressed(); 
			rightCube.x = 697;
			rightCube.y = 1024;
			rightCube.alpha = 0; 
			addChild(rightCube); 
			
			sprites = new StarSpriteCostume("leftCube",1); 
			leftCube = sprites.getDressed(); 
			leftCube.x = 128;
			leftCube.y = 1024;
			leftCube.alpha = 0; 
			addChild(leftCube); 
			
		 }
		
		 public function runAnimation(e:TimerEvent):void { 
			if(timer.currentCount == 1) { 
				//fade in the instructions 
				TweenLite.to(fear, 3, {x:stage.stageWidth/2 - fear.width/2, y:stage.stageHeight/2 - fear.height/2, alpha:1,ease:Circ.easeOut});
			}
			if(timer.currentCount ==18) { 
				//fade out instructions 
				TweenLite.to(fear, 1, {x:stage.stageWidth/2 - fear.width/2, y:stage.stageHeight/2 - fear.height/2, alpha:0,ease:Circ.easeOut});
			}
			 if(timer.currentCount == 20){ 
				 TweenLite.to(triUp, 1, {x:stage.stageWidth/2 - triUp.width/2, y:60, alpha:1,ease:Circ.easeOut});
			 }
			 if(timer.currentCount ==20) { 
				 TweenLite.to(triBtm, 1, {x:stage.stageWidth/2 -triBtm.width/2, y:140, alpha:1,ease:Circ.easeOut}); 
			 }
			 
			 if(timer.currentCount == 24) {
				TweenLite.to(leftCube, .5, {x:128, y:537, alpha:1, ease:Circ.easeOut});
				
			 }
			 if(timer.currentCount ==26) { 
				 TweenLite.to(rightCube, .5, {x:697, y:528, alpha:1, ease:Circ.easeOut}); 
			 }
			 if(timer.currentCount==30) { 
				 TweenLite.to(triUp, 1, {x:stage.stageWidth/2 - triUp.width/2, y:60, alpha:0,ease:Circ.easeOut});
				 TweenLite.to(triBtm, 1, {x:stage.stageWidth/2 -triBtm.width/2, y:140, alpha:0,ease:Circ.easeOut}); 
				 TweenLite.to(leftCube, .5, {x:128, y:537, alpha:0, ease:Circ.easeOut});
				 TweenLite.to(rightCube, .5, {x:697, y:528, alpha:0, ease:Circ.easeOut}); 
			 }
			 if(timer.currentCount == 35) {
				animationComplete = true; 
				this.destroy(); 
			 }
		 }
		 public function destroy():void { 
		 	this.removeEventListeners(); 
			this.removeChildren(); 
			this.dispose(); 
			
		 }
		 
	
		 //l2
	}
}