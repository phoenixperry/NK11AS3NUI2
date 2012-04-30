package 
{
	import com.as3nui.nativeExtensions.air.kinect.Kinect;
	import com.as3nui.nativeExtensions.air.kinect.KinectSettings;
	import com.as3nui.nativeExtensions.air.kinect.constants.CameraResolution;
	import com.as3nui.nativeExtensions.air.kinect.data.SkeletonJoint;
	import com.as3nui.nativeExtensions.air.kinect.data.User;
	import com.as3nui.nativeExtensions.air.kinect.events.CameraImageEvent;
	
	import flash.display.Bitmap;
	import flash.geom.Vector3D;
	import flash.sampler.NewObjectSample;
	
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
		private var mps:ParticleDesignerPS;
		
		[Embed(source="./assets/gameOver/sprites/texture.png")] 
		private var _particle:Class;  
		
		[Embed(source="./assets/gameOver/sprites/particle.xml",  mimeType="application/octet-stream")]
		private var particleData:Class;
		

		public function KinectOn()
		{
			_skeletonSprite = new Sprite();
			this.addChild(_skeletonSprite);
			addEventListener(Event.ADDED_TO_STAGE,onAdded); 
			particleXML = XML(new particleData()); 
			particleBits = new _particle(); 
		
				

		}
		private function onAdded(e:Event):void {
			particleTexture = Texture.fromBitmap(particleBits); 
	
			mps = new ParticleDesignerPS(particleXML, particleTexture); 
			mps.emitterX= 800; 
			mps.emitterY = 240; 
			mps.start();
			addChild(mps); 
			Starling.juggler.add(mps); 
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
				torso
				rs = user.getJointByName("right_shoulder"); 
				rh = user.getJointByName("right_hand"); 
				re = user.getJointByName("right_elbow"); 
				rhip = user.getJointByName("right_hip"); 
				rk = user.getJointByName("right_knee"); 
				rf = user.getJointByName("right_foot"); 
				torso = user.getJointByName("torso"); 
				ls = user.getJointByName("shoulder"); 
				le = user.getJointByName("left_elbow"); 
				lhip = user.getJointByName("left_hip"); 
				lk = user.getJointByName("left_knee"); 
				lf = user.getJointByName("left_foot"); 
				
				
			//	trace(headJoint.depthRelativePosition.x*stage.stageWidth); 
			
			
					
				xpos = Number(headJoint.depthRelativePosition.x*stage.stageWidth);
				ypos = Number(headJoint.depthRelativePosition.y*stage.stageHeight); 
				
				rsxpos = Number(rs.depthRelativePosition.x*stage.stageWidth); 
				rsypos = Number(rs.depthRelativePosition.y*stage.stageHeight); 
				
				rhxpos = Number(rh.depthRelativePosition.x*stage.stageWidth); 
				rhypos = Number(rh.depthRelativePosition.y*stage.stageHeight); 

				
				BalloonActor.xpos = xpos; 
				BalloonActor.ypos = ypos; 
			
				BalloonString.rsxpos = rsxpos; 
				BalloonString.rsypos = rsypos; 

				BalloonString.rhxpos = rhxpos; 
				BalloonString.rhypos = rhypos; 
				mps.emitterX = rh.depthRelativePosition.x * stage.stageWidth;
				mps.emitterY = rh.depthRelativePosition.y * stage.stageHeight;
				
				
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
