package
{
	import Box2D.Dynamics.*;
	import Box2D.Collision.*;
	import Box2D.Collision.Shapes.*;
	import Box2D.Common.Math.*;
    import flash.utils.Dictionary;

    public class PhysicsData extends Object
	{
		// ptm ratio
        public var ptm_ratio:Number = 30;
		
		// the physcis data 
		var dict:Dictionary;
		
        //
        // bodytype:
        //  b2_staticBody
        //  b2_kinematicBody
        //  b2_dynamicBody

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
            body = world.CreateBody(bodyDef);

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

		
        public function PhysicsData(): void
		{
			dict = new Dictionary();
			

			dict["mouse"] = [

										[
											// density, friction, restitution
                                            3, 0.2, 0.2,
                                            // categoryBits, maskBits, groupIndex, isSensor
											1, 65535, 0, false,
											'POLYGON',

                                            // vertexes of decomposed polygons
                                            [

                                                [   new b2Vec2(50/ptm_ratio, 145/ptm_ratio)  ,  new b2Vec2(53/ptm_ratio, 109/ptm_ratio)  ,  new b2Vec2(147/ptm_ratio, 152/ptm_ratio)  ,  new b2Vec2(102/ptm_ratio, 182/ptm_ratio)  ] ,
                                                [   new b2Vec2(14/ptm_ratio, 13/ptm_ratio)  ,  new b2Vec2(52/ptm_ratio, -3/ptm_ratio)  ,  new b2Vec2(53/ptm_ratio, 109/ptm_ratio)  ,  new b2Vec2(19/ptm_ratio, 95/ptm_ratio)  ,  new b2Vec2(-4/ptm_ratio, 55/ptm_ratio)  ] ,
                                                [   new b2Vec2(151/ptm_ratio, 105/ptm_ratio)  ,  new b2Vec2(98/ptm_ratio, 37/ptm_ratio)  ,  new b2Vec2(119/ptm_ratio, 5/ptm_ratio)  ,  new b2Vec2(144/ptm_ratio, -1/ptm_ratio)  ,  new b2Vec2(181/ptm_ratio, 13/ptm_ratio)  ,  new b2Vec2(197/ptm_ratio, 51/ptm_ratio)  ,  new b2Vec2(185/ptm_ratio, 89/ptm_ratio)  ] ,
                                                [   new b2Vec2(52/ptm_ratio, -3/ptm_ratio)  ,  new b2Vec2(98/ptm_ratio, 37/ptm_ratio)  ,  new b2Vec2(151/ptm_ratio, 105/ptm_ratio)  ,  new b2Vec2(147/ptm_ratio, 152/ptm_ratio)  ,  new b2Vec2(53/ptm_ratio, 109/ptm_ratio)  ] ,
                                                [   new b2Vec2(147/ptm_ratio, 152/ptm_ratio)  ,  new b2Vec2(151/ptm_ratio, 105/ptm_ratio)  ,  new b2Vec2(157/ptm_ratio, 128/ptm_ratio)  ] ,
                                                [   new b2Vec2(98/ptm_ratio, 37/ptm_ratio)  ,  new b2Vec2(52/ptm_ratio, -3/ptm_ratio)  ,  new b2Vec2(78/ptm_ratio, 9/ptm_ratio)  ]
											]

										]

									];

			dict["floor"] = [

										[
											// density, friction, restitution
                                            2, 0, 0,
                                            // categoryBits, maskBits, groupIndex, isSensor
											1, 65535, 0, false,
											'POLYGON',

                                            // vertexes of decomposed polygons
                                            [

                                                [   new b2Vec2(600/ptm_ratio, 1/ptm_ratio)  ,  new b2Vec2(599/ptm_ratio, 101/ptm_ratio)  ,  new b2Vec2(0/ptm_ratio, 100/ptm_ratio)  ,  new b2Vec2(-1/ptm_ratio, -1/ptm_ratio)  ]
											]

										]

									];

		}
	}
}
