package  
{
	import Box2D.Collision.Shapes.b2CircleShape;
	import Box2D.Common.Math.b2Vec2;
	import Box2D.Dynamics.b2Body;
	import Box2D.Dynamics.b2BodyDef;
	import Box2D.Dynamics.b2FixtureDef;
	
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.geom.Point;
	
	import starling.display.DisplayObjectContainer;

	/**
	 * ...
	 * @author phoenix
	 */
	public class BallActor extends Actor 
	{
		private static const BALL_DIAMETER:int = 12; 
		private var ballSprite:Sprite; 
		private var ballBody:b2Body; 
		
		public function BallActor(parent:DisplayObjectContainer, location:Point, initVel:Point) 
		{	
			//first create the costume 
			var ballSprite:BallShape = new BallShape(); 
			ballSprite.scaleX = BALL_DIAMETER / ballSprite.width; 
			ballSprite.scaleY = BALL_DIAMETER / ballSprite.height; 
			parent.addChild(ballSprite); 
			
			//create bodydef 
			var ballBodyDef:b2BodyDef = new b2BodyDef(); 
			ballBodyDef.type = b2Body.b2_dynamicBody; 
			ballBodyDef.position.Set(location.x / GameMain.RATIO, location.y / GameMain.RATIO); 
			ballBody = GameMain.world.CreateBody(ballBodyDef); 
			
			//create the shape definition 
			var ballShapeDef:b2CircleShape = new b2CircleShape(15 / GameMain.RATIO); 
			
			//create the fixture + fixture def 
			var ballFixtureDef:b2FixtureDef = new b2FixtureDef(); 
			ballFixtureDef.shape = ballShapeDef; 
			ballFixtureDef.density = 0.2;
			ballFixtureDef.friction = 1.0; 
			ballBody.CreateFixture(ballFixtureDef); 
			
			//set the belocity to match our parameter 
			var velocityVector:b2Vec2 = new b2Vec2(initVel.x / GameMain.RATIO, initVel.y / GameMain.RATIO); 
			ballBody.SetLinearVelocity(velocityVector); 
			
			super(ballBody, ballSprite); 
		}

		//clever for later create a function that divides x/GameMain.RATIO and returns the answer 
	}
	
	
}