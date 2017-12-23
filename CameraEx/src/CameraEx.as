package {
	import flash.display.Sprite;
	import flash.text.*;
	import flash.media.Camera;
	import flash.events.StatusEvent;
	import flash.events.ActivityEvent;
	import flash.media.Video;

	public class CameraEx extends Sprite {
		private var label:TextField;
		private var camera:Camera;

		public function CameraEx() {
			label = new TextField();
			label.autoSize = TextFieldAutoSize.LEFT;
			label.text = "CameraEx";
			addChild(label);

			camera = Camera.getCamera();

			if(camera != null) {
				camera.addEventListener(StatusEvent.STATUS, statusHandler);
				camera.addEventListener(ActivityEvent.ACTIVITY, activityHandler);

				var video:Video = new Video(200, 200);
				video.attachCamera(camera);
				addChild(video);
				video.x = 20;
				video.y = 20;
			} else {
				label.text = "不能使用";
			}
		}

		private function statusHandler(evt:StatusEvent):void {
			if(camera.muted) {
				label.text = "不能使用";
			}
		}

		private function activityHandler(evt:ActivityEvent):void {
			if(evt.activating) {
				label.text = "检测开始";
			} else {
				label.text = "检测停止";
			}
		}
	}
}
