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
		private var mps2:ParticleDesignerPS;
		private var mps3:ParticleDesignerPS;
		private var mps4:ParticleDesignerPS;
		private var mps5:ParticleDesignerPS;
		private var mps6:ParticleDesignerPS;
		private var mps7:ParticleDesignerPS;
		private var mps8:ParticleDesignerPS;
		private var mps9:ParticleDesignerPS;
		private var mps10:ParticleDesignerPS;
		private var mps11:ParticleDesignerPS;
		private var mps12:ParticleDesignerPS;
		private var mps13:ParticleDesignerPS;
		private var mps14:ParticleDesignerPS;
		
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
			mps2 = new ParticleDesignerPS(particleXML, particleTexture);
			mps3 = new ParticleDesignerPS(particleXML, particleTexture);
			mps4 = new ParticleDesignerPS(particleXML, particleTexture);
			mps5 = new ParticleDesignerPS(particleXML, particleTexture);
			mps6 = new ParticleDesignerPS(particleXML, particleTexture);
			mps7 = new ParticleDesignerPS(particleXML, particleTexture);
			mps8 = new ParticleDesignerPS(particleXML, particleTexture);
			mps9 = new ParticleDesignerPS(particleXML, particleTexture);
			mps10 = new ParticleDesignerPS(particleXML, particleTexture);
			mps11 = new ParticleDesignerPS(particleXML, particleTexture);
			mps12 = new ParticleDesignerPS(particleXML, particleTexture);
			mps13 = new ParticleDesignerPS(particleXML, particleTexture);
			mps14 = new ParticleDesignerPS(particleXML, particleTexture);
			mps.emitterX= 800; 
			mps.emitterY = 240; 
			mps.start();
			mps2.start();
			mps3.start();
			mps4.start();
			mps5.start();
			mps6.start();
			mps7.start();
			mps8.start();
			mps9.start();
			mps10.start();
			mps11.start();
			mps12.start();
			mps13.start();
			mps14.start();
	
			addChild(mps); 

			addChild(mps2);
			addChild(mps3);
			addChild(mps4);
			addChild(mps5);
			addChild(mps6);
			addChild(mps7);
			addChild(mps8);
			addChild(mps9);
			addChild(mps10);
			addChild(mps11);
			addChild(mps12);
			addChild(mps13);
			addChild(mps14); 
			Starling.juggler.add(mps); 
			Starling.juggler.add(mps2);
			Starling.juggler.add(mps3);
			Starling.juggler.add(mps4);
			Starling.juggler.add(mps5);
			Starling.juggler.add(mps6);
			Starling.juggler.add(mps7);
			Starling.juggler.add(mps8);
			Starling.juggler.add(mps9);
			Starling.juggler.add(mps10);
			Starling.juggler.add(mps11);
			Starling.juggler.add(mps12);
			Starling.juggler.add(mps13);
			Starling.juggler.add(mps14);
			
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
				//right side 
				rsxpos = Number(rs.depthRelativePosition.x*stage.stageWidth); 
				rsypos = Number(rs.depthRelativePosition.y*stage.stageHeight); 
				
				rhxpos = Number(rh.depthRelativePosition.x*stage.stageWidth); 
				rhypos = Number(rh.depthRelativePosition.y*stage.stageHeight); 
				
				rexpos = Number(re.depthRelativePosition.x*stage.stageWidth); 
				reypos = Number(re.depthRelativePosition.y*stage.stageHeight); 
				
				rhipxpos = Number(rhip.depthRelativePosition.x*stage.stageWidth); 
				rhipypos = Number(rhip.depthRelativePosition.y*stage.stageHeight);
				
				rkxpos = Number(rk.depthRelativePosition.x*stage.stageWidth); 
				rkypos = Number(rk.depthRelativePosition.y*stage.stageHeight); 
				
				rfxpos = Number(rf.depthRelativePosition.x*stage.stageWidth); 
				rfypos = Number(rf.depthRelativePosition.y*stage.stageHeight); 
				
				rfxpos = Number(rf.depthRelativePosition.x*stage.stageWidth); 
				rfypos = Number(rf.depthRelativePosition.y*stage.stageHeight); 
				
				//left side 
				lsxpos = Number(ls.depthRelativePosition.x*stage.stageWidth); 
				lsypos = Number(ls.depthRelativePosition.y*stage.stageHeight); 
				
				lhypos = Number(lh.depthRelativePosition.x*stage.stageWidth); 
				lhypos = Number(lh.depthRelativePosition.y*stage.stageHeight); 
//				
				lexpos = Number(le.depthRelativePosition.x*stage.stageWidth); 
				leypos = Number(le.depthRelativePosition.y*stage.stageHeight); 
				
				lhipxpos = Number(lhip.depthRelativePosition.x*stage.stageWidth); 
				lhipypos = Number(lhip.depthRelativePosition.y*stage.stageHeight);
				
				lkxpos = Number(lk.depthRelativePosition.x*stage.stageWidth); 
				lkypos = Number(lk.depthRelativePosition.y*stage.stageHeight); 
				
				lfxpos = Number(lf.depthRelativePosition.x*stage.stageWidth); 
				lfypos = Number(lf.depthRelativePosition.y*stage.stageHeight); 
				
				lfxpos = Number(lf.depthRelativePosition.x*stage.stageWidth); 
				lfypos = Number(lf.depthRelativePosition.y*stage.stageHeight); 
				//torso
//				torsoxpos = Number(torso.depthRelativePosition.x*stage.stageWidth); 
//				torsoypos = Number(torso.depthRelativePosition.y*stage.stageHeight); 
				
				BalloonActor.xpos = xpos; 
				BalloonActor.ypos = ypos; 
			
				BalloonString.rsxpos = rsxpos; 
				BalloonString.rsypos = rsypos; 

				BalloonString.rhxpos = rhxpos; 
				BalloonString.rhypos = rhypos; 
				
				mps.emitterX = rh.depthRelativePosition.x * stage.stageWidth;
				mps.emitterY = rh.depthRelativePosition.y * stage.stageHeight;
				
				mps2.emitterX = re.depthRelativePosition.x * stage.stageWidth;
				mps2.emitterY = re.depthRelativePosition.y * stage.stageHeight;
				
				mps3.emitterX = rs.depthRelativePosition.x * stage.stageWidth;
				mps3.emitterY = rs.depthRelativePosition.y * stage.stageHeight;
				
				mps4.emitterX = headJoint.depthRelativePosition.x * stage.stageWidth;
				mps4.emitterY = headJoint.depthRelativePosition.y * stage.stageHeight;
				
				mps5.emitterX = ls.depthRelativePosition.x * stage.stageWidth;
				mps5.emitterY = ls.depthRelativePosition.y * stage.stageHeight;
				
				mps6.emitterX = le.depthRelativePosition.x * stage.stageWidth;
				mps6.emitterY = le.depthRelativePosition.y * stage.stageHeight;
				
				mps7.emitterX = lh.depthRelativePosition.x * stage.stageWidth;
				mps7.emitterY = lh.depthRelativePosition.y * stage.stageHeight;
				
				mps8.emitterX = rhip.depthRelativePosition.x * stage.stageWidth;
				mps8.emitterY = rhip.depthRelativePosition.y * stage.stageHeight;
				
				mps9.emitterX = rk.depthRelativePosition.x * stage.stageWidth;
				mps9.emitterY = rk.depthRelativePosition.y * stage.stageHeight;
				
				mps10.emitterX = rf.depthRelativePosition.x * stage.stageWidth;
				mps10.emitterY = rf.depthRelativePosition.y * stage.stageHeight;
				
				mps11.emitterX = lhip.depthRelativePosition.x * stage.stageWidth;
				mps11.emitterY = lhip.depthRelativePosition.y * stage.stageHeight;
				
				mps12.emitterX = lk.depthRelativePosition.x * stage.stageWidth;
				mps12.emitterY = lk.depthRelativePosition.y * stage.stageHeight;
				
				mps13.emitterX = lf.depthRelativePosition.x * stage.stageWidth;
				mps13.emitterY = lf.depthRelativePosition.y * stage.stageHeight;
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
