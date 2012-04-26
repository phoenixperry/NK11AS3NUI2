package
{
	import starling.display.Quad;
	import starling.display.Sprite;
	import starling.events.Event; 
	import starling.events.EnterFrameEvent; 
		
	public class LevelTwo extends Sprite 
	{

		public function LevelTwo() 
		{
			addEventListener(Event.ADDED_TO_STAGE, onAdded); 
		}

		private function onAdded(e:Event):void {
			var q:Quad = new Quad(100,100, 0xff00ff, true); 
			this.addChild(q); 
			q.x = stage.stageWidth/2; 
			q.y = stage.stageHeight/2; 
		}
		
		
	}
}