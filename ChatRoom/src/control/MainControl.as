package control {
	import tool.EventName;

	public class MainControl extends BaseControl {

		public function MainControl() {
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
