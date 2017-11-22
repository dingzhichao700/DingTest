package control {
	import flash.utils.Dictionary;

	public class EventBus {

		private var eventDic:Dictionary;
		private static var _instance:EventBus;

		public static function getInstance():EventBus {
			_instance ||= new EventBus()
			return _instance;
		}

		public function EventBus() {
			eventDic = new Dictionary();
		}

		public function addMsgListener(msgName:String, handler:Function):void {
			if(!eventDic[msgName]) {
				var arr:Array = [];
				arr.push(handler);
				eventDic[msgName] = arr;
			} else {
				(eventDic[msgName] as Array).push(handler);
			}
		}

		public function dispatchMsg(msgName:String, ... arg):void {
			if(eventDic[msgName]) {
				var arr:Array = eventDic[msgName];
				for(var i:int = 0; i < arr.length; i++) {
					(arr[0] as Function).apply(null, arg);
				}
			}
		}
	}
}
