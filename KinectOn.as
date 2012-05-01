package 
{
	import com.as3nui.nativeExtensions.air.kinect.Kinect;
	import com.as3nui.nativeExtensions.air.kinect.KinectSettings;
	import com.as3nui.nativeExtensions.air.kinect.constants.CameraResolution;
	import com.as3nui.nativeExtensions.air.kinect.data.SkeletonJoint;
	import com.as3nui.nativeExtensions.air.kinect.data.User;
	import com.as3nui.nativeExtensions.air.kinect.events.CameraImageEvent;
	import com.greensock.TweenLite;
	
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
		//kinect vars
		private var _skeletonSprite:Sprite;
	
		private var kinect:Kinect; 
		//custom kinect vars
		private var xpos:Number; 
		private var ypos:Number;
		public var isPlayer:Boolean; 
		private var particleXML:XML; 
		private var particleTexture:Texture; 
		private var particleBits:Bitmap; 
		private var particleImage:Image; 
		public var user:User;
		
		public var startScreenKinect:Signal;

		private var glowBody:GlowBody; 
		


		

		public function KinectOn()
		{
			_skeletonSprite = new Sprite();
			this.addChild(_skeletonSprite);
			addEventListener(Event.ADDED_TO_STAGE,onAdded); 

			glowBody = new GlowBody(); 
		
				

		}
		private function onAdded(e:Event):void {
		
			addChild(glowBody); 

			
			if(Kinect.isSupported()) 
			{
				kinect = Kinect.getDevice(); 
			 
				
				var settings:KinectSettings = new KinectSettings();
				settings.skeletonEnabled = true;
				kinect.start(settings); 
				this.user = user;
				removeEventListener(Event.ADDED_TO_STAGE,onAdded);
				addEventListener(Event.ENTER_FRAME, onEnterFrame); 
				
				
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
			var hxpos:Number; 
			var hypos:Number; 
			
			var torso:SkeletonJoint; 
			var torsoxpos:SkeletonJoint; 
			var torsoypos:SkeletonJoint; 
			
			//right side of skeleton 
			
			//hand
			var rh:SkeletonJoint; 
			var rhxpos:Number; 
			var rhypos:Number; 
			
			//elbow
			var re:SkeletonJoint; 
			var rexpos:Number; 
			var reypos:Number; 

			//shoulder
			var rs:SkeletonJoint; 
			var rsxpos:Number; 
			var rsypos:Number; 
			
			//hip  
			var rhip:SkeletonJoint; 
			var rhipxpos:Number; 
			var rhipypos:Number; 
		
			//knee   
			var rk:SkeletonJoint; 
			var rkxpos:Number; 
			var rkypos:Number; 
			
			//foot   
			var rf:SkeletonJoint; 
			var rfxpos:Number; 
			var rfypos:Number; 
			
		 	//left side of body
			//shoulder
			var ls:SkeletonJoint; 
			var lsxpos:Number; 
			var lsypos:Number; 
			
			//hand 
			var lh:SkeletonJoint; 
			var lhxpos:Number; 
			var lhypos:Number; 
			//elbow
			var le:SkeletonJoint; 
			var lexpos:Number; 
			var leypos:Number; 
			// hip 
			var lhip:SkeletonJoint; 
			var lhipxpos:Number; 
			var lhipypos:Number; 
			//knee 
			var lk:SkeletonJoint; 
			var lkxpos:Number; 
			var lkypos:Number; 
			//foot
			var lf:SkeletonJoint; 
			var lfxpos:Number; 
			var lfypos:Number; 
			
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
				
				
				GlowBody.xpos4 = Number(headJoint.depthRelativePosition.x*stage.stageWidth);
				GlowBody.ypos4 = Number(headJoint.depthRelativePosition.y*stage.stageHeight); 
				
				//right side 
				GlowBody.xpos6 = Number(rs.depthRelativePosition.x*stage.stageWidth); 
				GlowBody.ypos6 = Number(rs.depthRelativePosition.y*stage.stageHeight); 
				
				GlowBody.xpos = Number(rh.depthRelativePosition.x*stage.stageWidth); 
				GlowBody.ypos = Number(rh.depthRelativePosition.y*stage.stageHeight); 
				
				GlowBody.xpos2 = Number(re.depthRelativePosition.x*stage.stageWidth); 
				GlowBody.ypos2 = Number(re.depthRelativePosition.y*stage.stageHeight); 
				
				GlowBody.xpos3 = Number(rhip.depthRelativePosition.x*stage.stageWidth); 
				GlowBody.xpos3 = Number(rhip.depthRelativePosition.y*stage.stageHeight);
				
				GlowBody.xpos7 = Number(rk.depthRelativePosition.x*stage.stageWidth); 
				GlowBody.ypos7 = Number(rk.depthRelativePosition.y*stage.stageHeight); 
				
				GlowBody.xpos8 = Number(rf.depthRelativePosition.x*stage.stageWidth); 
				GlowBody.ypos8 = Number(rf.depthRelativePosition.y*stage.stageHeight); 
				
				GlowBody.xpos9 = Number(rf.depthRelativePosition.x*stage.stageWidth); 
				GlowBody.ypos9 = Number(rf.depthRelativePosition.y*stage.stageHeight); 
				
				//left side 
				GlowBody.xpos10 = Number(ls.depthRelativePosition.x*stage.stageWidth); 
				GlowBody.ypos10 = Number(ls.depthRelativePosition.y*stage.stageHeight); 
				
				GlowBody.xpos11 = Number(lh.depthRelativePosition.x*stage.stageWidth); 
				GlowBody.ypos11 = Number(lh.depthRelativePosition.y*stage.stageHeight); 
//				
				GlowBody.xpos12 = Number(le.depthRelativePosition.x*stage.stageWidth); 
				GlowBody.ypos12 = Number(le.depthRelativePosition.y*stage.stageHeight); 
				
				GlowBody.xpos13 = Number(lhip.depthRelativePosition.x*stage.stageWidth); 
				GlowBody.xpos13 = Number(lhip.depthRelativePosition.y*stage.stageHeight);
				
				GlowBody.xpos14 = Number(lk.depthRelativePosition.x*stage.stageWidth); 
				GlowBody.xpos14 = Number(lk.depthRelativePosition.y*stage.stageHeight); 
				
				GlowBody.xpos15 = Number(lf.depthRelativePosition.x*stage.stageWidth); 
				GlowBody.xpos15 = Number(lf.depthRelativePosition.y*stage.stageHeight); 
	
				//torso use GlowBody.xpos5 
//				torsoxpos = Number(torso.depthRelativePosition.x*stage.stageWidth); 
//				torsoypos = Number(torso.depthRelativePosition.y*stage.stageHeight); 
				
				BalloonActor.xpos = xpos; 
				BalloonActor.ypos = ypos; 
			
				BalloonString.rsxpos = rsxpos; 
				BalloonString.rsypos = rsypos; 

				BalloonString.rhxpos = rhxpos; 
				BalloonString.rhypos = rhypos; 
				
				//sending out for hand detection
				GameOverStart.rhxpos = GlowBody.xpos; 
				GameOverStart.rhypos = GlowBody.ypos; 
				
				glowBody.update(); 
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
	
		}
	}
