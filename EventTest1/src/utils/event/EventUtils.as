package utils.event
{
	import flash.events.IEventDispatcher;
	/**
	 * 事件管理类
	 * @author Robin
	 */
	public class EventUtils 
	{
		private static var _list:Vector.<EventModel> = new Vector.<EventModel>();
		
		public function EventUtils(){
		}
		
		/**
		 * 添加监听事件
		 * @param        target
		 * @param        eventType
		 * @param        listener
		 */
		public static function addEventListener(target:IEventDispatcher, eventType:String, listener:Function):void
		{
			if (target&&listener&&eventType&&eventType.length>0)
			{
				var eventMode:EventModel = new EventModel(target, eventType, listener);
				target.addEventListener(eventType,listener,false,0,true)
				_list.push(eventMode);
			}
		}
		
		/**
		 * 删除监听事件
		 * @param        target
		 * @param        eventType
		 * @param        listener
		 */
		public static function removeEventListener(target:IEventDispatcher, eventType:String, listener:Function):void
		{
			for (var i:int = _list.length-1; i >=0; i-- )
			{
				var item:EventModel = _list[i];
				if (item)
				{
					if (item.target == target && item.eventType == eventType && item.listener == listener)
					{
						if (item.target)
						{
							item.target.removeEventListener(item.eventType, item.listener);
							_list.splice(i, 1);
							//break;
						}
					}
				}
			}
		}
		
		/**
		 * 删除指定对象的所有监听事件
		 * @param        target
		 */
		public static function removeTargetAllEventListener(target:IEventDispatcher):void
		{
			for (var i:int = _list.length - 1; i >= 0; i-- )
			{
				var item:EventModel = _list[i];
				if (item)
				{
					if (item.target == target)
					{
						if (item.target)
						{
							item.target.removeEventListener(item.eventType, item.listener);
						}
						_list.splice(i, 1);
					}
				}
			}
		}
		
		/**
		 * 删除所有监听事件
		 */
		public static function removeAllEventListener():void
		{
			if (_list == null) 
			{
				return;
			}
			while (_list.length > 0)
			{
				var item:EventModel = _list.shift();
				if (item)
				{
					var target:IEventDispatcher = item.target;
					var eventType:String = item.eventType;
					var listener:Function = item.listener;
					target.removeEventListener(eventType, listener);
					item.dispose();
					item = null;
				}
			}
		}
		/**
		 * 对象被销毁时，调用该方法
		 */
		public static function dispose():void
		{
			removeAllEventListener();
			_list = null;
		}
		
	}
	
}