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
	
	import com.as3nui.nativeExtensions.air.kinect.data.PointCloudRegion;
	
	import flash.display.Bitmap;
	import flash.geom.Point;
	import flash.ui.GameInput;
	import flash.ui.Keyboard;
	import flash.utils.Dictionary;
	
	import starling.core.Starling;
	import starling.display.Image;
	import starling.display.MovieClip;
	import starling.display.Sprite;
	import starling.events.Event;
	import starling.events.KeyboardEvent;
	import starling.textures.Texture;
	import starling.textures.TextureAtlas;
	
	public class EarthAir extends Actor
	{
		
		public static const CACHE_ID:String = "EarthAndAir"; 
		protected var dict:Dictionary;
		protected var earth_mc:MovieClip; 
		private var ant_gravity:b2Vec2;
		
		public var _earthAirBody:b2Body; 
		
		
		private var _beenHit:Boolean = false;		
		private var sprites:StarSpriteCostume; 
	
		public function EarthAir() 
		{
			addEventListener(Event.ADDED_TO_STAGE, EarthAirAdded);
			sprites = new StarSpriteCostume("EarthAndAirSm", 2);
			earth_mc = sprites.getDressed();
			dict = new Dictionary();
			dict["EarthAndAirSm"] = [
				
				[
					// density, friction, restitution
					2, 0, 0,
					// categoryBits, maskBits, groupIndex, isSensor
					1, 65535, 0, false,
					'POLYGON',
					
					// vertexes of decomposed polygons
					[
						
						[   new b2Vec2(1/GameMain.RATIO, 26/GameMain.RATIO)  ,  new b2Vec2(24/GameMain.RATIO, -2/GameMain.RATIO)  ,  new b2Vec2(44/GameMain.RATIO, 27/GameMain.RATIO)  ,  new b2Vec2(22/GameMain.RATIO, 56/GameMain.RATIO)  ]
					]
					
				]
				
			];
			
			_earthAirBody= createBody("EarthAndAirSm", GameMain.world, b2Body.b2_dynamicBody,earth_mc); 
			_earthAirBody.SetFixedRotation(true); 
			super(_earthAirBody, earth_mc); 
		}
		
		private function EarthAirAdded(e:Event):void
		{	
			//stage.addEventListener(KeyboardEvent.KEY_DOWN, adjustForce); 			
			var rand:Number = Math.random()*stage.stageWidth; 
			
			_earthAirBody.SetPosition(new b2Vec2((rand+earth_mc.width)/GameMain.RATIO,(0-earth_mc.height)/GameMain.RATIO)); 
			//earth_mc.y = Math.random()*stage.stageHeight; 
			addChild(earth_mc); 
			//trace("1 goomba added"); 
			//trace("earth added"); 
		

			
		}
		
		protected function boundsCheck():void
		{
			
			if(earth_mc.x >stage.stageWidth +earth_mc.x/2 || earth_mc.y > stage.stageHeight +earth_mc.y/2||earth_mc.x < -200|| earth_mc.y < -200){
				this.remove(); 
			}
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
			bodyDef.userData.name="earthAir"; 
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
			addEventListener(Event.ENTER_FRAME, updateEarth); 	
		}
		
		private function updateEarth(e:Event):void
		{
			boundsCheck();
			//f = m*a -- do the physics for this. 
			//ant_gravity = new b2Vec2(Math.random()*100, 0); 
			//_earthAirBody.ApplyForce(ant_gravity, _earthAirBody.GetWorldCenter()); 
	
			earth_mc.x = _earthAirBody.GetPosition().x * GameMain.RATIO; 
			earth_mc.y = _earthAirBody.GetPosition().y * GameMain.RATIO; 
		
		}		

		private function adjustForce(e:KeyboardEvent):void { 
		if(e.keyCode == Keyboard.A) { 
		
			//this one makes me smart 
			//var driveTo:b2Vec2 = new b2Vec2( GlowBody.xpos/GameMain.RATIO,  GlowBody.ypos/GameMain.RATIO); 
			
			//this one goes for the finger 
			var driveTo:b2Vec2 = new b2Vec2(GameMain.getX/GameMain.RATIO, GameMain.getY/GameMain.RATIO); 
			
			var locVec:b2Vec2 = new b2Vec2(earth_mc.x/GameMain.RATIO, earth_mc.y/GameMain.RATIO); 
			var diff:b2Vec2 = new b2Vec2(driveTo.x-locVec.x, driveTo.y-locVec.y); 
		//	diff.Normalize(); 
		//diff.Multiply(14); 		
			var center:b2Vec2 = _earthAirBody.GetPosition(); 
			_earthAirBody.SetLinearVelocity(diff); 
			_earthAirBody.SetAngularVelocity(0); 
			_earthAirBody.IsFixedRotation(); 
			}
		
		}
		public override function hitByActor(actor:Actor):void {
			//not in hit state
			//earth_mc.alpha =0; 
			trace(actor.name); 
			//	_beenHit = true; 
				setState(); 
				//dispatchEvent(new PegEvent(PegEvent.PEG_LIT_UP)); 
				trace("earth hit by glowbody function saying hello"); 
				//earth_mc.dispose(); 	
		}
		private function setState():void { 
			//do animation for hit here. 
			trace("earth setState signing on! Why you hit me bitch?"); 
		}
		
		public function remove ():void
		{	this.destroy(); 
			this.removeChildren(); 
			earth_mc.dispose(); 		
		}
		

				
		
		//last two 	
	}
}	
