package gameClient.manager.event
{
	import flash.utils.Dictionary;

	public class EventBus
	{
		private static var dic:Dictionary = new Dictionary();
		
		public function EventBus()
		{
		}
		
		/**
		 * 注册消息 
		 * @param EventName 消息名
		 * @param callBack 回调方法
		 * 
		 */		
		public static function registMsg(mEventType:String, mCallBack:Function):void {
			var vo:EventVo = new EventVo(mEventType, mCallBack);
			dic[vo.eventName] = vo;
		}
		
		/**
		 * 抛出消息 
		 * @param mEventName
		 * @data 要传的数据
		 */		
		public static function sendMsg(mEventType:String, data:Object = null):void{
			if(dic[mEventType]){
				var events:GameEvent = new GameEvent(mEventType, data);
				EventVo(dic[mEventType]).callBack(events);
			}
		}
		
		/**
		 * 移除消息 
		 * @param mEventName
		 * 
		 */		
		public static function removeMsg(mEventType:String):void{
			if(dic[mEventType]){
				delete dic[mEventType];
			}
		}
	}
}