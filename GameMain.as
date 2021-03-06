 package 
{
	import Box2D.Collision.Shapes.b2CircleShape;
	import Box2D.Common.Math.b2Vec2;
	import Box2D.Dynamics.b2Body;
	import Box2D.Dynamics.b2BodyDef;
	import Box2D.Dynamics.b2DebugDraw;
	import Box2D.Dynamics.b2Fixture;
	import Box2D.Dynamics.b2FixtureDef;
	import Box2D.Dynamics.b2World;
	
	import com.greensock.TweenLite;
	import com.phoenixperry.GameOverSimon;
	import com.phoenixperry.HeartAnimation;
	import com.phoenixperry.HeroFont;
	
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.Sprite;
	import flash.events.DataEvent;
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.events.TimerEvent;
	import flash.geom.Point;
	import flash.media.SoundChannel;
	import flash.media.SoundTransform;
	import flash.net.XMLSocket;
	import flash.printing.PrintJob;
	import flash.text.Font;
	import flash.ui.Keyboard;
	import flash.utils.Timer;
	
	import org.osflash.signals.Signal;
	
	import starling.core.Starling;
	import starling.display.Image;
	import starling.display.Sprite;
	import starling.display.Stage;
	import starling.events.EnterFrameEvent;
	import starling.events.Event;
	import starling.events.KeyboardEvent;
	import starling.events.Touch;
	import starling.events.TouchEvent;
	import starling.events.TouchPhase;
	import starling.text.TextField;
	import starling.textures.Texture;
	import starling.utils.Stats;
	import flash.ui.Mouse;
	
	public class GameMain extends Sprite
	{
		private static const _useKinect:Boolean = true ; 

		[Embed(source="assets/gameOver/fonts/Gotham-Light.otf", embedAsCFF="false",fontName="Gotham")]
		public static var Gotham:Class; 
		
		[Embed(source="./assets/gameOver/sounds/drone.mp3", mimeType="audio/mpeg")] 
		private var bgSound:Class; 
		
		
		public var killAll:Boolean = false; 
		//reset var
		
		//this is the count of remaining glowbodies 
		public static var countGlows:Number; 
		
		//font
		private var font:Font; 
		private var gameOverStart:GameOverStart;
	    private var k:KinectOn;
	
		private var _mouseX:Number = 0;
		private var _mouseY:Number = 0;
			
		public static var RATIO:Number = 30;
		private static var _world:b2World; 
		public static const GAME_WIDTH:Number = 1024; 
		public static const GAME_HEIGHT:Number = 768;  
		public static var loadLevelOne:Boolean= false; 
		public static var loadLevelTwo:Boolean = false; 
		public var gameOverLevel1:GameOverLevel1; 
		public var gameOverSimonA:GameOverSimon; 
		private var makeSprites:SingletonSpriteSheet; 
		
		private var gameTimer:GameTimer; 
		private var levelOneRunning:Signal; 
	
		private static var _serialServer:XMLSocket;
		private static var _attackBtn:Number;
		private static var _speedKnob:Number; 
		private static var _getX:Number; 
		private static var _getY:Number;

		public static var ipadActive:Boolean = false; 
		private var ipadCheck:Timer; 
		private var myX:Number; 
		private var myY:Number; 
		public static var kPoint:Point; 

		public  var sc:SoundChannel; 
		public var bg:*; 
		
		
		public function GameMain() 
		{
			makeSprites = SingletonSpriteSheet.getInstance();
			addEventListener(starling.events.Event.ADDED_TO_STAGE, onAdded);
			initServer(); 
		}
		private function onAdded(e:starling.events.Event):void
		{
		
			//set up font
			font = new Gotham(); 
			setupPhysicsWorld();
			gameTimer = new GameTimer(); 
		
			removeEventListener(starling.events.Event.ADDED_TO_STAGE, onAdded); 

			
				stage.addEventListener(KeyboardEvent.KEY_DOWN, deleteLevel);
				stage.addEventListener(KeyboardEvent.KEY_DOWN, levelCreator);
			
			addEventListener(starling.events.Event.ENTER_FRAME, gameLoop); 

			ipadCheck = new Timer(200); 
			ipadCheck.addEventListener(TimerEvent.TIMER, checkit); 
			
			myX = 0; 
			myY = 0; 
			
			bg= new bgSound(); 
			sc = new SoundChannel(); 
			playSound();
			autoStart(); 
			
		}
		
		private function checkit(e:TimerEvent):void { 
			if(myX == getX && myY == getY) { 
				ipadActive = false; 
			}else{
				ipadActive = true; 
			}
			trace(ipadActive); 
			myX=getX; 
			myY=getY; 
		}
		
		private function updateW(e:starling.events.Event):void
		{
			var timeStep:Number = 1 / 60;
			var velocityIterations:int = 6;
			var positionIterations:int = 2;
		
			_world.Step(timeStep, velocityIterations, positionIterations);
			_world.ClearForces();
			_world.DrawDebugData();
			
		}		
		//this function sets the game up to auto loop once it's been started via keypress 
		private function restart():void {  
		; 
			gameOverStart = new GameOverStart(); 
			gameOverStart.alpha = 0; 
			addChild(gameOverStart); 
			TweenLite.to(gameOverStart, 3, {x:0, y:0, alpha:1});
			
			if(useKinect) {
				KinectOn.gbArray = []; 
				
					for (var i:int = 0; i < 14; i++) 
					{
						var gb:GlowBody = new GlowBody();  
						KinectOn.gbArray.push(gb); 
						addChild(KinectOn.gbArray[i]); 
					
				}
				countGlows = 13;
			}
			else{
				countGlows = 1; 
			}
			
		}
		private function autoStart():void { 
			//this code can be commented out to launch via keyboard for debugging 
			Mouse.hide();
			gameOverStart = new GameOverStart(); 
			gameOverStart.alpha = 0; 
			addChild(gameOverStart); 
			TweenLite.to(gameOverStart, 3, {x:0, y:0, alpha:1});
			
			if(useKinect) {
				k = new KinectOn(); 
				addChild(k); 
				countGlows = 13;
			}
			else{
				
				stage.addEventListener(TouchEvent.TOUCH, onTouch);
				countGlows = 1; 
			}
		}
		//note a keyboard event will restart the whole game. this function is largely for development and first start 
		private function levelCreator(e:KeyboardEvent):void {
//			if(loadLevelOne){
//				gameOverLevel1 = new GameOverLevel1(); 
//				addChild(gameOverLevel1); 
//			}
			if(e.keyCode == Keyboard.LEFT) {
				gameOverStart = new GameOverStart(); 
				gameOverStart.alpha = 0; 
				addChild(gameOverStart); 
				TweenLite.to(gameOverStart, 3, {x:0, y:0, alpha:1});
				
				//level2 = new LevelTwo(); 
				//addChild(level2); 
			}
			if(e.keyCode == Keyboard.UP){ 
				//up arrow testing	
				gameOverSimonA = new GameOverSimon(); 
				addChild(gameOverSimonA); 
			}
			if(e.keyCode == Keyboard.RIGHT) { 
				//var osc:OscTest = new OscTest(); 
				//addChild(osc); 
			}
			
			if(useKinect) {
				k = new KinectOn(); 
				addChild(k); 
				countGlows = 13;
			}
			else{
				
				stage.addEventListener(TouchEvent.TOUCH, onTouch);
				countGlows = 1; 
			}
			//this.addChild(new Stats());
		}
		private function deleteLevel(e:KeyboardEvent):void { 
			if(e.keyCode == Keyboard.RIGHT){
			gameOverLevel1.removeLevel(); 
			trace("level one removed"); 
			}
			trace(e);
		}
		
		private function setupPhysicsWorld():void 
		{
			var gravity:b2Vec2 = new b2Vec2(0,9.8); 
			var allowSleep:Boolean = false; 
			 _world = new b2World(gravity, allowSleep); 
			 addEventListener(starling.events.Event.ENTER_FRAME, updateW); 
			 GameMain.world.SetContactListener(new NKContactListener());
		}
		
		
		static public function get world():b2World 
		{
			return _world;
		}
		
		static public function set world(value:b2World):void 
		{
			_world = value;
		}
		
		private function onTouch (e:TouchEvent):void
		{
			// get the mouse location related to the stage
			var touch:Touch = e.getTouch(stage);
			var pos:Point = touch.getLocation(stage);
			//trace ( touch.phase );
			// store the mouse coordinate
			//trace(pos.x, pos.y); 
			GlowBody.xpos = pos.x
			GlowBody.ypos = pos.y; 
		}
		
		public function setDebugDraw(debugSprite:flash.display.Sprite):void{
			
			var debugDraw:b2DebugDraw = new b2DebugDraw();
			debugDraw.SetSprite(debugSprite);
			
						debugDraw.SetSprite(debugSprite);
						GameMain.world.SetDebugDraw(debugDraw); 
						
						debugDraw.SetDrawScale(GameMain.RATIO);
						debugDraw.SetLineThickness( 1.0);
						debugDraw.SetAlpha(1);
						debugDraw.SetFillAlpha(0.8);
						debugDraw.SetFlags(b2DebugDraw.e_shapeBit);

			_world.SetDebugDraw(debugDraw);
			
		}
		
		public function gameLoop(e:starling.events.Event):void{
			if(loadLevelOne){
				gameOverLevel1 = new GameOverLevel1(); 
				gameOverLevel1.restartGame.add(restart); 
				addChild(gameOverLevel1); 
				loadLevelOne = false; 
			}
			if(countGlows == 0){
 				//gameOverStart = new GameOverStart(); 
				//addChild(gameOverStart); 
				//killLevel(); 
			}

		}

		public static function get useKinect():Boolean
		{
			return _useKinect;
		}
		
		public function initServer():void {
			//ran
			serialServer=new XMLSocket  ;
			serialServer.connect("127.0.0.1",3333);
			
			serialServer.addEventListener(flash.events.DataEvent.DATA,onReceiveData);
			
			serialServer.addEventListener(flash.events.Event.CONNECT,onServer);
			serialServer.addEventListener(flash.events.Event.CLOSE,onServer);
			serialServer.addEventListener(flash.events.IOErrorEvent.IO_ERROR,onServer);
		}
		
		public function onServer(e:flash.events.Event):void {
			trace(e);
		}
		public function onReceiveData(dataEvent:flash.events.DataEvent):void { 
			
			var Data:DataEvent=dataEvent;
			//trace(Data);
			// This grabs the data from Data var which is the string passed
			// from our processing server.
			var test=Data.data;
			//trace(test);
			// This splits the variables we are passing.
			var parts:Array=test.split(",");
			//trace("parts0 this is the first variable: " + parts[0]);
			//trace("parts1 this is the second variable: " + parts[1]);
			attackBtn = parts[0]; 
			speedKnob = parts[1];
		
			getX = parts[2]; 
			getY = parts[3]; 
			getX = int(getX/100 *stage.stageWidth);
			getY = int(getY/100 *stage.stageHeight); 
			trace(getX); 
		
			//note this array only accepts ints so I had to mult by 100 in processing
			//here I reverse that so I can apply the stage multiplyer. 
			//this could also be done directly in processing or via a function
			ipadCheck.start(); 
		}
		
		private function playSound():void { 
			sc = bg.play();
			
		//	for continual looping 
			sc.addEventListener(flash.events.Event.SOUND_COMPLETE, onComplete);
			var transform:SoundTransform = new SoundTransform(0.3); 
			sc.soundTransform = transform; 
		}

		public function stopSound():void{ 
			sc = bg.stop(); 
		}
		
//		endless loop
		public function onComplete(event:flash.events.Event):void
				{
					sc.removeEventListener(event.type, onComplete);
					playSound();
					
				}

		public static function get serialServer():XMLSocket
		{
			return _serialServer;
		}

		public static function set serialServer(value:XMLSocket):void
		{
			_serialServer = value;
		}

		public static function get attackBtn():Number
		{
			return _attackBtn;
		}

		public static function set attackBtn(value:Number):void
		{
			_attackBtn = value;
		}

		public static function get speedKnob():Number
		{
			return _speedKnob;
		}

		public static function set speedKnob(value:Number):void
		{
			_speedKnob = value;
		}

		public static function get getX():Number
		{
			return _getX;
		}

		public static function set getX(value:Number):void
		{
			_getX = value;
		}

		public static function get getY():Number
		{
			return _getY;
		}

		public static function set getY(value:Number):void
		{
			_getY = value;
		}
		

		
		
//l2								 
	}
}
