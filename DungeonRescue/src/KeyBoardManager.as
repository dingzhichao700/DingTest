package {
	import flash.display.Stage;
	import flash.events.KeyboardEvent;
	
	import utils.Dispatcher;

	public class KeyBoardManager {
		
		private var _stage:Stage;
		
		private static var instance:KeyBoardManager;
		public static function getInstance():KeyBoardManager {
			instance ||= new KeyBoardManager();
			return instance;
		}
		
		public function KeyBoardManager() {
		}
		
		public function init(stage:Stage):void {
			_stage = stage;
			_stage.addEventListener(KeyboardEvent.KEY_DOWN, onDown);
			_stage.addEventListener(KeyboardEvent.KEY_UP, onUp);
		}
		
		private function onDown(e:KeyboardEvent):void {
//			trace(e.keyCode);
			Dispatcher.dispatch(KeyEvent.KEY_DOWN, e);
		}
		
		private function onUp(e:KeyboardEvent):void {
//			trace(e.keyCode);
			Dispatcher.dispatch(KeyEvent.KEY_UP, e);
		}
			
	}
}
