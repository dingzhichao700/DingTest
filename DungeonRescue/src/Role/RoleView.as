package Role {
	import flash.display.Bitmap;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.TimerEvent;
	import flash.geom.Point;
	import flash.utils.Timer;

	import utils.Dispatcher;
	import utils.EasyUtils;
	import utils.LoopManager;
	import utils.ResourceManager;

	/**
	 * 角色
	 * @author Administrator
	 *
	 */
	public class RoleView extends Sprite {

		protected var _positionSp:Sprite;
		private var roleCon:Sprite;
		private var roleImg:Bitmap;
		/**角色资源名：如man,woman,monster1*/
		private var _resName:String;
		/**动作名：如stand,walk1,attack1*/
		private var _actName:String;
		/**动作序号：如attack1的1，walk2的2,stand3的3*/
		private var _actIndex:int;
		/**方向，默认为5*/
		private var _dir:int;
		/**上一个方向，用于记录转向*/
		private var _lastDir:int;
		/**当前播放到第几帧*/
		private var _frameIndex:int;

		/**动画计时器*/
		private var actTimer:Timer;
		/**移动计时器*/
		private var moveTimer:Timer;
		/**动画结束回调方法*/
		private var actHandler:Function;
		/**是否有动画结束回调*/
		private var hasActHandle:Boolean;

		/**巡逻状态，0待命，1正向巡逻，-1逆向巡逻*/
		private var parolState:int;
		/**巡逻路径*/
		private var parolList:Array;
		/**当前行动目标点*/
		private var targetPoint:Point;

		/**是否无敌*/
		public var invincible:Boolean;

		public var STEP:Number = 3;
		private const ACT_SPEED:int = 20;

		public function RoleView() {
			ResourceManager.getInstance().getImage("res/shadow.png", this, -40, -22);
			_positionSp = new Sprite();
			_positionSp.graphics.beginFill(0xff0000, /*0.5*/ 0);
			_positionSp.graphics.drawCircle(0, 0, 10);
			addChild(_positionSp);

			roleCon = new Sprite();
			addChild(roleCon);
			roleImg = new Bitmap();
			roleImg.scaleX = roleImg.scaleY = 0.4;
			roleCon.addChild(roleImg);
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
		protected function updateParol():void {
			var start:Point = parolList[0];
			var end:Point = parolList[1];
			switch (parolState) {
				case 0: //不巡逻
					targetPoint = null;
					break;
				case 1: //正向巡逻
					var disToEnd:int = EasyUtils.getDis(end, new Point(x, y))
					if (disToEnd < STEP) { //到终点了
						parolState = -1;
						targetPoint = start;
					} else {
						targetPoint = end;
					}
					break;
				case -1: //反向巡逻
					var disToBegin:int = EasyUtils.getDis(start, new Point(x, y))
					if (disToBegin < STEP) { //回到起点了
						parolState = 1;
						targetPoint = end;
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
				moveTimer.removeEventListener(TimerEvent.TIMER, onMoveTimer);
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
				hasActHandle = actHandler != null;
				roleCon.scaleX = dir <= 5 ? 1 : -1;
			}
		}

		private function onMoveTimer(e:Event):void {
			var targetPoint:Point = this.targetPoint;
			if (targetPoint) {
				//已经在该点 或很靠近
				var dis:int = Math.sqrt((targetPoint.x - x) * (targetPoint.x - x) + (targetPoint.y - y) * (targetPoint.y - y));
				if (dis <= 10) {
					/*直接放到目标点上，并将目标点置空，然后延时执行*/
					x = targetPoint.x;
					y = targetPoint.y;
					this.targetPoint = null;
					attack();
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
			LoopManager.getInstance().doDelay(3000, updateParol);
		}

		private function onActTimer(e:Event):void {
			if (_actName != "" && _actIndex != 0 && _dir != 0) {

				if (_lastDir != _dir) {
					_lastDir = _dir;
					turnDirHandler();
				}

				/*如果有回调函数，则播到最后一帧时触发回调*/
				var frameTotal:int = RoleConstant.getFrameNum(_actName);
				if (_frameIndex > frameTotal) {
					if (hasActHandle) { //此处逻辑待优化，本意是动作播完如需执行回调，则播放到最后一帧时执行，且让画面停在最后一帧
						if (actHandler) {
							actHandler();
							actHandler = null;
						}
						return;
					}
				}

				/*否则继续循环播*/
				_frameIndex = _frameIndex > frameTotal ? 1 : _frameIndex;
				var targetIndex:String = _frameIndex < 10 ? ("00" + _frameIndex) : ("0" + _frameIndex);
				var realDir:int = _dir <= 5 ? _dir : (10 - _dir)
				var targetUrl:String = "res/image/" + _resName + "/" + _actName + "/" + _actName + _actIndex + "/" + realDir + "/" + targetIndex + ".png";
				ResourceManager.getInstance().setImageData(targetUrl, roleImg);
				_frameIndex++;
			}
		}

		/**转向回调，供子类使用*/
		protected function turnDirHandler():void {
		}

		/**攻击，供子类使用*/
		protected function attack():void {
		}

		public function destroy():void {
			if (actTimer) {
				actTimer.stop();
				actTimer.removeEventListener(TimerEvent.TIMER, onActTimer);
				actTimer = null;
			}
			if (moveTimer) {
				moveTimer.stop();
				moveTimer.removeEventListener(TimerEvent.TIMER, onMoveTimer);
				moveTimer = null;
			}
			Dispatcher.offListener(GameEvent.MAIN_LINE_EVENT, onMainLine);
		}

		public function get positionSp():Sprite {
			return _positionSp;
		}

		public function get dir():int {
			return _dir;
		}

		public function get resName():String {
			return _resName;
		}

	}
}
