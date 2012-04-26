package
{
	import flash.events.Event;
	import flash.events.TimerEvent;
	import flash.utils.Timer;
	
	import starling.display.Sprite;

	public class GameTimer extends Sprite
	{
		private var _GameTimer:Timer;
		private var currentTime:Number; 
		public function GameTimer()
		{
			startTimer(); 
		}
		
		public function startTimer():void {
			_GameTimer = new Timer(1000); 
			_GameTimer.start(); 
			_GameTimer.addEventListener(TimerEvent.TIMER, saveTime); 
		}
		
		public function saveTime(e:TimerEvent):void {
			currentTime = e.target.currentCount;  
			trace(currentTime, "I'm the time!"); 
		}

		public function getVirtualTime():Number {
			return currentTime; 
		}

		
//f2
		
		
	}
}