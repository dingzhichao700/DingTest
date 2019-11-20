package gameClient.manager.window
{
	import gameClient.view.character.CharacterPanel;
	import gameClient.view.login.view.LoginPanel;

	/**
	 * 窗口 注册
	 * @author ding
	 * 
	 */	
	public class RegistWindow
	{
		public function RegistWindow()
		{
		}
		
		/**注册所有窗口*/
		public static function regist():void {
			registWindow(WindowName.LOGIN_PANEL, LoginPanel);
			registWindow(WindowName.CHARACTER_PANEL, CharacterPanel);
		}
		
		/**
		 * 注册窗口 
		 * @param _windowName 窗口名
		 * @param _windowClass 绑定类
		 * 
		 */		
		private static function registWindow(_windowName:String, _windowClass:Class):void {
			WindowManager.instance.registBaseWindow(_windowName, _windowClass);
		}
	}
}