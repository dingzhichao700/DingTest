package util {
	import flash.display.Sprite;
	import flash.display.Stage;

	public class WindowManager {

		public static const LAYER_BOTTOM:int = 0;
		public static const LAYER_PANEL1:int = 1;
		public static const LAYER_PANEL2:int = 2;

		private var layer_bottom:Sprite;
		private var layer_panel1:Sprite;
		private var layer_panel2:Sprite;

		private static var _ins:WindowManager;

		public static function get ins():WindowManager {
			_ins ||= new WindowManager();
			return _ins;
		}

		public function WindowManager() {
		}

		public function init(stage:Stage):void {
			layer_bottom = new Sprite();
			stage.addChild(layer_bottom);

			layer_panel1 = new Sprite();
			stage.addChild(layer_panel1);

			layer_panel2 = new Sprite();
			stage.addChild(layer_panel2);
		}

		/**打开窗口*/
		public function openWindow(view:BaseView):void {
			var targetLayer:Sprite;
			switch (view.LAYER_TYPE) {
				case LAYER_BOTTOM:
					targetLayer = layer_bottom;
					break;
				case LAYER_PANEL1:
					targetLayer = layer_panel1;
					break;
				case LAYER_PANEL2:
					targetLayer = layer_panel2;
					break;
			}
			targetLayer.addChild(view);
			view.onOpen();
		}

		/**关闭窗口*/
		public function closeWindow(view:BaseView):void {
			var targetLayer:Sprite;
			switch (view.LAYER_TYPE) {
				case LAYER_BOTTOM:
					targetLayer = layer_bottom;
					break;
				case LAYER_PANEL1:
					targetLayer = layer_panel1;
					break;
				case LAYER_PANEL2:
					targetLayer = layer_panel2;
					break;
			}
			if (targetLayer.contains(view)) {
				targetLayer.removeChild(view);
				view.onClose();
			}
		}

	}
}
