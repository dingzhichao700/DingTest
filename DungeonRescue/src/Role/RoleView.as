package Role {
	import flash.display.Bitmap;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.TimerEvent;
	import flash.geom.Point;
	import flash.utils.Timer;

	import utils.Dispatcher;
	import utils.LoopManager;
	import utils.ResourceManager;

	/**
	 * 角色
	 * @author Administrator
	 *
	 */
	public class RoleView extends Sprite {

		private var roleImg:Bitmap;
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

		/**动画计时器*/
		private var actTimer:Timer;
		/**移动计时器*/
		private var moveTimer:Timer;
		/**动画结束回调方法*/
		private var actHandler:Function;

		/**巡逻状态，0待命，1正向巡逻，-1逆向巡逻*/
		private var parolState:int;
		/**巡逻路径*/
		private var parolList:Array;
		/**当前行动目标点*/
		private var targetPoint:Point;

		private const ACT_SPEED:int = 20;
		public static const STEP:int = 3;

		public function RoleView() {
			this.graphics.beginFill(0xff0000, 0.5);
			this.graphics.drawCircle(0, 0, 10);

			roleImg = new Bitmap();
			roleImg.scaleX = roleImg.scaleY = 0.4;
			this.addChild(roleImg);
			Dispatcher.addListener(GameEvent.MAIN_LINE_EVENT, onMainLine);
		}

		public function setRes(resName:String):void {
			_resName = resName;
			roleImg.x = _resName == "enemy2" ? -76 : -60;
			roleImg.y = -135;
			_dir = 5;
			play("stand", 1);
		}

		/**设置巡逻*/
		public function setParol(start:Point, end:Point):void {
			parolList = [start, end];
			this.x = start.x;
			this.y = start.y;
			parolState = 1;
			updateParol();
		}

		/**更新巡逻状态*/
		private function updateParol():void {
			switch (parolState) {
				case 0: //不巡逻
					targetPoint = null;
					break;
				case 1: //正向巡逻
					var end:Point = parolList[1];
					if (x == end.x && y == end.y) {//到终点了
						parolState = -1;
						updateParol();
					} else {
						targetPoint = end;
					}
					break;
				case -1: //反向巡逻
					var start:Point = parolList[0];
					if (x == start.x && y == start.y) {//回到起点了
						parolState = 1;
						updateParol();
					} else {
						targetPoint = start;
					}
					break;
			}
		}

		/**侦听总线事件*/
		private function onMainLine(str:String):void {
			switch (str) {
				case GameEvent.LINE_START:
					startTimer();
					break;
				case GameEvent.LINE_PAUSE:
					pauseTimer();
					break;
			}
		}

		/**行动*/
		private function startTimer():void {
			actTimer ||= new Timer(ACT_SPEED);
			actTimer.addEventListener(TimerEvent.TIMER, onActTimer);
			actTimer.start();
			moveTimer ||= new Timer(ACT_SPEED);
			moveTimer.addEventListener(TimerEvent.TIMER, onMoveTimer);
			moveTimer.start();
		}

		/**暂停*/
		private function pauseTimer():void {
			if (actTimer) {
				actTimer.stop();
				actTimer.removeEventListener(TimerEvent.TIMER, onActTimer);
			}
			if (moveTimer) {
				moveTimer.stop();
				moveTimer.removeEventListener(TimerEvent.TIMER, onActTimer);
			}
		}

		public function play(actName:String, actIndex:int = 1, dir:int = 5, handler:Function = null):void {
			if (_actName == actName && _actIndex == actIndex && _dir == dir) { //尝试播放同类，同名，同方向动作时，返回
				return;
			} else {
				_actName = actName;
				_actIndex = actIndex;
				_dir = dir;
				_frameIndex = 1;
				actHandler = handler;
				this.scaleX = dir <= 5 ? 1 : -1;
			}
		}

		private function onMoveTimer(e:Event):void {
			var targetPoint:Point = this.targetPoint;
			if (targetPoint) {
				//已经在该点 或很靠近
				if ((x == targetPoint.x && y == targetPoint.y) || (Math.abs(targetPoint.x - x) < STEP && Math.abs(targetPoint.y - y) < STEP)) {
					/*直接放到目标点上，并将目标点置空，然后延时执行*/
					x = targetPoint.x;
					y = targetPoint.y;
					this.targetPoint = null;
					LoopManager.getInstance().doDelay(3000, moveOverHandler);
					trace("1");
					play("stand", 1);
				} else { //还有距离，移动过去
					var xDis:int = targetPoint.x - x;
					var yDis:int = targetPoint.y - y;
					/*设置方向*/
					_dir = Math.abs(xDis) > Math.abs(yDis) ? (xDis > 0 ? 3 : 7) : (yDis > 0 ? 5 : 1);
					if (Math.abs(targetPoint.x - x) < STEP) {
						x = targetPoint.x;
					} else {
						x += xDis > 0 ? STEP : -STEP;
					}
					if (Math.abs(targetPoint.y - y) < STEP) {
						y = targetPoint.y;
					} else {
						y += yDis > 0 ? STEP : -STEP;
					}
					play("run", 1, _dir);
				}
			}
		}

		protected function moveOverHandler():void {
			updateParol();
		}

		private function onActTimer(e:Event):void {
			if (_actName != "" && _actIndex != 0 && _dir != 0) {

				/*如果有回调函数，则播到最后一帧时触发回调*/
				var frameTotal:int = RoleConstant.getFrameNum(_actName);
				if (_frameIndex > frameTotal && actHandler != null) {
					actHandler();
					return;
				}

				/*否则继续循环播*/
				_frameIndex = _frameIndex > frameTotal ? 1 : _frameIndex;
				var targetIndex:String = _frameIndex < 10 ? ("00" + _frameIndex) : ("0" + _frameIndex);
				var realDir:int = _dir <= 5 ? _dir : (10 - _dir)
				var targetUrl:String = "image/" + _resName + "/" + _actName + "/" + _actName + _actIndex + "/" + realDir + "/" + targetIndex + ".png";
				ResourceManager.getInstance().setImageData(targetUrl, roleImg);
				_frameIndex++;
			}
		}

		public function stop():void {
			if (actTimer) {
				actTimer.stop();
				actTimer.removeEventListener(TimerEvent.TIMER, onActTimer);
				actTimer = null;
			}
		}

	}
}
