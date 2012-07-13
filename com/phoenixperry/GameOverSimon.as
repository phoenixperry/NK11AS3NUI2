package com.phoenixperry
	
{
	import com.phoenixperry.Node;
	
	import flash.display.Bitmap;
	import flash.events.Event;
	import flash.events.TimerEvent;
	import flash.media.Sound;
	import flash.media.SoundChannel;
	import flash.utils.Timer;
	import flash.geom.Point;
	
	import org.osflash.signals.Signal;
	import org.osmf.events.TimeEvent;
	import org.osmf.traits.PlayTrait;
	
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
		
		//walls 
		private var SIDE_WALL_THICKNESS:Number = 1; 
		private var SIDE_WALL_HEIGHT:Number = GameMain.GAME_HEIGHT; 
		private var LEFT_WALL_POSITION:Point; 
		private var RIGHT_WALL_POSITION:Point; 
		
		private var firstNode:Node; 
		private var currentNode:Node; 
		
		private var _btnNumbers:Vector.<String> = Vector.<String>(["1","2","3","4","5","6"]); 
		private var btnContainer:Sprite; 
		private var btnDownState:Texture;
		private var btnArray:Array = []; 
		private var currentNum:int; 
		private var myBtn:Button; 
		private var gb:GlowBody; 
		private var difficulty:Number = 3; 
		private var count:Number = 0; 
		private var solution:Array =[]; 
		private var playCount:Number = 0; 
		private var numRightAnswers:Number=0;
		public var endOfSequence:Signal; 
		public var firstPlay:Boolean; 
		public var runDemo:Timer; 
		private var patternTimer:Timer; 
		private var gameTimer:Timer; 
		public static var gameStarted:Boolean = false; 
		private var bouncer:Bouncer; 
		
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
			//when it's time to have instructions move this to a new function. 
			firstPlay = true; 
			runDemo = new Timer(2000,1); 
			runDemo.addEventListener(TimerEvent.TIMER, playDemo, false, 0, true); 
			if(firstPlay) runDemo.start();
			patternTimer = new Timer(1000); 
			patternTimer.addEventListener(TimerEvent.TIMER, playPattern, false, 0, true); 
			gameTimer = new Timer(2000);
			gameTimer.addEventListener(TimerEvent.TIMER, playGame, false, 0, true); 
			bouncer = new Bouncer(); 
			makeAWall(); 
		//	addChild(bouncer); 
		//	bouncer.x = 80; 
		//	bouncer.y = -100;
		
		}
		
//DEMO PLAY 
//these two functions will play a pattern at the current difficulty level and save that pattern into an array 
		public function playDemo(e:TimerEvent):void{ 
			//put text on screen for instruction if first run
			if (count == 0) { 
				solution.splice(0,solution.length); 
				//trace(solution.length, "solution's length");
				firstNode.node_data = firstNode.popRand();  
				btnArray[firstNode.node_data].colorMe();  
				solution.push(firstNode.node_data); 
				firstNode.rightAnswer.add(rightAnswer); 
				firstNode.wrongAnswer.add(wrongAnswer); 
				currentNode = firstNode.generateDemoNode(); 
				count++;
				patternTimer.start(); 
				
				
			
			} 
		}
		private function playPattern(e:TimerEvent):void { 
				if(count < difficulty){ 
					trace("if loop started"); 
					solution.push(currentNode.node_data); 
					currentNode.rightAnswer.add(rightAnswer); 
					currentNode.wrongAnswer.add(wrongAnswer); 
					trace("node made");
					count++; 
				///	trace(count, "i'm the count"); 
					//trace(solution.length, "solution's length after the loop");
					if(firstPlay){
					btnArray[currentNode.node_data].colorMe(); 
					currentNode = currentNode.generateDemoNode(); 
					firstPlay = false; 
					}
					else { 
						currentNode = currentNode.generateDemoNode(); 
						btnArray[currentNode.node_data].colorMe();
					}
				}
			if(count == difficulty-1) { 
			count = 0; 
			difficulty ++; 
			trace(difficulty, "I'm the difficulty"); 
			patternTimer.stop(); 
			gameTimer.start(); 
			gameTimer.start();  
				//only for debug 
				for (var i:int = 0; i < solution.length; i++) 
				{
					trace(solution[i], " is", "solution ", i ); 
				}
			}
		}
		
		public function playGame(e:TimerEvent):void { 
			//after demo loop take the btns white
			gameStarted = true; 
			if(count ==0) { 
				for (var i:int = 0; i < btnArray.length; i++) 
				{
					btnArray[i].whiteOut(); 
		
				}	
			}
			
		}
		
		public  function compare(myName:Number):void{ 
			if(count==0 ){
				//if we are at the start of the loop get the first item in the chain. 
				currentNode = firstNode.compareNode(myName); 
				count++;
			}
			else { 
			//if we are on any current node, compare and get the next node in the chain
			
			currentNode = currentNode.compareNode(myName); 
//			trace(myName, "is my name"); 
			}
			//up count to we don't loop back to the start.  
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
				count = 0; 
				numRightAnswers = 0; 
				//currentNode = null; 
				runDemo.start(); 
				gameTimer.stop(); 
				firstPlay = true;
				gameStarted = false; 
				
			}
		}		

		private function endSequence():void
		{
			//currentNode = firstNode; 
			trace("end of sequence"); 
			//re run game
			// TODO Auto Generated method stub
		}
		
		private function drawBtns():void
		{
			for (var i:int = 0; i < _btnNumbers.length; i++) 
			{	
				var btn:BallBtn = new BallBtn(sound1, i, i*100, 150); 
				addChild(btn); 
				btn.iwasTouched.add(compare); 
				btnArray.push(btn); 
			}
			btnContainer.x = stage.stageWidth- btnContainer.width >>1; 
			btnContainer.y = stage.stageHeight - btnContainer.height >>1; 
			addChild(btnContainer);
		}
		
		private function makeAWall():void {
			LEFT_WALL_POSITION = new Point(0,0); 
			RIGHT_WALL_POSITION = new Point(GameMain.GAME_WIDTH, 0); 
			var BTM_WALL_POSITION:Point = new Point(0, GameMain.GAME_HEIGHT); 
			
			var wallShapeCoords:Array = new Array(); 
			wallShapeCoords.push(
				new Array( 
					new Point(0,0), 
					new Point(SIDE_WALL_THICKNESS, 0),
					new Point(SIDE_WALL_THICKNESS, SIDE_WALL_HEIGHT),
					new Point(0, SIDE_WALL_HEIGHT)
				)
			); 
			var floorCoords:Array = new Array(); 
			floorCoords.push(
				new Array(
					new Point(0, 0), 
					new Point(GameMain.GAME_WIDTH, 0), 
					
					new Point(GameMain.GAME_WIDTH, SIDE_WALL_THICKNESS), 
					new Point(0, SIDE_WALL_THICKNESS)
				)
			); 
			
			//add left wall 
			var leftWall:ArbiStaticActor = new ArbiStaticActor(this, LEFT_WALL_POSITION, wallShapeCoords); 
			//items.push(leftWall); 
			
			var rightWall:ArbiStaticActor = new ArbiStaticActor(this, RIGHT_WALL_POSITION, wallShapeCoords); 
			//items.push(rightWall); 
			
			var btmWall:ArbiStaticActor = new ArbiStaticActor(this, BTM_WALL_POSITION, floorCoords); 
			
		}
		
		//l2 
	}
}