package event.vo
{
	/**
	 * 消息VO 
	 * @author dingzhichao
	 * 
	 */	
	public class EventVo
	{
		/**消息*/		
		private var _msg:String;
		/**回调方法*/
		private var _callback:Function;
		
		public function EventVo(mMsg:String, mCallback:Function)
		{
			_msg = mMsg;
			_callback = mCallback;
		}
		
		public function get callback():Function  {
			return _callback;
		}
	}
}