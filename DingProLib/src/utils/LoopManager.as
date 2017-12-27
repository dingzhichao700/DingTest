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

		private static var delayDic:Dictionary;
		private static var delayKey:int;
		private static var delayTimer:Timer;

		public function LoopManager() {
		}

		public static function init():void {
			delayDic = new Dictionary();
			delayTimer = new Timer(50);
			delayTimer.addEventListener(TimerEvent.TIMER, timerLoop);
			delayTimer.start();
		}

		private static function timerLoop(e:TimerEvent):void {
			for each (var obj:Object in delayDic) {
				if (getTimer() >= (obj.start + obj.count)) {
					var func:Function = obj.callback;
					func.apply(null, obj.arg);
					delayDic[obj.key] = null;
					delete delayDic[obj.key];
				}
			}
		}

		/**
		 * 延时执行
		 * @param time 延时(毫秒)
		 * @param func 函数
		 * @param arg 参数
		 *
		 */
		public static function doDelay(deley:Number, func:Function, args:Array = null):int {
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
