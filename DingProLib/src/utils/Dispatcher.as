package utils {
	import flash.utils.Dictionary;

	public class Dispatcher {

		private static var eventDic:Dictionary;

		public function Dispatcher() {
		}

		public static function addListener(eventName:String, func:Function):void {
			eventDic ||= new Dictionary();
			if (!eventDic[eventName]) {
				var arr:Array = [];
				arr.push(func);
				eventDic[eventName] = arr;
			} else {
				eventDic[eventName].push(func);
			}
		}

		public static function dispatch(eventName:String, ... params):void {
			if (eventDic && eventDic[eventName]) {
				var arr:Array = eventDic[eventName];
				for (var i:int = 0; i < arr.length; i++) {
					arr[i].apply(null, params);
				}
			}
		}

		public static function offListener(eventName:String, func:Function):void {
			if (eventDic && eventDic[eventName]) {
				var arr:Array = eventDic[eventName];
				for (var i:int = 0; i < arr.length; i++) {
					if (arr[i] == func) {
						arr.splice(i, 1);
					}
				}
			}
		}

	}
}
