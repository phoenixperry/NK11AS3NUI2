package  {
	import Box2D.Dynamics.b2World;
	
	import starling.display.Sprite;
	/**
	 * ...
	 * @author phoenix
	 */
	public class PhysiVal extends Sprite

	{
		public static var RATIO:Number = 30;
		private static var _world:b2World; 
		
		public function PhysiVal() 
		{
		}
		
		static public function get rat():Number 
		{
			return RATIO;
		}

		
	}
	
}