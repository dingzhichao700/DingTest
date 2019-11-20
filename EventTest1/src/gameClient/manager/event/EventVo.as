package gameClient.manager.event
{
	/**
	 * 事件vo
	 * @author ding
	 * 
	 */	
	public class EventVo
	{
		private var _eventName:String;
		private var _callBack:Function;
		
		public function EventVo(mEventName:String, mCallBack:Function)
		{
			_eventName = mEventName;
			_callBack = mCallBack;
		}
		
		public function get eventName():String {
			return _eventName;
		}
		
		public function get callBack():Function {
			return _callBack;
		}
	}
}