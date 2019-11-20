package gameClient.manager.window
{
	/**
	 * 窗口类vo 
	 * @author ding
	 * 
	 */	
	public class WindowVo
	{
		private var _windowName:String;
		
		private var _windowClass:Class;
		
		public function WindowVo(mName:String, mClass:Class)
		{
			_windowName = mName;
			_windowClass = mClass;
		}
		
		/**窗口名*/
		public function get windowName():String {
			return _windowName;
		}
		
		/**绑定类*/
		public function get windowClass():Class {
			return _windowClass;
		}
	}
}