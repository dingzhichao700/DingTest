package utils {
	import flash.events.TimerEvent;
	import flash.utils.Dictionary;
	import flash.utils.Timer;
	import flash.utils.getTimer;

	/**
	 * 
	 * @author dingzhichao
	 *
	 */
	public class LoopManager {

		private var delayDic:Dictionary;
		private var delayKey:int;
		private var timer:Timer;
		
		/** 暂停时长数据
		 * key：暂停起始时间戳
		 * value:暂停时长（从暂停到最后一个暂停的所有暂停时长总和）
		 * */
		private var pauseDic:Dictionary;
		/**最近一次暂停的起始时间戳*/
		private var pauseStart:int;
		/**最近一次暂停的结束时间戳*/
		private var pauseEnd:int;
		/**是否暂停中*/
		private var _isPause:Boolean;

		private static var _instance:LoopManager;

		public static function getInstance():LoopManager {
			_instance ||= new LoopManager;
			return _instance;
		}

		public function LoopManager() {
			pauseDic = new Dictionary();
			delayDic = new Dictionary();
			timer = new Timer(10);
			timer.addEventListener(TimerEvent.TIMER, timerLoop);
			timer.start();
		}

		private function timerLoop(e:TimerEvent):void {
			for each (var obj:Object in delayDic) {
				if (getTimer() - obj.start - getPauseTime(obj.start) >= obj.count) {
					var func:Function = obj.callback;
					func.apply(null, obj.arg);
					delayDic[obj.key] = null;
					delete delayDic[obj.key];
				}
			}
		}
		
		/**从某任意时间点到当前为止，暂停过的总时长*/
		private function getPauseTime(startTime:int):int {
			/**晚于(即大于)startTime且最小的暂停起始时间戳
			 * 为0说明startTime之后没有暂停过
			 * */
			var minTime:int;
			for (var str:int in pauseDic){
				if(str > minTime){
					if(minTime == 0){
						minTime == str;
					} else {
						minTime = Math.min(minTime, str);
					}
				}
			}
			return minTime == 0 ? 0 : pauseDic[minTime];
		}

		/**恢复*/
		public function resume():void {
			if(!_isPause){
				return;
			}
			/**最近一次暂停的时长*/
			var pauseTime:int = getTimer() - pauseStart;
			
			/*先让之前每个暂停数据，都加上这个时长*/
			for (var str:int in pauseDic){
				pauseDic[str] += pauseTime;
			}
			/*再插入这个的暂停数据*/
			pauseDic[pauseStart] = pauseTime;
			
			timer.start();
			_isPause = false;
		}

		/**暂停*/
		public function pause():void {
			if(_isPause){
				return;
			}
			_isPause = true;
			timer.stop();
			pauseStart = getTimer();
		}

		/**
		 * 延时执行
		 * @param time 延时(毫秒)
		 * @param func 函数
		 * @param arg 参数
		 *
		 */
		public function doDelay(deley:Number, func:Function, args:Array = null):int {
			if (deley == 0) {
				func.apply(null, args);
				return 0;
			}
			delayKey++;
			delayDic[delayKey] = {key: delayKey, start: getTimer(), count: deley, callback: func as Function, arg: args};
			return delayKey;
		}

		/**
		 * 清除某延时
		 * @param key
		 *
		 */
		public function clearDelay(key:int):void {
			if (delayDic[key]) {
				delayDic[key] = null;
				delete delayDic[key];
			}
		}
		
	}
}
