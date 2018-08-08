package Role {
	import flash.display.Bitmap;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.TimerEvent;
	import flash.utils.Timer;

	import utils.ResourceManager;

	/**
	 * 角色
	 * @author Administrator
	 *
	 */
	public class RoleView extends Sprite {

		/**角色资源名：如man,woman,monster1*/
		private var _resName:String;
		/**动作名：如stand,walk1,attack1*/
		private var _actName:String;
		/**动作序号：如attack1的1，walk2的2,stand3的3*/
		private var _actIndex:int;
		/**方向，默认为5*/
		private var _dir:int;

		/**当前播放到第几帧*/
		private var _frameIndex:int;

		private var roleImg:Bitmap;
		private var actTimer:Timer;
		private const ACT_SPEED:int = 20;

		public function RoleView() {
			this.graphics.beginFill(0xff0000, 0.5);
			this.graphics.drawCircle(0, 0, 10);

			roleImg = new Bitmap();
			roleImg.scaleX = roleImg.scaleY = 0.4;
			roleImg.x = -60;
			roleImg.y = -135;
			this.addChild(roleImg);
		}
		
		public function setRes(resName:String):void {
			_resName = resName;
			_dir = 5;
		}

		private function onTimer(e:Event):void {
			if (_actName != "" && _actIndex != 0 && _dir != 0) {
				var frameTotal:int = RoleConstant.getFrameNum(_actName);
				_frameIndex = _frameIndex > frameTotal ? 1 : _frameIndex;
				var targetIndex:String = _frameIndex < 10 ? ("00" + _frameIndex) : ("0" + _frameIndex);
				var realDir:int = _dir <= 5 ? _dir : (10 - _dir)
				var targetUrl:String = "image/" + _resName + "/" + _actName + "/" + _actName + _actIndex + "/" + realDir + "/" + targetIndex + ".png";
				ResourceManager.getInstance().setImageData(targetUrl, roleImg);
				_frameIndex++;
			}
		}

		public function play(actName:String, actIndex:int = 1, dir:int = 5):void {
			if (!actTimer) {
				actTimer = new Timer(ACT_SPEED);
				actTimer.addEventListener(TimerEvent.TIMER, onTimer);
				actTimer.start();
			}
			
			if (_actName == actName && _actIndex == actIndex && _dir == dir) { //尝试播放同类，同名，同方向动作时，返回
				return;
			} else {
				_actName = actName;
				_actIndex = actIndex;
				_dir = dir;
				_frameIndex = 1;
				this.scaleX = dir <= 5 ? 1 : -1;
			}
		}

		public function stop():void {
			if (actTimer) {
				actTimer.stop();
				actTimer.removeEventListener(TimerEvent.TIMER, onTimer);
				actTimer = null;
			}
		}

	}
}
