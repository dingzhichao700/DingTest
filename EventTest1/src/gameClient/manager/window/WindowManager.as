package gameClient.manager.window
{
	import flash.utils.Dictionary;
	

	/**
	 * 窗口管理 
	 * @author ding
	 * 
	 */	
	public class WindowManager
	{
		private var _registDic:Dictionary;
		private var _openingArr:Array;
		
		public function WindowManager()
		{
			_registDic = new Dictionary();
			_openingArr = new Array();
		}
		
		/**
		 * 打开窗口
		 * @param _windowName 窗口名
		 * @param data 数据
		 * 
		 */		
		public static function openWindow(_windowName:String, data:Object = null):void {
			if(!_instance){
				trace("窗口尚未初始化");
				return;
			}
			if(!_instance._registDic[_windowName]){
				trace("窗口" + _windowName + "不存在");
			}
			var findBoo:Boolean;
			for(var i:int in _instance._openingArr){
				if(_instance._openingArr[i] is WindowVo(_instance._registDic[_windowName]).windowClass){
//					trace("窗口 " + _windowName + " 已打开");
					findBoo = true;
					return;
				}
			}
			if(!findBoo)
			{
				var vo:WindowVo = _instance.registDic[_windowName] as WindowVo;
				var baseWindow:BaseWindow = new vo.windowClass();
				baseWindow.initWindowData(vo.windowName, data);
				_instance._openingArr.push(baseWindow);
			}
		}
		
		/**
		 * 关闭窗口 
		 * @param _windowName 窗口名
		 * 
		 */		
		public static function closeWindow(_windowName:String):void {
			for(var i:int = 0; i < _instance._openingArr.length; i++) {
				if(BaseWindow(_instance._openingArr[i]).windowName == _windowName){
					BaseWindow(_instance._openingArr[i]).clearWindowData();
					_instance._openingArr.splice(i, 1);
				}
			}
		}
		
		/**
		 * 注册基本窗口 
		 * @param _windowName 窗口名
		 * @param _windowClass 绑定类
		 * 
		 */		
		public function registBaseWindow(_windowName:String, _windowClass:Class):void {
			_registDic[_windowName] = new WindowVo(_windowName, _windowClass);
			trace("注册窗口：" +_windowName　+ ", 绑定：" +  _windowClass);
		}
		
		public function get registDic():Dictionary {
			return _registDic;
		}
		
		private static var _instance:WindowManager
		public static function get instance():WindowManager {
			if(!_instance){
				_instance = new WindowManager();
			}
			return _instance; 
		}
	}
}