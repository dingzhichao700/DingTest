package {
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.Sprite;
	import flash.events.TimerEvent;
	import flash.media.Camera;
	import flash.media.Video;
	import flash.utils.Timer;
	
	import gs.TweenLite;
	import gs.easing.Cubic;
	
	import jp.maaash.ObjectDetection.ObjectDetector;
	import jp.maaash.ObjectDetection.ObjectDetectorEvent;
	import jp.maaash.ObjectDetection.ObjectDetectorOptions;
	
	public class FaceDetactor extends Sprite {
		
		//How long a rectangle will remain visible after no faces are found
		private const __noFaceTimeout : int = 500;
		
		//how often to analyze the webcam image
		private const __faceDetectInterval : int = 50;
		
		//color of the rectangle
		private const __rectColor : int = 0xff0000;
		
		private var _detector    :ObjectDetector;
		private var _options     :ObjectDetectorOptions;
		private var _bmpTarget   :Bitmap;
		
		private var _detectionTimer : Timer;
		
		private var _rects:Array;
		
		private var _video : Video;
		private var _noFaceTimer : Timer;
		
		public var cameraContainer : Sprite;
		
		public function FaceDetactor() {
			
			//Timer for rectangles not being found
			_noFaceTimer = new Timer( __noFaceTimeout );
			_noFaceTimer.addEventListener( TimerEvent.TIMER , _noFaceTimer_timer);
			
			//Array of reusable rectangles
			_rects = new Array( );
			
			//timer for how often to detect
			_detectionTimer = new Timer( __faceDetectInterval );
			_detectionTimer.addEventListener( TimerEvent.TIMER , _detectionTimer_timer);
			_detectionTimer.start();
			
			//initalize detector			
			_initDetector();
			
			//set up camera
			_setupCamera();
			
			//hook up detection complete
			_detector.addEventListener( ObjectDetectorEvent.DETECTION_COMPLETE , _detection_complete );
			
		}
		
		private function _setupCamera() : void{
			
			var camera : Camera;
			
			var index:int = 0;
			for ( var i : int = 0 ; i < Camera.names.length ; i ++ ) {
				
				if ( Camera.names[ i ] == "USB Video Class Video" ) {
					index = i;
				}
			}
			
			camera  = Camera.getCamera( String( index ) );
			camera.setMode(320, 240, 24);
			
			if (camera != null) {
				_video = new Video( camera.width , camera.height );
				_video.attachCamera( camera );
				addChild( _video );
				
			} else {
				trace( "You need a camera." );
			}
			
		}
		
		/**
		 * Called when No faces are found after __noFaceTimeout time
		 */
		private function _noFaceTimer_timer (event : TimerEvent) : void {
			
			_noFaceTimer.stop();
			
			for (var i : int = 0; i < _rects.length; i++) {
				
				TweenLite.to( _rects[i] , .5, {
					alpha:0,
					x:_rects[i].x + _video.x, 
					y:_rects[i].y,
					ease:Cubic.easeOut	
				} );					
				
			}
			
		}
		
		/**
		 * Creates a rectangle
		 */
		private function _createRect() : Sprite{
			
			var rectContainer : Sprite = new Sprite();
			rectContainer.graphics.lineStyle( 2 , __rectColor , 1 );
			rectContainer.graphics.beginFill(0x000000,0);
			rectContainer.graphics.drawRect(0, 0, 100, 100);
			
			return rectContainer;
			
		}
		
		/**
		 * Evalutates the webcam video for faces on a timer
		 */		
		private function _detectionTimer_timer (event : TimerEvent) : void {
			
			_bmpTarget = new Bitmap( new BitmapData( _video.width, _video.height, false ) );
			_bmpTarget.bitmapData.draw( _video );
			_detector.detect( _bmpTarget );
			
		}
		
		/**
		 * Fired when a detection is complete
		 */
		private function _detection_complete (event : ObjectDetectorEvent) : void {
			
			//no faces found
			if(event.rects.length == 0) return;
			
			//stop the no-face timer and start back up again
			_noFaceTimer.stop( );
			_noFaceTimer.start();
			
			//loop through faces found			
			for (var i : int = 0; i < event.rects.length ; i++) {
				
				//create rectangles if needed
				if(_rects[i] == null){
					_rects[i] = _createRect();
					addChild(_rects[i]);
				}
				
				//Animate to new size
				TweenLite.to( _rects[i] , .5, {
					alpha:1,
					x:event.rects[i].x*_video.scaleX + _video.x,
					y:event.rects[i].y*_video.scaleY,
					width:event.rects[i].width*_video.scaleX,
					height:event.rects[i].height*_video.scaleY,
					ease:Cubic.easeOut	
				} );
				
			}
			
			//hide the rest of the rectangles
			if(event.rects.length < _rects.length){
				for (var j : int = event.rects.length; j < _rects.length; j++) {
					TweenLite.to( _rects[j] , .5, {
						alpha:0,
						x:_rects[j].x,
						y:_rects[j].y,
						ease:Cubic.easeOut	
					} );					
				}
			}
		}
		
		/**
		 * Initializes the detector
		 */
		private function _initDetector () : void {
			
			_detector = new ObjectDetector;
			_detector.options = getDetectorOptions( );
			_detector.loadHaarCascades( "face.zip" );
			
		}
		
		/**
		 * Gets dector options
		 */
		private function getDetectorOptions () : ObjectDetectorOptions {
			
			_options = new ObjectDetectorOptions;
			_options.min_size = 50;
			_options.startx = ObjectDetectorOptions.INVALID_POS;
			_options.starty = ObjectDetectorOptions.INVALID_POS;
			_options.endx = ObjectDetectorOptions.INVALID_POS;
			_options.endy = ObjectDetectorOptions.INVALID_POS;
			return _options;
			
		}
	}
}