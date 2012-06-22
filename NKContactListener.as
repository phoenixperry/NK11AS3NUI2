
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

			trace(actorA, contact.GetFixtureA().GetBody().GetUserData(), actorB); 
			if(actorA is EarthAir) { 
				actorB.hitByActor(actorA); 
			}
			
				
		}
			//			
//			if (actorB is EarthAir && actorA is GlowBody) {
//				
//		
//				//contact.GetFixtureA().GetBody().GetUserData().contact = true;
//				actorA.hitByActor(actorB);
//				
//			}
//			 if (actorA is EarthAir && actorB is GlowBody) {
//				//contact.GetFixtureA().GetBody().GetUserData().contact = true;
//				actorB.hitByActor(actorA); //check this you might of switched A/B

		
				
		//	} 
		//}
	
	
	}
}

