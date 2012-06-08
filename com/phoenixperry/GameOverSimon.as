package com.phoenixperry

{
	import com.phoenixperry.Node;
	
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
	
	

		
		private var n1:Node = new Node(12); 
		private var n2:Node = new Node(99); 
		private var n3:Node = new Node(37); 
	
		private var _btnNumbers:Vector.<String> = Vector.<String>(["1","2","3","4","5","6"]); 
		private var btnContainer:Sprite; 
		private var btnDownState:Texture;
		private var btnArray:Array = []; 
		
		private var currentNum:int; 
		private var myBtn:Button; 
		private var gb:GlowBody; 
		
		public function GameOverSimon()
		{	
			//dataType(); 
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
			}
			
	//	btnContainer.addEventListener(Event.TRIGGERED, onTriggered); 
		
		btnContainer.x = stage.stageWidth- btnContainer.width >>1; 
		btnContainer.y = stage.stageHeight - btnContainer.height >>1; 
		addChild(btnContainer);

		}
		
//		private function getRandomBtn():void { 
//			var rand:Number = int(Math.random()*6);
//			trace(btnArray[rand], rand); 
//			
//		}
//		
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
//		protected function dataType() :void { 
//			n2.insert_prev(n1); 
//			n2.insert_next(n3); 
//			trace(n1.get_next_node().get_next_node().get_node_data(), "I'm from the linked list");
//			//each get_next_node moved you up and down the the list from that position. get data
//			//gets data
//		}
//l2 
	}
}