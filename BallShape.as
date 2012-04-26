package  
{
	import starling.display.Quad;
	import starling.display.Sprite; 
	
	/**
	 * ...
	 * @author phoenix
	 */
	public class BallShape extends Sprite
	{
		private var ball:Quad; 
		public function BallShape() 
		{
			ball = new Quad(20,20,0xFF00FF, true); 
			
			addChild(ball); 
		}
	}
}
