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
	
	public class Bouncer extends Actor
	{
		
		public static const CACHE_ID:String = "Bouncer"; 
		protected var dict:Dictionary;
		protected var bouncer_mc:MovieClip; 
		private var ant_gravity:b2Vec2;
		
		public var _bouncerBody:b2Body; 
		
		
		private var _beenHit:Boolean = false;
		
		
		//experiment with singles 
		
		private var sprites:StarSpriteCostume; 
		
		private var bounce:Number = 0.22;
		
		public function Bouncer() 
		{
			addEventListener(Event.ADDED_TO_STAGE, bouncerAdded); 
			
			
			sprites = new StarSpriteCostume("bouncer", 2);
			
			bouncer_mc = sprites.getDressed(); 
			
			dict = new Dictionary();
			dict["bouncer"] = [
				
				[
					// density, friction, restitution
					.6, .02, .38,
					// categoryBits, maskBits, groupIndex, isSensor
					1, 65535, 0, false,
					'CIRCLE',
					
					// center, radius
					new b2Vec2(62.000/GameMain.RATIO,63.000/GameMain.RATIO),
					63.008/GameMain.RATIO
					
				]
				
			];	
			_bouncerBody= createBody("bouncer", GameMain.world, b2Body.b2_dynamicBody,bouncer_mc); 
			_bouncerBody.SetFixedRotation(true); 
			super(_bouncerBody, bouncer_mc); 
		}
		
		private function bouncerAdded(e:Event):void
		{	
		
			addChild(bouncer_mc); 
			trace("bouncing ball added"); 
			addEventListener(Event.ENTER_FRAME, boundsCheck); 
			
		}
		
		protected function boundsCheck(e:Event):void
		{
			
			if(this.x >stage.stageHeight+200 || this.y > stage.stageWidth+200 ||this.x < -200 || this.y< -200){
				remove(); 
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
			addEventListener(Event.ENTER_FRAME, updateBouncer); 	
		}
		
		private function updateBouncer(e:Event):void
		{
			bouncer_mc.x = _bouncerBody.GetPosition().x * GameMain.RATIO; 
			bouncer_mc.y = _bouncerBody.GetPosition().y * GameMain.RATIO; 
			
		}		
		
		public override function hitByActor(actor:Actor):void {
			//not in hit state
			//bouncer_mc.alpha =0; 
			
			//	_beenHit = true; 
			setState(); 
			//dispatchEvent(new PegEvent(PegEvent.PEG_LIT_UP)); 
			trace("hit state works you are dumb"); 
			//bouncer_mc.dispose(); 	
		}
		private function setState():void { 
			//do animation for hit here. 
			trace("ball hit floor"); 
		}
		
		public function remove ():void
		{	this.destroy(); 
			this.removeChildren(); 
			bouncer_mc.dispose(); 		
		}
		
		//last two 	
	}
}	
