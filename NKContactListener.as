package
{
	import Box2D.Collision.b2Manifold;
	import Box2D.Common.b2internal;
	import Box2D.Dynamics.Contacts.b2Contact;
	import Box2D.Dynamics.b2ContactListener;
	
	import org.osflash.signals.Signal;
	
	public class NKContactListener extends b2ContactListener
	{
		
		//handles collsions in the b2World 
		public function NKContactListener() 
		{
			super(); 
			trace(this+" initalized");
		
		}
		/** contact started notify actors involved **/ 
		override public function BeginContact(contact:b2Contact):void 
		{
			//extract user data from contacting actors 
			var actorA:Actor = contact.GetFixtureA().GetBody().GetUserData();
			var actorB:Actor = contact.GetFixtureB().GetBody().GetUserData();
			var actorAFixtureUserData:* = contact.GetFixtureA().GetUserData();
			var actorBFixtureUserData:* = contact.GetFixtureB().GetUserData();
			
			
			//ballActor contacted 
			if (actorA is Kitty1 && actorB is BalloonActor) {
		
				trace("kittyhitballoon");
				actorA.hitByActor(actorB);	
			}
			if (actorB is Kitty1 && actorA is BalloonActor) {
				//contact.GetFixtureB().GetBody().GetUserData().contact = true;
			 
				actorB.hitByActor(actorA);
				trace("balloonHitKitty");

			} 		
//		
			 if (actorA is EarthAir && actorB is GlowBody) {
				
				trace("earth hit joint");
				//contact.GetFixtureA().GetBody().GetUserData().contact = true;
				actorA.hitByActor(actorB);
				
			}
			 if (actorB is EarthAir && actorA is GlowBody) {
				//contact.GetFixtureA().GetBody().GetUserData().contact = true;
				actorB.hitByActor(actorA); //check this you might of switched A/B
				trace("joint hit earth");
		
				
			} 
		}
	
	
	}
}
