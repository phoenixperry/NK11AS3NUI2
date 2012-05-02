package
{
	import Box2D.Collision.b2Manifold;
	import Box2D.Common.b2internal;
	import Box2D.Dynamics.Contacts.b2Contact;
	import Box2D.Dynamics.b2ContactListener;
	
	import org.osflash.signals.Signal;
	
	public class NKContactListener extends b2ContactListener
	{
		var glowHit:Signal; 
		var earthHit:Signal; 
		//handles collsions in the b2World 
		public function NKContactListener() 
		{
			super(); 
			trace(this+" initalized");
			glowHit = new Signal(); 
			earthHit = new Signal(); 
			
		}
		/** contact started notify actors involved **/ 
		override public function BeginContact(contact:b2Contact):void 
		{
			//extract user data from contacting actors 
			var actorA:Actor = contact.GetFixtureA().GetBody().GetUserData();
			var actorB:Actor = contact.GetFixtureB().GetBody().GetUserData();
			var actorAFixtureUserData:* = contact.GetFixtureA().GetUserData();
			var actorBFixtureUserData:* = contact.GetFixtureB().GetUserData();
			
			//ballActor and PegActor contacted 
			if (actorA is Kitty1 && actorB is BalloonActor) {
		
				trace("kittyhitballoon");
				actorA.hitByActor(actorB);	
			}
			else if (actorB is Kitty1 && actorA is BalloonActor) {
				//contact.GetFixtureB().GetBody().GetUserData().contact = true;
			 
				actorB.hitByActor(actorA);
				trace("balloonHitKitty");
				earthHit.dispatch("glowBall hit some earth"); 
			} 		
		
			if (actorA is EarthAir && actorB is GlowBody) {
				
				trace("earth hit joint");
				actorA.hitByActor(actorB);
				glowHit.dispatch("glow joint hit by earth", .02, 1); 
			}
			else if (actorB is EarthAir && actorA is GlowBody) {
				//contact.GetFixtureB().GetBody().GetUserData().contact = true;
				
				actorB.hitByActor(actorA);
				trace("joint hit earth");
			} 
		}
	
	
	}
}
