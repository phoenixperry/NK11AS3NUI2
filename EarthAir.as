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
	
	public class EarthAir extends Actor
	{
		
		public static const CACHE_ID:String = "EarthAndAir"; 
		protected var dict:Dictionary;
		protected var earth_mc:MovieClip; 
		
		
		public var _earthAirBody:b2Body; 
		
		
		private var _beenHit:Boolean = false;
		
		
		//experiment with singles 

		private var sprites:StarSpriteCostume; 
		
		private var bounce:Number = 0.22;
		
		public function EarthAir() 
		{
			addEventListener(Event.ADDED_TO_STAGE, EarthAirAdded); 
			
			
			sprites = new StarSpriteCostume("EarthAndAir", 2);
			
			earth_mc = sprites.getDressed(); 
			
			
			
			
			
			
			
			
			dict = new Dictionary();
			//add kitty specific info 
			dict["earthAir"] = [
				
				[
					// density, friction, restitution
					2, 0, 0,
					// categoryBits, maskBits, groupIndex, isSensor
					1, 65535, 0, false,
					'POLYGON',
					
					// vertexes of decomposed polygons
					[
						
						[   new b2Vec2(19/GameMain.RATIO, 67/GameMain.RATIO)  ,  new b2Vec2(22/GameMain.RATIO, 42/GameMain.RATIO)  ,  new b2Vec2(44/GameMain.RATIO, -4/GameMain.RATIO)  ,  new b2Vec2(68.5/GameMain.RATIO, 45/GameMain.RATIO)  ,  new b2Vec2(70.5/GameMain.RATIO, 62/GameMain.RATIO)  ,  new b2Vec2(46/GameMain.RATIO, 107.5/GameMain.RATIO)  ] ,
						[   new b2Vec2(87/GameMain.RATIO, 81/GameMain.RATIO)  ,  new b2Vec2(70.5/GameMain.RATIO, 62/GameMain.RATIO)  ,  new b2Vec2(68.5/GameMain.RATIO, 45/GameMain.RATIO)  ,  new b2Vec2(87/GameMain.RATIO, 23/GameMain.RATIO)  ] ,
						[   new b2Vec2(22/GameMain.RATIO, 42/GameMain.RATIO)  ,  new b2Vec2(19/GameMain.RATIO, 67/GameMain.RATIO)  ,  new b2Vec2(2/GameMain.RATIO, 82/GameMain.RATIO)  ,  new b2Vec2(2/GameMain.RATIO, 32.5/GameMain.RATIO)  ]
					]
					
				]
				
			];
			
			
			_earthAirBody= createBody("earthAir", GameMain.world, b2Body.b2_dynamicBody,earth_mc); 
			_earthAirBody.SetFixedRotation(true); 
			
			super(_earthAirBody, earth_mc); 
		}
		
		private function EarthAirAdded(e:Event):void
		{
			addChild(earth_mc); 
			trace("kitt2 added"); 
			
		}
		
		
		public function createBody(name:String,  world:b2World, bodyType:uint, userData:*):b2Body
		{
			//trace("earth body made"); 
			var fixtures:Array = dict[name];
			
			
			//create body 
			var body:b2Body;		
			var f:Number;
			
			// prepare body def
			var bodyDef:b2BodyDef = new b2BodyDef();
			bodyDef.type = bodyType;
			bodyDef.userData = userData;
			//fixes sticking but lord oh lord at what cost 
			bodyDef.bullet = false; 
			
			
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
			
			earth_mc.x = _earthAirBody.GetPosition().x * GameMain.RATIO; 
			earth_mc.y = _earthAirBody.GetPosition().y * GameMain.RATIO; 
			
		}		
		
		public override function hitByActor(actor:Actor):void {
			//not in hit state
			if (! _beenHit)
			{	
				_beenHit = true; 
				setState(); 
				//dispatchEvent(new PegEvent(PegEvent.PEG_LIT_UP)); 
			}
		}
		private function setState():void { 
			//do animation for hit here. 
			trace("earth hit by joint"); 
		}
		
		public function remove ():void
		{		
			this.removeChildren(); 
			earth_mc.dispose(); 
			
			
			//			
		}
		
		//last two 	
	}
}	
