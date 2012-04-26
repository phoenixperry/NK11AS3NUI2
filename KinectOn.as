package 
{
	import com.as3nui.nativeExtensions.air.kinect.Kinect;
	import com.as3nui.nativeExtensions.air.kinect.KinectSettings;
	import com.as3nui.nativeExtensions.air.kinect.constants.CameraResolution;
	import com.as3nui.nativeExtensions.air.kinect.data.SkeletonJoint;
	import com.as3nui.nativeExtensions.air.kinect.data.User;
	import com.as3nui.nativeExtensions.air.kinect.events.CameraImageEvent;
	
	import flash.geom.Vector3D;
	import flash.sampler.NewObjectSample;
	
	import starling.display.DisplayObject;
	import starling.display.Image;
	import starling.display.MovieClip;
	import starling.display.Quad;
	import starling.display.Sprite;
	import starling.events.Event;

	public class KinectOn extends Sprite
	{
		//kinect vars
		private var _skeletonSprite:Sprite;
	
		private var kinect:Kinect; 
		//custom kinect vars
		private var xpos:Number; 
		private var ypos:Number;
		public var isPlayer:Boolean; 
		
		public function KinectOn()
		{
			_skeletonSprite = new Sprite();
			this.addChild(_skeletonSprite);
			addEventListener(Event.ADDED_TO_STAGE,onAdded); 

		}
		private function onAdded(e:Event):void {
			
			if(Kinect.isSupported()) 
			{
				kinect = Kinect.getDevice(); 
			 
				
				var settings:KinectSettings = new KinectSettings();
				settings.skeletonEnabled = true;
				kinect.start(settings); 
			}
			removeEventListener(Event.ADDED_TO_STAGE,onAdded);
			addEventListener(Event.ENTER_FRAME, onEnterFrame); 
		}

		

		
		protected function onEnterFrame(event:Event):void
		{
			drawSkeletons();
		}
		
		private function drawSkeletons():void
		{
			//_skeletonSprite.removeChildren();
			
			var scaler:Vector3D = new Vector3D(stage.stageWidth, stage.stageHeight, 300);
	
			var elementSprite:Quad;
	
			


			
			var headJoint:SkeletonJoint; 
			var lsj:SkeletonJoint; 
			var lsjxpos:Number; 
			var lsjypos:Number; 
			
			var rsj:SkeletonJoint; 
			var rsjxpos:Number; 
			var rsjypos:Number; 
			
			var lhj:SkeletonJoint; 
			
			var rhj:SkeletonJoint; 
			var rhjxpos:Number; 
			var rhjypos:Number; 
			var rsv:Vector;
			for each(var user:User in kinect.usersWithSkeleton)
			{
				//code for drawing dummy skeleton
//				for (var i:uint = 0; i<skeleton.numJoints;i++)
//				{
//					element = skeleton.getJointScaled(i, scaler);
//					elementSprite = new Quad(20,20,0x000000);
//					
//					elementSprite.x = element.x;
//					elementSprite.y = element.y;
//					
//					_skeletonSprite.addChild(elementSprite);
//					
//				}			
				//get the head joint and set the x,y for the balloon later
				headJoint = user.getJointByName("head"); 
				rsj = user.getJointByName("right_shoulder"); 
				rhj = user.getJointByName("right_hand"); 
				
			//	trace(headJoint.depthRelativePosition.x*stage.stageWidth); 
			
			
					
				xpos = Number(headJoint.depthRelativePosition.x*stage.stageWidth);
				ypos = Number(headJoint.depthRelativePosition.y*stage.stageHeight); 
				
				rsjxpos = Number(rsj.depthRelativePosition.x*stage.stageWidth); 
				rsjypos = Number(rsj.depthRelativePosition.y*stage.stageHeight); 
				
				rhjxpos = Number(rhj.depthRelativePosition.x*stage.stageWidth); 
				rhjypos = Number(rhj.depthRelativePosition.y*stage.stageHeight); 

				
				BalloonActor.xpos = xpos; 
				BalloonActor.ypos = ypos; 
			
				BalloonString.rsxpos = rsjxpos; 
				BalloonString.rsypos = rsjypos; 

				BalloonString.rhxpos = rhjxpos; 
				BalloonString.rhypos = rhjypos; 
				
			}
			
		}
	}
}