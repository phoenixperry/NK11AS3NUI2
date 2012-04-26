package
{
	import Box2D.Collision.Shapes.b2CircleShape;
	import Box2D.Collision.Shapes.b2PolygonShape;
	import Box2D.Collision.Shapes.b2Shape;
	import Box2D.Common.Math.b2Vec2;
	import Box2D.Common.b2Settings;
	import Box2D.Dynamics.b2Body;
	import Box2D.Dynamics.b2BodyDef;
	import Box2D.Dynamics.b2DebugDraw;
	import Box2D.Dynamics.b2Fixture;
	import Box2D.Dynamics.b2FixtureDef;
	import Box2D.Dynamics.b2World;
	
	import starling.display.DisplayObject;
	import starling.display.Image;
	import starling.display.MovieClip;
	import starling.display.Quad;
	import starling.display.Sprite;
	import starling.events.Event;
	import starling.extensions.*;
	import starling.extensions.ParticleDesignerPS;
	import starling.textures.Texture;
	import starling.textures.TextureAtlas; 
	public class Foo extends Actor
	{
		public var _fooBody:b2Body; 
	
		var q:Quad; 
		var body:b2Body;
		
		var bodyDef:b2BodyDef; 

		var fixtureDef:b2FixtureDef; 
		
		var xb:Number = (147/GameMain.RATIO)/2; 
		var yb:Number = (160/GameMain.RATIO)/2;   		
		public function Foo()
		{
			var q:Quad = new Quad(50,50,0xFFFFFF, true); 


				bodyDef = new b2BodyDef(); 
				bodyDef.type = b2Body.b2_dynamicBody; 
				bodyDef.position.x = Math.random() *15+5; 
				bodyDef.position.y = Math.random() *10; 
				var rx:Number = Math.random() + 0.5; 
				var ry:Number = Math.random() +0.5; 
				
				//create q
				q = new Quad(30,30, 0xFF00FF, true); 
				q.pivotX -= q.width/ 2.0; 
				q.pivotY -= q.height/2.0;  
		
				var xb:Number = (147/GameMain.RATIO)/2; 
				var yb:Number = (160/GameMain.RATIO)/2;   
				
			 	var boxShape:b2PolygonShape = new b2PolygonShape(); 
				boxShape.SetAsBox(xb, yb); 
				fixtureDef.shape = boxShape; 
				fixtureDef.density = 1.0; 
				fixtureDef.friction = 0.3; 
				fixtureDef.restitution =0.8;
				
				
				bodyDef.userData = q; 
				bodyDef.userData.width = q.width/GameMain.RATIO; 
				bodyDef.userData.height= q.height/GameMain.RATIO; 
				
				
				body = GameMain.world.CreateBody(bodyDef); 
				
				body.CreateFixture(fixtureDef); 
				
				addEventListener(Event.ENTER_FRAME, startUp); 
				super(body, q);
				
			}
		
		private function startUp(e:Event):void
		{
			addChild(bodyDef.userData); 
			// TODO Auto Generated method stub
			
		}			
			
		
	
	}
}