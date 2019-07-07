package util {
	import flash.display.Sprite;

	public class BaseView extends Sprite {

		public var LAYER_TYPE:int = WindowManager.LAYER_PANEL1;

		public function BaseView() {
		}

		public function open():void {
			WindowManager.ins.openWindow(this);
		}

		public function onOpen():void {
		}

		public function close():void {
			WindowManager.ins.closeWindow(this);
		}
		
		public function onClose():void {
		}
		
	}
}
