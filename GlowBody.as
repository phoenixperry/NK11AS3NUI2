
package 
{
	/**
	 * @author phoenix
	 */
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
	import flash.display.Graphics;
	import flash.display.Sprite;
	import flash.geom.Point;
	import flash.ui.GameInput;
	import flash.utils.Dictionary;
	
	import org.osflash.signals.Signal;
	
	import starling.core.Starling;
	import starling.display.Image;
	import starling.display.MovieClip;
	import starling.display.Sprite;
	import starling.events.Event;
	import starling.extensions.*;
	import starling.extensions.ParticleDesignerPS;
	import starling.textures.Texture;
	import starling.textures.TextureAtlas;
	
	public class GlowBody extends Actor
	{
		[Embed(source="./assets/gameOver/sprites/glowBall.png")]
		public var ParticleTexture:Class;
		
		[Embed(source="./assets/gameOver/sprites/particle.xml", mimeType="application/octet-stream")]
		public var ParticleXML:Class; 
		
		public var particles:ParticleDesignerPS; 
		public static const CACHE_ID:String = "GlowBall"; 
		private var _particleMouseX:Number; 
		public var py:Number; 
		
		public var _BallBody:b2Body; 
		protected var dict:Dictionary;
		
		protected var _mouseXWorldPhys:Number;
		protected var _mouseYWorldPhys:Number;
		protected var _mouseXWorld:Number=0;
		protected var _mouseYWorld:Number=0;
		protected var _mousePVec:b2Vec2 = new b2Vec2();
		
		//we are the global class based vars for if the kinect is not being used and multi-touch is on
		private static var _xpos:Number; 
		private static var _ypos:Number; 
		
		//we are the member vars for setting up the individual positions of glow balls 
		public var xposMem:Number; 
		public var yposMem:Number; 
		public var _beenHit:Boolean = false;
		public var glowHit:Signal; 		
		
		//experiment with singles 
		private var b2Movie:MovieClip; 
		private var sprites:StarSpriteCostume; 

		//hit test ghetto style 
		public var hit:Boolean; 
		public function GlowBody()
		{
			addEventListener(Event.ADDED_TO_STAGE, ballAdded); 
			_particleMouseX = 0; 
			
			sprites = new StarSpriteCostume("glowBall", 5); 
			b2Movie = sprites.getDressed(); 
			particles = new ParticleDesignerPS(XML(new ParticleXML()),
			Texture.fromBitmap(new ParticleTexture()));
			dict = new Dictionary();
			glowHit = new  Signal();
			glowHit.add(setState);
		
			
			dict["glow"] = [
				
				[
					// density, friction, restitution
					2, 0, 0,
					// categoryBits, maskBits, groupIndex, isSensor
					1, 65535, 0, false,
					'CIRCLE',
					
					// center, radius
					new b2Vec2(16.000/GameMain.RATIO,14.000/GameMain.RATIO),
					18.000/GameMain.RATIO
					
				]
				
			];
			_BallBody = createBody("glow", GameMain.world, b2Body.b2_dynamicBody,particles); 
			_BallBody.SetFixedRotation(true); 
			super(_BallBody, particles); 
			
		
		}
		public function createBody(name:String, world:b2World, bodyType:uint, userData:*):b2Body
		{
			
			var fixtures:Array = dict[name];
			
			var body:b2Body;
			var f:Number;
			
			// prepare body def
			var bodyDef:b2BodyDef = new b2BodyDef();
			bodyDef.type = bodyType;
			bodyDef.userData = userData;
			
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

		public function ballAdded(e:Event):void { 
			//	
			particles.start(); 
			particles.emitterX = b2Movie.x; 
			particles.emitterY = b2Movie.y; 
			_particleMouseX = 	particles.emitterX; 
			py = 	particles.emitterY;
			
			//now add it to juggler
			Starling.juggler.add(particles); 
			
			
			addChild(particles); 
	
			removeEventListener(Event.ADDED_TO_STAGE, ballAdded); 
			//addChild(b2Movie); 
			//b2Movie.alpha=0; 
			
		}
		override protected function childSpecificUpdating():void
		{ 
			addEventListener(Event.ENTER_FRAME, updateMouse); 	
		}
		
		private function updateMouse(e:Event):void
		{
			if(GameMain.useKinect){
			//updateNow(); 
			_mouseXWorldPhys = (xposMem-b2Movie.width/2) / GameMain.RATIO;
			_mouseYWorldPhys = (yposMem- b2Movie.height/4) / GameMain.RATIO;
			//	trace(_mouseXWorldPhys, _mouseYWorldPhys, xpos, ypos); 
			if(xposMem > 0 && xposMem <stage.stageWidth) { 
				var ballTarget:b2Vec2= new b2Vec2(_mouseXWorldPhys, _mouseYWorldPhys); 
				var ballCurrent:b2Vec2 = new b2Vec2(_BallBody.GetPosition().x, _BallBody.GetPosition().y);
				//trace(_BallBody.GetPosition().x, _BallBody.GetPosition().y); 
				var diff:b2Vec2 = new b2Vec2((ballTarget.x-ballCurrent.x), (ballTarget.y-ballCurrent.y)); 
				//diff.Normalize(); 
				diff.Multiply(14);
				_BallBody.SetLinearVelocity(diff); 
				_BallBody.SetAngularVelocity(0); 
				_BallBody.IsFixedRotation(); 
				}	
			}
				//these update based on if I am using kinect or touch. 
				_mouseXWorldPhys = (xpos-b2Movie.width/2) / GameMain.RATIO;
				_mouseYWorldPhys = (ypos- b2Movie.height/4) / GameMain.RATIO;
				//	trace(_mouseXWorldPhys, _mouseYWorldPhys, xpos, ypos); 
				if(xpos > 0 && xpos <stage.stageWidth) { 
					var ballTarget:b2Vec2= new b2Vec2(_mouseXWorldPhys, _mouseYWorldPhys); 
					var ballCurrent:b2Vec2 = new b2Vec2(_BallBody.GetPosition().x, _BallBody.GetPosition().y);
					//trace(_BallBody.GetPosition().x, _BallBody.GetPosition().y); 
					var diff:b2Vec2 = new b2Vec2((ballTarget.x-ballCurrent.x), (ballTarget.y-ballCurrent.y)); 
					//diff.Normalize(); 
					diff.Multiply(14);
					_BallBody.SetLinearVelocity(diff); 
					_BallBody.SetAngularVelocity(0); 
					_BallBody.IsFixedRotation(); 
		}
			// set the rotation of the sprite
			b2Movie.x = _BallBody.GetPosition().x * GameMain.RATIO; 
			b2Movie.y = _BallBody.GetPosition().y * GameMain.RATIO;  
			b2Movie.rotation = _BallBody.GetAngle() * (180/Math.PI);
			particles.emitterX = (_BallBody.GetPosition().x * GameMain.RATIO)+13; 
			particles.emitterY = (_BallBody.GetPosition().y* GameMain.RATIO)+15; 
			
			//trace(_xpos, _ypos); 
			
			//was I hit? 
			if(hit) {
				//uncomment these two when done debugging 
				
				GameMain.world.DestroyBody(_BallBody);
				remove();
				hit = false; 
				trace("glow ball has", numChildren); 
				GameMain.countGlows -= 1; 
			}
			
			
		}		
		
		public override function hitByActor(actor:Actor):void {
			//not in hit state
		
				if(actor is GlowBody) { 
					hit = false; 
				} else { 
				//change this when not debugging 
				particles.alpha = 0;
				this.remove(); 
				hit = true; 
			
				trace("glow body hitByActor saying what's up!"); 
				trace(this.numChildren);
				setState("Glow body runing it's setState"); 
				}
		}
		
		private function setState( msg:String):void
		{
			trace(msg);
			hit = true; 
			
		}
		
		public function remove ():void
		{
			
			this.removeChildren(); 
			b2Movie.dispose(); 
			particles.dispose(); 
			trace(this.numChildren); 
		}

		public static function get xpos():Number
		{
			return _xpos;
		}
		public static function get ypos():Number
		{
			return _ypos;
		}

		public static function set ypos(value:Number):void
		{
			_ypos = value;
			//trace(_ypos, "I'm _ypos from the class"); 
		}
		
		
		public static function set xpos(value:Number):void
		{
			_xpos = value;
			//trace(_xpos, "I'm _xpos from the class");
		}


	//l2
	}	
}