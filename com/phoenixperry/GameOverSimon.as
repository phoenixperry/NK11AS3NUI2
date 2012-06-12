package com.phoenixperry

{
	import flash.display.Bitmap;
	import flash.media.Sound;
	
	import starling.display.Button;
	import starling.display.Image;
	import starling.display.Sprite;
	import starling.events.Event;
	import starling.textures.Texture; 
	
	public class GameOverSimon extends Sprite
	{
		[Embed(source="./assets/gameOver/sounds/1.mp3", mimeType="audio/mpeg")] 
		private var sound1:Class; 
		
		[Embed(source="./assets/gameOver/sounds/2.mp3", mimeType="audio/mpeg")] 
		private var sound2:Class; 
		
		[Embed(source="./assets/gameOver/sounds/3.mp3", mimeType="audio/mpeg")] 
		private var sound3:Class; 
		
		[Embed(source="./assets/gameOver/sounds/4.mp3", mimeType="audio/mpeg")] 
		private var sound4:Class; 
		
		[Embed(source="./assets/gameOver/sounds/5.mp3", mimeType="audio/mpeg")] 
		private var sound5:Class; 
		
		[Embed(source="./assets/gameOver/sounds/6.mp3", mimeType="audio/mpeg")] 
		private var sound6:Class; 
		
		[Embed(source="./assets/gameOver/sounds/7.mp3", mimeType="audio/mpeg")] 
		private var sound7:Class; 
		
	
		private var _btnNumbers:Vector.<String> = Vector.<String>(["1","2","3","4","5","6"]); 
		private var btnContainer:Sprite; 
		private var btnDownState:Texture;
		private var btnArray:Array = []; 
		
		private var currentNum:int; 
		private var myBtn:Button; 
		private var gb:GlowBody; 
		private var list:LinkedList; 
		private var count:Number = 0; 
		private var currentCount:Number = 0; 
		public function GameOverSimon()
		{
			trace("GameOverSimon created"); 
			addEventListener(Event.ADDED_TO_STAGE, startUp); 
			btnContainer = new Sprite(); 	
		}	
		
		private function startUp(e:Event):void
		{
			gb = new GlowBody(); 
			addChild(gb); 
			removeEventListener(Event.ADDED_TO_STAGE, startUp); 
			drawBtns(); 
			addEventListener(Event.ENTER_FRAME, onEnter); 
	
			var num:Number = popRand(); 
			list = new LinkedList(num,4,3,2,1,3,4,2,4,2,4,2,4,2,3,2,4,1); 
			trace(list.length, "linked list working right"); 
		}
		private function  onEnter(e:Event):void { 
			
		}
		private function drawBtns():void
		{
			//nope you're going to need an object for each btn and it's gotta know it's number and it's sound 
			//when it's triggered it's gotta send a singal
			
			for (var i:int = 0; i < _btnNumbers.length; i++) 
			{	
				var btn:BallBtn = new BallBtn(sound1, i, i*100, 150); 
				addChild(btn); 
				trace(i*50); 
				btn.iwasTouched.add(compare); 
				btnArray.push(btn); 
			}
			
	//	btnContainer.addEventListener(Event.TRIGGERED, onTriggered); 
		btnContainer.x = stage.stageWidth- btnContainer.width >>1; 
		btnContainer.y = stage.stageHeight - btnContainer.height >>1; 
		addChild(btnContainer);
		}
		// run me when the singal is send a box is touched. send the myName field w/the signal


		public  function compare(myName:Number):void{ 
			
			trace("my name is" , myName); 
			//var num = list.elementAt(2) as Number;
//			trace(num, "ll item 2");
			trace(list.elementAt(1));	
	
		}
		private function popRand():Number { 
			var rand:Number = int(Math.random()*6);

			return rand
		}
		
//l2 
	}
}