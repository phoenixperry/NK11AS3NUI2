package com.phoenixperry
	
{
	import com.phoenixperry.Node;
	
	import flash.display.Bitmap;
	import flash.events.Event;
	import flash.events.TimerEvent;
	import flash.media.Sound;
	import flash.media.SoundChannel;
	import flash.utils.Timer;
	
	import org.as3commons.collections.utils.NullComparator;
	import org.osflash.signals.Signal;
	
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
		private var count:Number = 0; 
		private var solution:Array =[]; 
		private var demoMode:Boolean = true;
		private var playCount:Number = 0; 
		private var numRightAnswers =0;
		public var endOfSequence:Signal; 
		public var firstPlay:Boolean; 
		public var runDemo:Timer; 
		public function GameOverSimon()
		{
			//dataType(); 
			trace("GameOverSimon created"); 
			addEventListener(starling.events.Event.ADDED_TO_STAGE, startUp); 
			btnContainer = new Sprite(); 	
	
		}	
		
		private function startUp(e:starling.events.Event):void
		{
			if(!GameMain.useKinect) { 
				gb = new GlowBody(); 
				addChild(gb); 
			}
			removeEventListener(starling.events.Event.ADDED_TO_STAGE, startUp); 
			drawBtns(); 
			currentNode = new Node(0); 
			firstNode = new Node(0); 
			currentNode.rightAnswer.add(rightAnswer);
			currentNode.wrongAnswer.add(wrongAnswer);
			endOfSequence = new Signal();
			endOfSequence.add(endSequence); 
			addEventListener(starling.events.Event.ENTER_FRAME, onEnter); 
			//when it's time to have instructions move this to a new function. 
			firstPlay = true; 
			runDemo = new Timer(2000,1); 
			runDemo.addEventListener(TimerEvent.TIMER, startGame, false, 0, true); 
			if(firstPlay) runDemo.start(); 
		}
		
		
		private function  onEnter(e:starling.events.Event):void { 
		}
		
		private function drawBtns():void
		{
			for (var i:int = 0; i < _btnNumbers.length; i++) 
			{	
				var btn:BallBtn = new BallBtn(sound1, i, i*100, 150); 
				addChild(btn); 
				btn.iwasTouched.add(compare); 
				btn.soundDone.add(nextSound); 
				btnArray.push(btn); 
			}
			btnContainer.x = stage.stageWidth- btnContainer.width >>1; 
			btnContainer.y = stage.stageHeight - btnContainer.height >>1; 
			addChild(btnContainer);
		}
		
//DEMO PLAY 
//these two functions will play a pattern at the current difficulty level and save that pattern into an array 
		public function startGame(e:TimerEvent):void{ 
			//put text on screen for instruction if first run
			solution.splice(0,solution.length); 
			trace(solution.length, "solution's length");
			firstNode.node_data = firstNode.popRand();  
			btnArray[firstNode.node_data].colorMe();  
			solution.push(firstNode.node_data); 
			currentNode = firstNode.generateDemoNode();
			firstNode.rightAnswer.add(rightAnswer); 
			firstNode.wrongAnswer.add(wrongAnswer); 
			trace(firstNode.node_data, firstNode.get_next_node().node_data);
			trace(count); 
		}
		private function demoPlay():void {
			//this block runs only if in demo mode 
			if(count < difficulty){ 
				trace("if loop started"); 
				btnArray[currentNode.node_data].colorMe(); //turns white starts patternDemoTimer plays sound 
			//	trace(currentNode.node_data, "im the node data", "i'm the btn lighting up", num); 
				count++; 
				solution.push(currentNode.node_data); 
				trace("solution is", currentNode.node_data); 
				currentNode.rightAnswer.add(rightAnswer); 
				currentNode.wrongAnswer.add(wrongAnswer); 
				currentNode = currentNode.generateDemoNode(); 
				demoMode = false; 
				trace("node made");
			}
			count = 0; 
			difficulty++; 
			trace(difficulty, "I'm the difficulty"); 
		}
		private function nextSound():void
		{
			//runs at the end of every sound 
			if(demoMode) { 
				demoPlay(); 
			}
			else{
			playGame(); 
			}			
	}	
		
		public function playGame():void { 
			//after demo loop take the btns white
			if(count ==0) { 
				for (var i:int = 0; i < btnArray.length; i++) 
				{
					btnArray[i].whiteOut(); 
				}	
			}
			
		}
		
		public  function compare(myName:Number):void{ 
			if(count==0){
				//if we are at the start of the loop get the first item in the chain. 
				currentNode = firstNode.compareNode(myName); 
			}
			else { 
				trace(myName, "i'm casuing the crash"); 
			//if we are on any current node, compare and get the next node in the chain
			currentNode = currentNode.compareNode(myName); 
//			trace(myName, "is my name"); 
			}
			//up count to we don't loop back to the start.  
			count++; 
		}

		private function wrongAnswer(n:Number):void	
		{
			trace(n, "im a wrong answer"); 
			
		}
		
		private function rightAnswer():void
		{
			numRightAnswers++; 
			trace("right answer");
			// TODO Auto Generated method stub	
			//graphics??  
			if(numRightAnswers == solution.length){ 
				for (var i:int = 0; i < btnArray.length; i++) 
				{
					btnArray[i].whiteOut(); 
				}	
				runDemo.start(); 
				count =0; 
				numRightAnswers = 0; 
				currentNode = null; 
				
			}
		}		

		private function endSequence():void
		{
			currentNode = firstNode; 
			trace("end of sequence"); 
			//re run game
			// TODO Auto Generated method stub
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