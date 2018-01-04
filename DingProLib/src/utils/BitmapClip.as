package utils {
	import flash.display.Bitmap;
	import flash.display.Sprite;
	import flash.events.Event;

	public class BitmapClip extends Sprite {

		private var resName:String;
		private var url:String;
		private var loop:Boolean;
		private var centerPos:Boolean;
		private var count:int;
		private var curIndex:int;

		/**
		 * 
		 * @param resName 特效名  例："role_1,role_2"→"role"
		 * @param url 资源名
		 * @param loop 是否循环
		 * @param count 特效帧数
		 * @param centerPos 是否居中
		 * 
		 */		
		public function BitmapClip(resName:String, url:String = "", loop:Boolean = false, count:int = 5, centerPos:Boolean = false) {
			this.resName = resName;
			this.url = url;
			this.loop = loop;
			this.centerPos = centerPos;
			this.count = count;
			curIndex = 1;
			this.addEventListener(Event.ENTER_FRAME, onFrame);
		}

		private function onFrame(e:Event):void {
			this.removeChildren();
			var bmp:Bitmap = Style.getBitmap(resName + "_" + curIndex, url, this);
			if(centerPos){
				bmp.x = -bmp.width / 2;
				bmp.y = -bmp.height / 2;
			}
			if (curIndex == count) {
				if (loop) {
					curIndex = 1
				} else {
					this.removeChildren();
					this.removeEventListener(Event.ENTER_FRAME, onFrame);
					this.parent.removeChild(this);
				}
			} else {
				curIndex++;
			}
		}

		public static function getBitmapClip(resName:String, url:String = "", loop:Boolean = false, count:int = 5, centerPos:Boolean = false):BitmapClip {
			url == "" ? "common" : url;
			var clip:BitmapClip = new BitmapClip(resName, url, loop, count, centerPos);
			return clip;
		}
	}
}
