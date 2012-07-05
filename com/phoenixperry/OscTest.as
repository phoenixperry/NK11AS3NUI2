package com.phoenixperry
{
	import flash.display.Sprite;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;
	import flash.text.TextFormat;
	import flash.utils.setTimeout;
	
	import org.tuio.connectors.UDPConnector;
	import org.tuio.osc.IOSCListener;
	import org.tuio.osc.OSCManager;
	import org.tuio.osc.OSCMessage;
	
	import org.tuio.ITuioListener; 
	
	[SWF( backgroundColor="#FFFFFF", frameRate = "40", width="600", height="400")]
	
	public class OscTest extends Sprite implements IOSCListener//implement IOSCListener interface in order to accept messages in acceptOSCMessage function below
	{
		private var _tLog			: TextField;
		private var _oscManager	: OSCManager;
		
		public function OscTest()
		{
			stage.align = StageAlign.TOP_LEFT;
			stage.scaleMode = StageScaleMode.NO_SCALE;
			
			//create textfield to log data
			var tFormat:TextFormat = new TextFormat(null, 16);
			_tLog=new TextField();
			_tLog.width=500;
			_tLog.height=300;
			_tLog.x=20;
			_tLog.y=20;
			_tLog.autoSize=TextFieldAutoSize.LEFT;
			_tLog.defaultTextFormat=tFormat;
			_tLog.text="default text";
			addChild(_tLog);
			
			//create manager - in TUIO lib http://www.tuio.org/?flash - to listen for data from FaceOSC
			_oscManager = new OSCManager(new UDPConnector("127.0.0.1",3334, true),null, false);//port 8338 because that is the port being used by FaceOSC
			_oscManager.addMsgListener(this);
			
			/*if I don't set a delay here, data are not coming in, not sure why...if you put the osc logic into a seperate class, 
			for instance Receiver.as - and make the osc manager instance public - then starting the manager after instantiating the Receiver class also works:
			var oscReceiver:Receiver=new Receiver();
			oscReceiver.oscmanager.start();
			*/
			setTimeout(startManager, 1000);
		}
		
		private function startManager():void
		{
			_oscManager.start();
		}
		
		public function acceptOSCMessage(oscmsg:OSCMessage):void//this function is called from the TUIO lib and receives the osc data
		{
			
			trace(oscmsg.address); 
			//			switch (oscmsg.address)
			//			{
			//				//open up the FaceOSC_Osculator file to see all the addresses associated with gestures
			//				case "/pose/orientation":
			//					trace(oscmsg.address + ": " + oscmsg.arguments[0], oscmsg.arguments[1]);
			//					_tLog.text=oscmsg.address + ": " + oscmsg.arguments[0] + " - " +  oscmsg.arguments[1];
			//					break;
			//				case "/gesture/mouth/height":
			//					trace(oscmsg.address + ": " + oscmsg.arguments[0]);
			//					_tLog.appendText("\n" + oscmsg.address + ": " + oscmsg.arguments[0]);
			//					break;
			//				
			//				default:
			//					break;
			//			}
		}
		
	}
}
