package com.phoenixperry
	
{
	import com.phoenixperry.Node;
	
	import flash.display.Bitmap;
	import flash.events.Event;
	import flash.media.Sound;
	import flash.media.SoundChannel;
	
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
		
		private var firstNode:Node; 
		private var currentNode:Node; 
		
		private var _btnNumbers:Vector.<String> = Vector.<String>(["1","2","3","4","5","6"]); 
		private var btnContainer:Sprite; 
		private var btnDownState:Texture;
		private var btnArray:Array = []; 
		private var currentNum:int; 
		private var myBtn:Button; 
		private var gb:GlowBody; 
		private var difficulty:Number = 2; 
		private var firstPlay:Boolean=true; 
		private var count:Number = 0; 
		private var solution:Array =[]; 
		private var demoMode:Boolean = true;
		public function GameOverSimon()
		{
			//dataType(); 
			trace("GameOverSimon created"); 
			addEventListener(starling.events.Event.ADDED_TO_STAGE, startUp); 
			btnContainer = new Sprite(); 	
		}	
		
		private function startUp(e:starling.events.Event):void
		{
			gb = new GlowBody(); 
			addChild(gb); 
			removeEventListener(starling.events.Event.ADDED_TO_STAGE, startUp); 
			drawBtns(); 
			
			currentNode = new Node(0); 
			currentNode.rightAnswer.add(rightAnswer);
			currentNode.wrongAnswer.add(wrongAnswer);
			currentNode.endOfSequence.add(endOfSequence);
			addEventListener(starling.events.Event.ENTER_FRAME, onEnter); 
			if(firstPlay)startGame();
		}
		
		private function endOfSequence():void
		{
			currentNode = firstNode; 
			
			//re run game
			// TODO Auto Generated method stub
		}
		
		private function wrongAnswer():void
		{
			// TODO Auto Generated method stub
			//end 
		}
		
		private function rightAnswer():void
		{
			// TODO Auto Generated method stub	
			//graphics?? 
		}
		private function  onEnter(e:starling.events.Event):void { 
			
		}
		private function drawBtns():void
		{
			//nope you're going to need an object for each btn and it's gotta know it's number and it's sound 
			//when it's triggered it's gotta send a singal
			
			for (var i:int = 0; i < _btnNumbers.length; i++) 
			{	
				var btn:BallBtn = new BallBtn(sound1, i, i*100, 150); 
				addChild(btn); 
	
				btn.iwasTouched.add(compare); 
				btn.soundDone.add(nextSound); 
				btnArray.push(btn); 
			}
			
			//	btnContainer.addEventListener(Event.TRIGGERED, onTriggered); 
			
			btnContainer.x = stage.stageWidth- btnContainer.width >>1; 
			btnContainer.y = stage.stageHeight - btnContainer.height >>1; 
			addChild(btnContainer);
		
		}
		
//DEMO PLAY 
//these two functions will play a pattern at the current difficulty level and save that pattern into an array 
		public function startGame():void{ 
			//put text on screen for instruction if first run
			var num:Number = popRand(); 
			btnArray[num].colorMe(); 
			firstNode = new Node(num); 
			firstPlay=false; 
			currentNode = firstNode.generateDemoNode();
			solution.push(num); 

		}
		
		private function nextSound():void
		{
			//this is trigger through an end sound signal
			if(count < difficulty){ 
			var num:Number = popRand();
			btnArray[num].colorMe(); 
			currentNode.node_data = num; 
			trace(currentNode.node_data, "im the node data", "i'm the btn lighting up", num); 
			// TODO Auto Generated method stub
			count++; 
			solution.push(num);
			trace("solution is", num); 
			currentNode = currentNode.generateDemoNode(); 
			}	
			demoMode = false; 
	}	
		
		public  function compare(myName:Number):void{ 
	
			trace("my name is" , myName); 
//			trace(myName, "is my name"); 
//			

			//for each touch - get the myName. get the name of the current object. if the name matches the touch - get the next one. If not - flip on 
			//end screen 
			//count++ 
			//}
			
		}
		
		
		private function popRand():Number { 
			var rand:Number = int(Math.random()*6);
			//trace(btnArray[rand], rand); 
			return rand; 
		}
		
		//		private function onTriggered(e:Event):void
		//		{
		//			trace(e.currentTarget, e.target); 
		//			trace("triggered"); 
		//			var btn:Button = e.target as Button; 
		//			getRandomBtn(); 
		//			
		//		}
		//		
		//
		
		
		
		
		
		//l2 
	}
}