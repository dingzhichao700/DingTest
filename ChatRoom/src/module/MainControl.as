package module {
	import tool.BaseControl;
	import tool.EventName;

	public class MainControl extends BaseControl {

		public function MainControl() {
		}
		
		private static var _instance:MainControl;
		
		public static function getInstance():MainControl {
			_instance ||= new MainControl;
			return _instance;
		}

		override protected function addEventHandler():void {
			super.addEventHandler();
			addEventListener(EventName.LOGIN_SUCCESS, onLogin);
		}

		private function onLogin(token:int, time:Number):void {
			trace("1");
		}
	}
}
