package {
	import flash.display.BitmapData;
	import flash.display.Sprite;
	import flash.display.StageScaleMode;
	import flash.events.TimerEvent;
	import flash.geom.Matrix;
	import flash.media.Camera;
	import flash.media.Video;
	import flash.utils.Timer;

	public class CameraTest extends Sprite {

		private var video:Video;
		private var timer:Timer;
		private var _vid:BitmapData = new BitmapData(640, 480);
		//函数体完成，输出窗口是名为output的文本框
		private var palette:String = "@#$%&8BMW*mwqpdbkhaoQ0OZXYUJCLtfjzxnuvcr[]{}1()|/?Il!i><+_~-;,. ";

		public function CameraTest() {
			stage.scaleMode = StageScaleMode.NO_SCALE;
			
			var camera:Camera = Camera.getCamera();
			var ma:Matrix = new Matrix(0.625, 0, 0, 0.625, 0, 0);
			timer = new Timer(80, 10000);
			timer.addEventListener(TimerEvent.TIMER, forfun);
			
			if(camera != null) {
				timer.start();
				camera.setMode(640, 480, 80);
//				camera.setQuality(0,10);
//				camera.addEventListener(ActivityEvent.ACTIVITY, activityHandler);
				video = new Video(camera.width, camera.height);
				video.attachCamera(camera);
//				video.scaleX = -1.6;
//				video.scaleY =1.6;
//				video.alpha = 0.1;
//				addChildAt(video,1);
//				video.x =1024;
//				video.y = 0
			} else {
				trace("You need a camera.");
			}
		}

		private function bitmapToAscII(_data:BitmapData, horizontalResolution:int, verticalResolution:int):String {
			var result:String = "";
			for(var i:uint = Math.floor(verticalResolution / 2); i < _data.height - Math.floor(verticalResolution / 2); i += verticalResolution) {
				var r:Array = new Array();
				var g:Array = new Array();
				var b:Array = new Array();
				var tmp:int;
				var ra:int;
				var ba:int;
				var ga:int;
				var index:int;

				for(var j:uint = Math.floor(horizontalResolution / 2); j < _data.width - Math.floor(horizontalResolution / 2); j += horizontalResolution) {
					tmp = 0;

					for(var m:int = i - Math.floor(verticalResolution / 2); m < i + Math.floor(verticalResolution / 2) + 1; m++) {
						for(var n:int = j - Math.floor(horizontalResolution / 2); n < j + Math.floor(horizontalResolution / 2) + 1; n++) {
							var _pixel:uint = _data.getPixel(n, m);
							//tmp_bit.setPixel(j,i,_pixel);

							r[tmp] = _pixel >> 16;
							g[tmp] = (_pixel & 0x00ff00) >> 8;
							b[tmp] = _pixel & 0x0000ff;
							tmp++;
						}
					}
					for(m = 0; m < verticalResolution * horizontalResolution; m++) {

						ra += r[m];
						ba += b[m];
						ga += g[m];
					}
					ra /= (verticalResolution * horizontalResolution);
					ga /= (verticalResolution * horizontalResolution);
					ba /= (verticalResolution * horizontalResolution);

					index = (ra + ga + ba) / 12;
//					tmp_pix = ((ra+ga+ba)/3)+(((ra+ga+ba)/3)<<8)+(((ra+ga+ba)/3)<<16);
//					tmp_img.setPixel(j,i,tmp_pix)
					result += palette.charAt(index);
					r = g = b = [];
					ra = ba = ga = 0;
				}
				result += "\n";
			}
			return result;
		}

		private function forfun(e:TimerEvent):void {
			_vid.draw(video);
			output.text = bitmapToAscII(_vid, 3, 8);
		}
	}
}
