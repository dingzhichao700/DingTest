package tool  {

	public class BaseControl {
		public function BaseControl() {
			this.addEventHandler();
			this.addCmdHandler();
		}

		public function addEventListener(eventName:String, handler:Function):void {
			GameBus.getInstance().addMsgListener(eventName, handler);
		}

		protected function addEventHandler():void {
		}

		protected function addCmdHandler():void {
		}

		public function dispatchMsg(msgName:String, ... arg):void {
			GameBus.getInstance().dispatchMsg(msgName, arg);
		}
	}
}