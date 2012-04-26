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

	public class Kitty1 extends Actor
	{
		
		public static const CACHE_ID:String = "KITTY1"; 
		protected var dict:Dictionary;
		protected var kMovie:MovieClip; 
	
		
		public var _Kitty1Body:b2Body; 
		
		
		private var _beenHit:Boolean = false;
		

		//experiment with singles 
		private var kMovie2:MovieClip; 
		private var sprites:StarSpriteCostume; 
		
		private var bounce:Number = 0.22;
		
		public function Kitty1() 
		{
			addEventListener(Event.ADDED_TO_STAGE, kitty1Added); 
			
			
			sprites = new StarSpriteCostume("kitty", 2);
			
			kMovie2 = sprites.getDressed(); 
	
			

		
			

	
		
		dict = new Dictionary();
		//add kitty specific info 
		dict["kitty"] = [
			
			[
				// density, friction, restitution
				1, 0.1, bounce,
				// categoryBits, maskBits, groupIndex, isSensor
				1, 65535, 0, false,
				'POLYGON',
				
				// vertexes of decomposed polygons
				[
					
					[   new b2Vec2(57/GameMain.RATIO, 18/GameMain.RATIO)  ,  new b2Vec2(59/GameMain.RATIO, 110/GameMain.RATIO)  ,  new b2Vec2(11/GameMain.RATIO, 46/GameMain.RATIO)  ,  new b2Vec2(7/GameMain.RATIO, -1/GameMain.RATIO)  ] ,
					[   new b2Vec2(54/GameMain.RATIO, 163/GameMain.RATIO)  ,  new b2Vec2(146/GameMain.RATIO, 109/GameMain.RATIO)  ,  new b2Vec2(144/GameMain.RATIO, 179/GameMain.RATIO)  ,  new b2Vec2(68/GameMain.RATIO, 199/GameMain.RATIO)  ,  new b2Vec2(20/GameMain.RATIO, 194/GameMain.RATIO)  ] ,
					[   new b2Vec2(11/GameMain.RATIO, 46/GameMain.RATIO)  ,  new b2Vec2(59/GameMain.RATIO, 110/GameMain.RATIO)  ,  new b2Vec2(12/GameMain.RATIO, 87/GameMain.RATIO)  ] ,
					[   new b2Vec2(131/GameMain.RATIO, 24/GameMain.RATIO)  ,  new b2Vec2(127/GameMain.RATIO, 70/GameMain.RATIO)  ,  new b2Vec2(60/GameMain.RATIO, 120/GameMain.RATIO)  ,  new b2Vec2(59/GameMain.RATIO, 110/GameMain.RATIO)  ,  new b2Vec2(84/GameMain.RATIO, 19/GameMain.RATIO)  ,  new b2Vec2(127/GameMain.RATIO, 4/GameMain.RATIO)  ] ,
					[   new b2Vec2(60/GameMain.RATIO, 120/GameMain.RATIO)  ,  new b2Vec2(127/GameMain.RATIO, 70/GameMain.RATIO)  ,  new b2Vec2(146/GameMain.RATIO, 109/GameMain.RATIO)  ,  new b2Vec2(54/GameMain.RATIO, 163/GameMain.RATIO)  ] ,
					[   new b2Vec2(84/GameMain.RATIO, 19/GameMain.RATIO)  ,  new b2Vec2(59/GameMain.RATIO, 110/GameMain.RATIO)  ,  new b2Vec2(57/GameMain.RATIO, 18/GameMain.RATIO)  ]
				]
				
			]
			
		];

		
		_Kitty1Body= createBody("kitty", GameMain.world, b2Body.b2_dynamicBody,kMovie2); 
		_Kitty1Body.SetFixedRotation(true); 
	
		super(_Kitty1Body, kMovie2); 
	}
		
		private function kitty1Added(e:Event):void
		{
			addChild(kMovie2); 
			trace("kitt2 added"); 
			
		}
		

		public function createBody(name:String,  world:b2World, bodyType:uint, userData:*):b2Body
		{
			trace("kat body made"); 
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
			addEventListener(Event.ENTER_FRAME, updateKitty); 	
		}
		
		private function updateKitty(e:Event):void
		{
				
			kMovie2.x = _Kitty1Body.GetPosition().x * GameMain.RATIO; 
			kMovie2.y = _Kitty1Body.GetPosition().y * GameMain.RATIO; 

		}		
		
		public override function hitByActor(actor:Actor):void {
			//not in hit state
			if (! _beenHit)
			{	
				_beenHit = true; 
				setKittyState(); 
				//dispatchEvent(new PegEvent(PegEvent.PEG_LIT_UP)); 
			}
		}
		private function setKittyState():void { 
			//do animation for hit here. 
			trace("kitty hit by balloon"); 
		}
		
		public function remove ():void
		{		
			this.removeChildren(); 
			kMovie2.dispose(); 
			
 		
			//			
		}
		
//last two 	
	}
}	
	