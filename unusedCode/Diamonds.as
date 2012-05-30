package
{
	
	import Box2D.Collision.*;
	import Box2D.Collision.Shapes.*;
	import Box2D.Collision.Shapes.b2CircleShape;
	import Box2D.Common.Math.*;
	import Box2D.Common.Math.b2Vec2;
	import Box2D.Dynamics.*;
	import Box2D.Dynamics.b2Body;
	import Box2D.Dynamics.b2BodyDef;
	import Box2D.Dynamics.b2FixtureDef;
	
	import flash.display.Bitmap;
	import flash.geom.Point;
	import flash.ui.GameInput;
	import flash.utils.Dictionary;
	
	import starling.core.Starling;
	import starling.display.Image;
	import starling.display.MovieClip;
	import starling.display.Sprite;
	import starling.events.Event;
	import starling.textures.Texture;
	import starling.textures.TextureAtlas;  
	
	public class Diamonds extends Actor
	{
		
		public static const CACHE_ID:String = "D"; 
		protected var dict:Dictionary;
		protected var kMovie:MovieClip; 
		
		
		public var dBody:b2Body; 
		
		
		private var _beenHit:Boolean = false;
		
		
		//experiment with singles 
		private var dMovie:MovieClip; 
		private var sprites:StarSpriteCostume; 
		
		private var bounce:Number = 0.22;
		
		public function Diamonds() 
		{

			addEventListener(Event.ADDED_TO_STAGE, dAdded); 
			sprites = new StarSpriteCostume("d", 2);
			dMovie = sprites.getDressed(); 
	//here are the physics colliders 
			dict = new Dictionary();
			//add kitty specific info 
			dict["d"] = [
				
				[
					// density, friction, restitution
					5, 0, 0,
					// categoryBits, maskBits, groupIndex, isSensor
					1, 65535, 0, false,
					'POLYGON',
					
					// vertexes of decomposed polygons
					[
						
						[   new b2Vec2(37/GameMain.RATIO, 24/GameMain.RATIO)  ,  new b2Vec2(20/GameMain.RATIO, 91/GameMain.RATIO)  ,  new b2Vec2(3/GameMain.RATIO, 23/GameMain.RATIO)  ,  new b2Vec2(20/GameMain.RATIO, 3/GameMain.RATIO)  ]
					]
					
				]
				
			];
			
			
			dBody= createBody("d", GameMain.world, b2Body.b2_dynamicBody,dMovie); 
			dBody.SetFixedRotation(true); 
			
			super(dBody, dMovie); 
		}
		
		private function dAdded(e:Event):void
		{
			addChild(dMovie); 
			trace("d added"); 
			
		}
		
		
		public function createBody(name:String,  world:b2World, bodyType:uint, userData:*):b2Body
		{
			trace("diamond body made"); 
			var fixtures:Array = dict[name];
			
			
			//create body 
			var body:b2Body;		
			var f:Number;
			
			// prepare body def
			var bodyDef:b2BodyDef = new b2BodyDef();
			bodyDef.type = bodyType;
			bodyDef.userData = userData;
			//fixes sticking but lord oh lord at what cost 
			bodyDef.bullet = true; 
			
			
			// create the body
			body = GameMain.world.CreateBody(bodyDef);
			// prepare fixtures
			for(f=0; f<fixtures.length; f++)
			{
				var fixture:Array = fixtures[f];
				
				var fixtureDef:b2FixtureDef = new b2FixtureDef();
				
				fixtureDef.density=fixture[0];
				fixtureDef.friction=fixture[1];
				fixtureDef.restitution=fixture[2];
				
				fixtureDef.filter.categoryBits = fixture[3];
				fixtureDef.filter.maskBits = fixture[4];
				fixtureDef.filter.groupIndex = fixture[5];
				fixtureDef.isSensor = fixture[6];
				
				if(fixture[7] == "POLYGON")
				{                    
					var p:Number;
					var polygons:Array = fixture[8];
					for(p=0; p<polygons.length; p++)
					{
						var polygonShape:b2PolygonShape = new b2PolygonShape();
						polygonShape.SetAsArray(polygons[p], polygons[p].length);
						fixtureDef.shape=polygonShape;
						
						body.CreateFixture(fixtureDef);
						
						
					}
				}
				else if(fixture[7] == "CIRCLE")
				{
					var circleShape:b2CircleShape = new b2CircleShape(fixture[9]);                    
					circleShape.SetLocalPosition(fixture[8]);
					fixtureDef.shape=circleShape;
					body.CreateFixture(fixtureDef);                    
				}                
			}
			
			return body;
			
		}
		override protected function childSpecificUpdating():void
		{ 
			addEventListener(Event.ENTER_FRAME, updateD); 	
		}
		
		private function updateD(e:Event):void
		{
			
			dMovie.x = dBody.GetPosition().x * GameMain.RATIO; 
			dMovie.y = dBody.GetPosition().y * GameMain.RATIO; 
			
		}		
		
//		public override function hitByActor(actor:Actor):void {
//			//not in hit state
//			if (! _beenHit)
//			{	
//				_beenHit = true; 
//				setdState(); 
//				//dispatchEvent(new PegEvent(PegEvent.PEG_LIT_UP)); 
//			}
//		}
//		private function setdState():void { 
//			//do animation for hit here. 
//			trace("Diamonds hit by balloon"); 
//		}
//		
		public function remove ():void
		{
			
			dMovie.dispose(); 
			
			this.removeChildren(); 
			//			
		}
		
		//last two 	
	}
}	
