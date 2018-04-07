package event {
	import flash.utils.Dictionary;
	import event.vo.EventVo;

	/**
	 * 事件总线
	 * @author dingzhichao
	 *
	 */
	public class GameBus {

		private static var eventDic:Dictionary;

		public function GameBus() {
		}

		/**
		 * 注册消息
		 * @param msg 消息名
		 * @param callback 回调方法
		 * @param data 附加数据
		 *
		 */
		public static function registMsg(msg:String, callback:Function):void {
			if (!eventDic) {
				eventDic = new Dictionary();
			}
			if (!eventDic[msg]) {
				eventDic[msg] = new Array();
			}
			(eventDic[msg] as Array).push(new EventVo(msg, callback));
		}

		/**
		 * 抛出消息
		 * @param msg
		 *
		 */
		public static function sendMsg(msg:String, data:* = null):void {
			if (eventDic[msg]) {
				var arr:Array = eventDic[msg] as Array;
				for (var i:int in arr) {
					arr[i].callback(new GameEvent(msg, data));
				}
			}
		}

		/**
		 * 注销一条消息
		 * @param msg 消息名
		 *
		 */
		public static function cancelMsg(msg:String):void {
			if (eventDic[msg]) {
				delete eventDic[msg];
			}
		}
	}
}
