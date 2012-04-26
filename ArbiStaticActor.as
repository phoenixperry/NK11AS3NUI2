package
{
	import Box2D.Collision.Shapes.b2PolygonShape;
	import Box2D.Common.Math.b2Vec2;
	import Box2D.Dynamics.b2Body;
	import Box2D.Dynamics.b2BodyDef;
	import Box2D.Dynamics.b2Fixture;
	import Box2D.Dynamics.b2FixtureDef;
	
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.Sprite;
	import flash.geom.Point;
	
	import starling.core.Starling;
	import starling.display.DisplayObjectContainer;
	import starling.display.Image;
	import starling.display.Sprite;
	import starling.textures.Texture;	

	
	public class ArbiStaticActor extends Actor 
	{
		public function ArbiStaticActor(parent:DisplayObjectContainer, location:Point, coordinates:Array){
			
			//create a b2Body 
			var myBody:b2Body = createBodyFromCoordinates(coordinates, location); 
			var mySprite:starling.display.Sprite = createSpriteFromCoordinates(coordinates, location,parent); 
			super(myBody, mySprite); 
		}
		/**
		 * Create the costume for the AribStaticActor.
		 * @param coordinates Point coordinates for the ArbiStaticActor.
		 * @param location Location of the ArbiStaticActor.
		 * @param parent Display container for the ArbiStaticActor
		 * */
		
		private function createSpriteFromCoordinates(coordinates:Array, location:Point, parent:DisplayObjectContainer):starling.display.Sprite
		{
			var newSprite:flash.display.Sprite = new flash.display.Sprite(); 
			newSprite.graphics.lineStyle(1,0x000000,0); 
			var bmd:BitmapData; 
			//draw up each point 
			for each(var listOfPoints:Array in coordinates) 
			{
				var firstPoint:Point = listOfPoints[0]; 
				newSprite.graphics.moveTo(firstPoint.x, firstPoint.y); 
				newSprite.graphics.beginFill(0x000000, 1); 
				
				for each (var newPoint:Point in listOfPoints) 
				{
					newSprite.graphics.lineTo(newPoint.x, newPoint.y); 
				}
				newSprite.graphics.lineTo(firstPoint.x, firstPoint.y); 
				newSprite.graphics.endFill(); 
		
//				newSprite.x = location.x; 
//				newSprite.y = location.y; 	
			}
			bmd = new BitmapData(newSprite.width, newSprite.height, true, 0x000000); 
			bmd.draw(newSprite); 		
			var texture:Texture = Texture.fromBitmapData(bmd,true,false); 
			var image:Image = new Image(texture); 
			var completeSprite:starling.display.Sprite = new starling.display.Sprite(); 
			//watch out you can end up w/2 offsets. check this. 
			completeSprite.x = location.x; 
			completeSprite.y = location.y;
			completeSprite.addChild(image); 
			parent.addChild(completeSprite); 
			return completeSprite;
		}
		
		/**
		 * Create the b2Body for the AribStaticActor.
		 * @param coordinates Point coordinates for the ArbiStaticActor.
		 * @param location Location of the ArbiStaticActor.
		 * @param parent Display container for the ArbiStaticActor
		 * */
		private function createBodyFromCoordinates(coordinates:Array, location:Point):b2Body
		{
			//create body def 
			var bodyDef:b2BodyDef = new b2BodyDef(); 
			bodyDef.type = b2Body.b2_staticBody; 
			bodyDef.position.Set(location.x/GameMain.RATIO, location.y/GameMain.RATIO);
			//create body 
			var arbiBody:b2Body = GameMain.world.CreateBody(bodyDef); 
			//each point array 
			for each(var listOfPoints:Array in coordinates) 
			{
				//convert points to vectors 
				var listOfPointVectors:Array = new Array(); 
				
				//each point
				for (var i:int = 0; i < listOfPoints.length; i++) 
				{
					var v:b2Vec2 = new b2Vec2(); 
					var nextPoint:Point = listOfPoints[i]; 
					//convert to b2world measurements 
					v.x = nextPoint.x /GameMain.RATIO; 
					v.y = nextPoint.y/GameMain.RATIO; 
					listOfPointVectors.push(v); 
				}
				
			//create a polygon shape 
				var polyShape:b2PolygonShape = new b2PolygonShape(); 
				polyShape.SetAsArray(listOfPointVectors, listOfPointVectors.length); 
				//define the colliosn dection fixture
				var fixtureDef:b2FixtureDef = new b2FixtureDef();
				//assign the b2poly shape 
				fixtureDef.shape = polyShape;
				fixtureDef.density = 0; 
				fixtureDef.friction = .2; 
				fixtureDef.restitution = 0; 
				arbiBody.CreateFixture(fixtureDef); 
			}
			
			
			return arbiBody; 
		}
		
//final 2
	}
}