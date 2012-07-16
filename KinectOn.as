package 
{
	import com.as3nui.nativeExtensions.air.kinect.Kinect;
	import com.as3nui.nativeExtensions.air.kinect.KinectSettings;
	import com.as3nui.nativeExtensions.air.kinect.constants.CameraResolution;
	import com.as3nui.nativeExtensions.air.kinect.data.DeviceCapabilities;
	import com.as3nui.nativeExtensions.air.kinect.data.SkeletonJoint;
	import com.as3nui.nativeExtensions.air.kinect.data.User;
	import com.as3nui.nativeExtensions.air.kinect.events.CameraImageEvent;
	import com.as3nui.nativeExtensions.air.kinect.events.DeviceEvent;
	import com.greensock.TweenLite;
	import com.phoenixperry.BallBtn;
	
	import flash.display.Bitmap;
	import flash.geom.Vector3D;
	import flash.sampler.NewObjectSample;
	
	import org.osflash.signals.Signal;
	
	import starling.core.Starling;
	import starling.display.DisplayObject;
	import starling.display.Image;
	import starling.display.MovieClip;
	import starling.display.Quad;
	import starling.display.Sprite;
	import starling.events.Event;
	import starling.extensions.ParticleDesignerPS;
	import starling.textures.Texture;
	
	public class KinectOn extends Sprite
	{
		public var numJointsInUse:Number = 11; 
		//kinect vars
		private var _skeletonSprite:Sprite;
		
		private var kinect:Kinect; 
		//custom kinect vars
		private  var xpos:Number; 
		private  var ypos:Number;
		public var isPlayer:Boolean; 
		private var particleXML:XML; 
		private var particleTexture:Texture; 
		private var particleBits:Bitmap; 
		private var particleImage:Image; 
		public var user:User;
		public static var gbArray:Array; 
		public var startScreenKinect:Signal;
		private var makeGlowBodies:Boolean; 
		
		public function KinectOn()
		{
			_skeletonSprite = new Sprite();
			this.addChild(_skeletonSprite);
			
			makeGlowBodies = true; 
			gbArray = [];
			if(Kinect.isSupported()) 
			{
				kinect = Kinect.getDevice(); 
				trace("the kinect is on");
				
				var settings:KinectSettings = new KinectSettings();
				settings.skeletonEnabled = true;
				kinect.start(settings); 
				this.user = user;
				kinect.addEventListener(DeviceEvent.STARTED, onAdded, false, 0, true);
			}
		}
		private function onAdded(e:DeviceEvent):void {
			
			//removeEventListener(DeviceEvent.STARTED,onAdded);
			addEventListener(Event.ENTER_FRAME, onEnterFrame); 
			if(makeGlowBodies) {
				for (var i:int = 0; i < 14; i++) 
				{
					var gb:GlowBody = new GlowBody();  
					gbArray.push(gb); 
					addChild(gbArray[i]); 
					makeGlowBodies = false;	
				}
			}
			
			
			
			startScreenKinect = new Signal(); 
			
		}
		
		protected function onEnterFrame(event:Event):void
		{
			drawSkeletons();
		}
		
		private function drawSkeletons():void
		{
			//_skeletonSprite.removeChildren();
			
			var scaler:Vector3D = new Vector3D(stage.stageWidth, stage.stageHeight, 300);
			
			
			var headJoint:SkeletonJoint; 
			var torso:SkeletonJoint; 
			//right side of skeleton 
			//hand
			var rh:SkeletonJoint; 
			var rhxpos:Number; 
			var rhypos:Number; 
			//elbow
			var re:SkeletonJoint;
			//shoulder
			var rs:SkeletonJoint; 
			//hip  
			var rhip:SkeletonJoint; 
			//knee   
			var rk:SkeletonJoint; 
			//foot   
			var rf:SkeletonJoint; 
			//left side of body
			//shoulder
			var ls:SkeletonJoint; 
			//hand 
			var lh:SkeletonJoint; 
			//elbow
			var le:SkeletonJoint; 
			// hip 
			var lhip:SkeletonJoint; 
			//knee 
			var lk:SkeletonJoint; 
			//foot
			var lf:SkeletonJoint; 
			
			
			for each(var user:User in kinect.usersWithSkeleton)
			{
				
				//get the head joint and set the x,y for the balloon later
				headJoint = user.getJointByName("head"); 
				torso = user.getJointByName("torso"); 
				rs = user.getJointByName("right_shoulder"); 
				rh = user.getJointByName("right_hand"); 
				re = user.getJointByName("right_elbow"); 
				rhip = user.getJointByName("right_hip"); 
				rk = user.getJointByName("right_knee"); 
				rf = user.getJointByName("right_foot"); 
				torso = user.getJointByName("torso"); 
				ls = user.getJointByName("left_shoulder"); 
				le = user.getJointByName("left_elbow"); 
				lhip = user.getJointByName("left_hip"); 
				lk = user.getJointByName("left_knee"); 
				lf = user.getJointByName("left_foot"); 
				lh = user.getJointByName("left_hand"); 
				
				
				//	trace(headJoint.depthRelativePosition.x*stage.stageWidth); 
				
				
				
				xpos = Number(headJoint.depthRelativePosition.x*stage.stageWidth);
				ypos = Number(headJoint.depthRelativePosition.y*stage.stageHeight); 
				
				rhxpos =Number(rh.depthRelativePosition.x*stage.stageWidth);
				rhypos = Number(rh.depthRelativePosition.y*stage.stageHeight);
				
				//head 
				gbArray[12].xposMem  = Number(headJoint.depthRelativePosition.x*stage.stageWidth);
				gbArray[12].yposMem = Number(headJoint.depthRelativePosition.y*stage.stageHeight); 
				
				//right side 
				gbArray[0].xposMem = Number(rs.depthRelativePosition.x*stage.stageWidth); 
				gbArray[0].yposMem = Number(rs.depthRelativePosition.y*stage.stageHeight); 
				
				gbArray[1].xposMem = Number(rh.depthRelativePosition.x*stage.stageWidth); 
				gbArray[1].yposMem = Number(rh.depthRelativePosition.y*stage.stageHeight); 
				
				gbArray[2].xposMem = Number(re.depthRelativePosition.x*stage.stageWidth); 
				gbArray[2].yposMem = Number(re.depthRelativePosition.y*stage.stageHeight); 
				
				gbArray[3].xposMem = Number(rhip.depthRelativePosition.x*stage.stageWidth); 
				gbArray[3].yposMem = Number(rhip.depthRelativePosition.y*stage.stageHeight);
				
				gbArray[4].xposMem = Number(rk.depthRelativePosition.x*stage.stageWidth); 
				gbArray[4].yposMem = Number(rk.depthRelativePosition.y*stage.stageHeight); 
				
				gbArray[5].xposMem = Number(rf.depthRelativePosition.x*stage.stageWidth); 
				gbArray[5].yposMem = Number(rf.depthRelativePosition.y*stage.stageHeight); 
				
				
				//left side 
				gbArray[6].xposMem = Number(ls.depthRelativePosition.x*stage.stageWidth); 
				gbArray[6].yposMem = Number(ls.depthRelativePosition.y*stage.stageHeight); 
				
				gbArray[7].xposMem = Number(lh.depthRelativePosition.x*stage.stageWidth); 
				gbArray[7].yposMem = Number(lh.depthRelativePosition.y*stage.stageHeight); 
				
				gbArray[8].xposMem = Number(le.depthRelativePosition.x*stage.stageWidth); 
				gbArray[8].yposMem = Number(le.depthRelativePosition.y*stage.stageHeight); 
				
				gbArray[9].xposMem = Number(lhip.depthRelativePosition.x*stage.stageWidth); 
				gbArray[9].yposMem = Number(lhip.depthRelativePosition.y*stage.stageHeight);
				
				gbArray[10].xposMem = Number(lk.depthRelativePosition.x*stage.stageWidth); 
				gbArray[10].yposMem = Number(lk.depthRelativePosition.y*stage.stageHeight); 
				
				gbArray[11].xposMem = Number(lf.depthRelativePosition.x*stage.stageWidth); 
				gbArray[11].yposMem= Number(lf.depthRelativePosition.y*stage.stageHeight); 
				//	
				//				//torso use GlowBody.xpos5 
				////				torsoxpos = Number(torso.depthRelativePosition.x*stage.stageWidth); 
				////				torsoypos = Number(torso.depthRelativePosition.y*stage.stageHeight); 
				//				
				//				BalloonActor.xpos = xpos; 
				//				BalloonActor.ypos = ypos; 
				//			
				
				//sending out for hand detection
				GameOverStart.rhxpos = gbArray[1].xposMem; 
				GameOverStart.rhypos = gbArray[1].yposMem; 
				BallBtn.rhxpos =  gbArray[1].xposMem; 
				BallBtn.rhypos =  gbArray[1].yposMem; 
			}
		}
		public function renderSkeleton():void { 
			
			var numJoints:uint = user.skeletonJoints.length;
			//create labels
			for(var i:int = 0; i < numJoints; i++)
			{	
				var joint:SkeletonJoint = user.skeletonJoints[i];
				
			}
		}
		public function jointsLeft():Number { 
			var num:Number = gbArray.length; 
			return num;
			trace(num); 
		}
		
	}
}