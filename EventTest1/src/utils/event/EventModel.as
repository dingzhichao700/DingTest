package utils.event
{
	import flash.events.IEventDispatcher;
	
	/**
	 * 事件模型 
	 * @author ding
	 * 
	 */	
	public class EventModel 
	{
		private var _target:IEventDispatcher;
		private var _eventType:String;
		private var _listener:Function;
		
		public function EventModel(target:IEventDispatcher, eventType:String, listener:Function) {
			_target = target;
			_eventType = eventType;
			_listener = listener;
		}
		
		public function get target():IEventDispatcher
		{
			return _target;
		}
		
		public function get eventType():String
		{
			return _eventType;
		}
		
		public function get listener():Function
		{
			return _listener;
		}
		
		public function dispose():void
		{
			_target = null;
			_eventType = null;
			_listener = null;
		}
	}
}
