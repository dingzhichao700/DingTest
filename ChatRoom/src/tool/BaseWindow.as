package tool {
	import flash.display.Sprite;

	import module.MainModel;

	public class BaseWindow extends Sprite {

		private var _pop:Boolean;

		public function BaseWindow() {
		}

		public function open():void {
			if(!_pop) {
				_pop = true;
				MainModel.getInstance().stage.addChild(this);
			}
		}

		public function close():void {
			if(_pop) {
				_pop = false;
				MainModel.getInstance().stage.removeChild(this);
			}
		}

		public function get pop():Boolean {
			return _pop;
		}
	}
}
