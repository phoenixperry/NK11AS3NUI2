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
	
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.Sprite;
	import flash.geom.Point;
	import flash.globalization.CurrencyFormatter;
	import flash.printing.PrintJob;
	import flash.ui.Keyboard;
	import flash.utils.Timer;
	
	import starling.core.Starling;
	import starling.display.Image;
	import starling.display.Sprite;
	import starling.events.Event;
	import starling.events.KeyboardEvent;
	import starling.events.Touch;
	import starling.events.TouchEvent;
	import starling.events.TouchPhase;
	import starling.textures.Texture;
	import starling.utils.Stats;
	
	public class GameMain extends Sprite
	{

		
		private var gameOverStart:GameOverStart;
	    private var k:KinectOn;
		private static const _useKinect:Boolean = false ; 
		private var _mouseX:Number = 0;
		private var _mouseY:Number = 0;
			
		public static var RATIO:Number = 30;
		private static var _world:b2World; 
		public static const GAME_WIDTH:Number = 1024; 
		public static const GAME_HEIGHT:Number = 768;  
		public static var loadLevelOne:Boolean= false; 
		public static var loadLevelTwo:Boolean = false; 
		public var gameOverLevel1:GameOverLevel1; 
		
		private var makeSprites:SingletonSpriteSheet; 
		
		private var gameTimer:GameTimer; 
		
		
		public function GameMain() 
		{
			makeSprites = SingletonSpriteSheet.getInstance(); 
			addEventListener(Event.ADDED_TO_STAGE, onAdded);
		
			
		}
		private function onAdded(e:Event):void
		{
			setupPhysicsWorld();
			gameTimer = new GameTimer(); 
			
		
			removeEventListener(Event.ADDED_TO_STAGE, onAdded); 

				stage.addEventListener(KeyboardEvent.KEY_DOWN, deleteLevel);
				stage.addEventListener(KeyboardEvent.KEY_DOWN, levelCreator);
			
			addEventListener(Event.ENTER_FRAME, gameLoop); 
			
		}		
	//	trying to fix the time step. This is going to have to happen. Oh zee pain. 
//		private var _currentTime:Number = gameTimer.getVirtualTime()/1000; 
//		private const FIXED_TIMESTEP:Number = 1/60; 
//		private var fixedTimeStepAccumulator:Number = 0; 
//		private var fixedTimeStepAccumulatorRatio:Number = 0; 
//		private var velocityIterations:int = 8; 
//		private var positionIterations:int = 1; 
//		
//		public function process():void {
//			var newTime:Number = gameTimer.getVirtualTime()/1000;
//			var dt:Number = newTime - _currentTime; 
//			_currentTime= newTime; 
//			const MAX_STEPS:int = 5; 
//			fixedTimeStepAccumulator +=dt; 
//			const nSteps:int = Math.floor(fixedTimeStepAccumulator/FIXED_TIMESTEP); 
//			
//			if (nSteps > 0) 
//			{
//				fixedTimeStepAccumulator -= nSteps* FIXED_TIMESTEP; 
//			}
//			fixedTimeStepAccumulatorRatio = fixedTimeStepAccumulator/FIXED_TIMESTEP; 
//			const nStepsClamped:int= min(nSteps, MAX_STEPS); 
//			for (var i:int = 0; i < nStepsClamped; i++) 
//			{
//				resetSmoothStates(); 
//				singleStep(FIXED_TIMESTEP); 
//			}
//			world.ClearForces(); 
//			smoothStates(); 
//			
//		}
//		
//		private function singleStep(dt:Number):void {
//			_world.Step(dt, velocityIterations, positionIterations); 
//			_world.DrawDebugData();
//		}
////		
//		
//		private function smoothStates():void {
//			const oneMinusRatio:Number = 1.0 - fixedTimeStepAccumulatorRatio; 
//			for each (var body:b2Body = GameMain._world.GetBodyList(); body; body=body.GetNext())
//			{ 			
//				//gonna need to call the Actor.costume update and adjust the 
//				//stuff from here to there. Oh zee joy
		// from alan bishops' blog - need to fully comprehend ramifications with this config
//				texture.position.x = fixedTimestepAccumulatorRatio * box2Dbody.GetPosition().x 
				//+ (oneMinusRatio * body.previousPosition.x);
//				texture.position.y = fixedTimestepAccumulatorRatio * box2Dbody.GetPosition().y + 
				//oneMinusRatio * body.previousPosition.y;
//				texture.rotation = 
				//box2Dbody.GetAngle() * fixedTimestepAccumulatorRatio + oneMinusRatio * body.previousAngle;
//		}
//		MORE FROM ALAN 
//		private function resetSmoothStates():void
//		{
//			for each (var body:Body in bodies)
//			{
//				texture.position.x = body.previousPosition.x = body.box2Dbody.GetPosition().x;
//				
//				texture.position.y = body.previousPosition.y = body.box2Dbody.GetPosition().y;
//				
//				texture.rotation = body.previousAngle = body.box2Dbody.GetAngle();
//			}
//		}
//		//end of timestep fix 
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
			if(e.keyCode == Keyboard.O){ 
				//up arrow testing	
			}
			if(useKinect) {
				k = new KinectOn(); 
				addChild(k); 	
			}
			else{
				
				stage.addEventListener(TouchEvent.TOUCH, onTouch);
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
			var gravity:b2Vec2 = new b2Vec2(0, 9.8); 
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
		}

		public static function get useKinect():Boolean
		{
			return _useKinect;
		}
								 

		
		
	}
}