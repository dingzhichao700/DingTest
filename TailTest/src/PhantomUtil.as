package {
	import com.greensock.TweenMax;
	
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	import flash.events.TimerEvent;
	import flash.utils.Timer;

	public class PhantomUtil extends Sprite {

		private var roleList:Array;
		private var phantomList:Array;
		private var con:Sprite;
		private var phantomTimer:Timer;
		private static var _instance:PhantomUtil;

		public static function getInstance():PhantomUtil {
			_instance ||= new PhantomUtil();
			return _instance;
		}

		public function PhantomUtil() {
			phantomTimer = new Timer(120, 0);
			phantomTimer.addEventListener(TimerEvent.TIMER, onFrame);
			phantomTimer.start();
		}

		public function setLayer(sp:Sprite):void {
			con = sp;
		}

		private function onFrame(e:TimerEvent):void {
			phantomList ||= [];
			var drawList:Array = [];
			if(roleList && roleList.length > 0) {
				for(var i:int = 0; i < roleList.length; i++) {
					var role:DisplayObject = roleList[i] as DisplayObject;
					var bmd:BitmapData = new BitmapData(role.width, role.y + role.height, true, 0);
					bmd.draw(role);
					var bmp:Bitmap = new Bitmap(bmd);
					con.addChild(bmp);
					con.buttonMode
					drawList.push(bmp);
				}
				phantomList.push(drawList);

				var oldestList:Array = phantomList.shift();
				for(var j:int = 0; j < oldestList.length; j++) {
					var bitmap:Bitmap = oldestList[j] as Bitmap;
					TweenMax.to(bitmap, 1, {alpha:0, onComplete:tweenOut, onCompleteParams:[bitmap]});
				}
			}
		}

		public function tweenOut(bitmap:Bitmap):void {
			bitmap.parent.removeChild(bitmap);
			bitmap = null;
		}
		
		public function addRole(obj:DisplayObject):void {
			roleList ||= new Array();
			if(roleList.indexOf(obj) == -1) {
				roleList.push(obj);
			}
		}

		public function removeRole(obj:DisplayObject):void {
			roleList ||= new Array();
			if(roleList.indexOf(obj) != -1) {
				roleList.splice(roleList.indexOf(obj), 1);
			}
		}
	}
}
