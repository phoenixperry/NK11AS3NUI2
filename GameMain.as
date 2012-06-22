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
	
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.Sprite;
	import flash.geom.Point;
	import flash.globalization.CurrencyFormatter;
	import flash.printing.PrintJob;
	import flash.text.Font;
	import flash.ui.Keyboard;
	import flash.utils.Timer;
	
	import org.osflash.signals.Signal;
	
	import starling.core.Starling;
	import starling.display.Image;
	import starling.display.Sprite;
	import starling.events.Event;
	import starling.events.KeyboardEvent;
	import starling.events.Touch;
	import starling.events.TouchEvent;
	import starling.events.TouchPhase;
	import starling.text.TextField;
	import starling.textures.Texture;
	import starling.utils.Stats;
	
	public class GameMain extends Sprite
	{
		private static const _useKinect:Boolean = false ; 

		[Embed(source="assets/gameOver/fonts/Gotham-Light.otf", embedAsCFF="false",fontName="Gotham")]
		public static var Gotham:Class; 
		
		public var killAll:Boolean = false; 
		//reset var
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
		public var gameOverSimon:GameOverSimon; 
		private var makeSprites:SingletonSpriteSheet; 
		
		private var gameTimer:GameTimer; 
		private var levelOneRunning:Signal; 
		
		
		public function GameMain() 
		{
			makeSprites = SingletonSpriteSheet.getInstance(); 
			addEventListener(Event.ADDED_TO_STAGE, onAdded);
		
			
		}
		private function onAdded(e:Event):void
		{
			//set up font
			font = new Gotham(); 
			setupPhysicsWorld();
			gameTimer = new GameTimer(); 
			
			
			removeEventListener(Event.ADDED_TO_STAGE, onAdded); 

				stage.addEventListener(KeyboardEvent.KEY_DOWN, deleteLevel);
				stage.addEventListener(KeyboardEvent.KEY_DOWN, levelCreator);
			
			addEventListener(Event.ENTER_FRAME, gameLoop); 
			
		}		
		private function updateW(e:Event):void
		{
			var timeStep:Number = 1 / 60;
			var velocityIterations:int = 6;
			var positionIterations:int = 2;
			
			
			_world.Step(timeStep, velocityIterations, positionIterations);
			_world.ClearForces();
			_world.DrawDebugData();
			
		}		
		
		private function levelCreator(e:KeyboardEvent):void {
			if(loadLevelOne){
				gameOverLevel1 = new GameOverLevel1(); 
				addChild(gameOverLevel1); 
			}
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
				gameOverSimon = new GameOverSimon(); 
				addChild(gameOverSimon); 
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
			 addEventListener(Event.ENTER_FRAME, updateW); 
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
			// store the mouse coordinates

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
				addChild(gameOverLevel1); 
				loadLevelOne = false; 

			}
			if(countGlows == 0){
				//gameOverStart = new GameOverStart(); 
				//addChild(gameOverStart); 
				killLevel(); 
			}
			
		}

		 private function killLevel():void
		{
			
				 var msg:TextField = new TextField(600,400,"Fear destroyed your body", font.fontName, 38, 0xFFFFFF); 
				 msg.x = stage.stageWidth - msg.width >>1; 
				 msg.y = stage.stageHeight - msg.height >>1; 
				 addChild(msg); 
				 removeEventListener(Event.ENTER_FRAME, gameLoop); 	 

		}	
		
		public static function get useKinect():Boolean
		{
			return _useKinect;
		}
		
		
		
		
//l2								 
	}
}
