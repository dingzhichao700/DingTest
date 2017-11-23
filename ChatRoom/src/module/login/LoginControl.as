package module.login {
	import tool.BaseControl;
	import tool.EventName;

	public class LoginControl extends BaseControl {

		private var loginView:LoginWindow;
		private static var _instance:LoginControl;

		public static function getInstance():LoginControl {
			_instance ||= new LoginControl;
			return _instance;
		}

		public function LoginControl() {
		}

		override protected function addEventHandler():void {
			super.addEventHandler();
			addEventListener(EventName.GAME_START, onStart);
			addEventListener(EventName.CONNECT_SUCCESS, onSuccess);
			addEventListener(EventName.CONNECT_FAIL, onFail);
		}
		
		public function openLoginView():void {
			loginView ||= new LoginWindow();
			loginView.open();
		}
		
		private function onStart():void {
			openLoginView();
		}
		
		private function onSuccess():void {
			if(loginView && loginView.pop){
				loginView.showSuccess();
			}
		}
		
		private function onFail(str:String):void {
			if(loginView && loginView.pop){
				loginView.showFail(str);
			}
		}
	}
}
