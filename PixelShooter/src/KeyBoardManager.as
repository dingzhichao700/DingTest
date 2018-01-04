package {
	import flash.display.Stage;
	import flash.events.KeyboardEvent;
	
	import util.EventName;
	
	import utils.Dispatcher;

	public class KeyBoardManager {
		public function KeyBoardManager() {
		}

		public static function initStage(stage:Stage):void {
			stage.addEventListener(KeyboardEvent.KEY_DOWN, keyDown);
			stage.addEventListener(KeyboardEvent.KEY_UP, keyUp);
		}
		
		private static function keyDown(e:KeyboardEvent):void {
			Dispatcher.dispatch(EventName.KEY_DOWN, e.keyCode);
		}
		
		private static function keyUp(e:KeyboardEvent):void {
			Dispatcher.dispatch(EventName.KEY_UP, e.keyCode);
		}
	}
}
